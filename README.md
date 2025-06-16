# BCH-API-Integration

Integration of the Central Bank of Honduras Web API into R for economic forecasting using time series models.

This repository contains a reproducible pipeline for accessing and analyzing inflation data from the Central Bank of Honduras (BCH) Web API using R. It demonstrates how to retrieve time series data programmatically, apply forecasting models (ARIMA, SES, Holt-Winters, Prophet, Random Forest, and XGBoost), and compare their performance using RMSE, MAE, and MAPE.

The workflow is designed for reproducibility and scalability, enabling automated monthly updates and integration into academic or policy-oriented research.

## Features

- JSON-based API data retrieval from the BCH
- Preprocessing and time series structuring
- Implementation of six forecasting models
- Comparative model evaluation and visualization
- Integration-ready for reproducible research

## Requirements

- R (≥ 4.0)
- R packages: `jsonlite`, `dplyr`, `tibble`, `reshape2`, `ggplot2`, `forecast`, `prophet`, `randomForest`, `xgboost`

## How to Run

1. Clone the repository:
git clone https://github.com/Henry-Osorto/BCH-API-Integration.git


2. Open the script `bch_forecasting.R` in RStudio.

3. Replace your BCH API key in the code:
```r
api_key <- "your_api_key_here"
```

4. Run the script to reproduce the full forecasting workflow.

License

MIT License.
Author

Henry Osorto

