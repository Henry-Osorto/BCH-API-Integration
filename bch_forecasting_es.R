# BCH API Integration and Forecasting Script (English)
# Author: Henry Osorto
# License: MIT

# 1. Libraries ----
library(tidyverse)
library(jsonlite)
library(forecast)
library(prophet)
library(randomForest)
library(xgboost)
library(tibble)
library(reshape2)
library(glue)

# 2. Parameters ----
api_key <- "YOUR_API_KEY"
indicator_id <- 609
start_year <- 2000
split_ratio <- 0.8
n_trees <- 100
n_rounds <- 100

# 3. Functions ----
fetch_indicator_data <- function(indicator_id, api_key, start_year) {
  url <- glue('https://bchapi-am.azure-api.net/api/v1/indicadores/{indicator_id}/cifras?formato=Json&clave={api_key}')
  raw_data <- fromJSON(url)
  df <- raw_data %>%
    mutate(ds = as.Fecha(Fecha)) %>%
    separate(Fecha, into = c('Year', 'Month', 'Day'), sep = '-') %>%
    filter(Year >= start_year) %>%
    distinct(Year, Month, ds, Valor) %>%
    select(ds, y = Valor) %>%
    arrange(ds)
  return(df)
}

calculate_errors <- function(real, predicted) {
  mae <- mean(abs(real - predicted))
  rmse <- sqrt(mean((real - predicted)^2))
  mape <- mean(abs((real - predicted) / real)) * 100
  return(c(MAE = mae, RMSE = rmse, MAPE = mape))
}

# 4. Data Retrieval ----
df <- fetch_indicator_data(indicator_id, api_key, start_year)

# 5. Train/Test Split ----
n <- nrow(df)
n_train <- floor(split_ratio * n)
train <- df[1:n_train, ]
test <- df[(n_train + 1):n, ]

# 6. Forecasting Modelos ----
results <- list()

# ARIMA
model_arima <- auto.arima(train$y)
pred_arima <- forecast(model_arima, h = nrow(test))$mean
results[["ARIMA"]] <- calculate_errors(test$y, pred_arima)

# SES
model_ses <- ses(train$y, h = nrow(test))
results[["SES"]] <- calculate_errors(test$y, model_ses$mean)

# Holt-Winters
model_les <- holt(train$y, h = nrow(test))
results[["LES"]] <- calculate_errors(test$y, model_les$mean)

# Prophet
prophet_model <- prophet(train, yearly.seasonality = TRUE)
future_dates <- make_future_dataframe(prophet_model, periods = nrow(test), freq = "month")
forecast_prophet <- predict(prophet_model, future_dates)
pred_prophet <- tail(forecast_prophet$yhat, nrow(test))
results[["Prophet"]] <- calculate_errors(test$y, pred_prophet)

# Random Forest
train_rf <- train %>% mutate(lag1 = lag(y)) %>% drop_na()
test_rf <- test %>% mutate(lag1 = lag(y)) %>% drop_na()
model_rf <- randomForest(y ~ lag1, data = train_rf, ntree = n_trees)
pred_rf <- predict(model_rf, newdata = test_rf)
results[["Random Forest"]] <- calculate_errors(test_rf$y, pred_rf)

# XGBoost
X_train <- as.matrix(train_rf$lag1)
y_train <- train_rf$y
X_test <- as.matrix(test_rf$lag1)
model_xgb <- xgboost(data = X_train, label = y_train, nrounds = n_rounds, objective = "reg:squarederror", verbose = 0)
pred_xgb <- predict(model_xgb, X_test)
results[["XGBoost"]] <- calculate_errors(test_rf$y, pred_xgb)

# 7. Results Table ----
error_df <- bind_rows(results, .id = "Modelo")
print(error_df)
write.csv(error_df, "error_metrics.csv", row.names = FALSE)

# 8. Forecast Plot ----
df_pred <- data.frame(
  ds = test_rf$ds,
  Real = test_rf$y,
  ARIMA = pred_arima[1:nrow(test_rf)],
  SES = model_ses$mean[1:nrow(test_rf)],
  LES = model_les$mean[1:nrow(test_rf)],
  Prophet = pred_prophet[1:nrow(test_rf)],
  RandomForest = pred_rf,
  XGBoost = pred_xgb
)

df_long <- df_pred %>% pivot_longer(cols = -ds, names_to = "Modelo", values_to = "Inflation")

colors <- c("black", "red", "blue", "green", "purple", "orange", "brown")

g <- ggplot() +
  geom_line(data = train, aes(x = ds, y = y), color = "black", linetype = "solid") +
  geom_line(data = test_rf, aes(x = ds, y = y), color = "black", linetype = "dashed") +
  geom_line(data = df_long, aes(x = ds, y = Inflation, color = Modelo)) +
  labs(title = "Pronósticos de los Modeloos vs. Inflación Real",
       subtitle = "Entrenamiento hasta 2020, pronósticos del período de prueba",
       x = "Fecha", y = "Inflación Interanual (%)",
       caption = "Nota: Los colores y estilos de línea distinguen entre valores reales y pronosticados.",
       color = "Modeloo") +
  scale_color_manual(values = colors) +
  theme(legend.position = "bottom")

ggsave("forecast_models_english.pdf", plot = g, width = 8, height = 5)
