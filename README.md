# BCH-API-Integration

Integration of the Central Bank of Honduras Web API into R for economic forecasting using time series models.

This repository contains a reproducible pipeline for accessing and analyzing inflation data from the Central Bank of Honduras (BCH) Web API using R. It demonstrates how to retrieve time series data programmatically, apply forecasting models (ARIMA, SES, Holt-Winters, Prophet, Random Forest, and XGBoost), and compare their performance using RMSE, MAE, and MAPE.

The workflow is designed for reproducibility and scalability, enabling automated monthly updates and integration into academic or policy-oriented research.

## Features

- JSON-based API data retrieval from the BCH
- Preprocessing and time series structuring
- Implementation of six forecasting models
- Comparative model evaluation and visualization
- Output saved as a publication-quality PDF figure
- Integration-ready for reproducible research

## Requirements

- R (≥ 4.0)
- R packages: `jsonlite`, `dplyr`, `tibble`, `reshape2`, `ggplot2`, `forecast`, `prophet`, `randomForest`, `xgboost`, `glue`

## Languages / Idiomas

Two versions of the forecasting script are available:

- [`bch_forecasting_en.R`](bch_forecasting_en.R): English version of the script with plot titles and captions in English.
- [`bch_forecasting_es.R`](bch_forecasting_es.R): Versión en español del script, con los títulos y etiquetas del gráfico en español.

## How to Run

1. Clone the repository:

```bash
git clone https://github.com/Henry-Osorto/BCH-API-Integration.git
cd BCH-API-Integration
```

2. Open the script of your choice in RStudio (bch_forecasting_en.R or bch_forecasting_es.R).
   
3. Replace the placeholder with your BCH API key:
api_key <- "your_api_key_here"

4. Run the script. It will:
- Retrieve inflation data from the BCH API
- Apply six time series forecasting models
- Compute error metrics (MAE, RMSE, MAPE)
- Generate a PDF chart comparing predictions vs. actual inflation
- Save the chart and a CSV file with error metrics in the working directory

## License

MIT License.

## Author

Henry Osorto
