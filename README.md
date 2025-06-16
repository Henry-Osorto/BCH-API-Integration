[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](http://creativecommons.org/licenses/by/4.0/)

# BCH-API-Integration

Integration of the Central Bank of Honduras (BCH) Web API into R for economic forecasting using time series models.

This repository provides a reproducible pipeline for accessing and analyzing inflation data (CPI) from the BCH Web API using R. It demonstrates how to retrieve time series data programmatically, apply multiple forecasting models (ARIMA, SES, Holt-Winters, Prophet, Random Forest, and XGBoost), and evaluate their performance using standard error metrics (RMSE, MAE, and MAPE).

The workflow is designed for **reproducibility**, **automation**, and potential integration into **academic** or **policy-oriented** research projects.

## Features

- JSON-based API data retrieval from the BCH
- Time series structuring and preprocessing
- Implementation of six forecasting models
- Comparative model evaluation and error metrics
- Publication-quality PDF plot generation
- Ready-to-integrate in reproducible research pipelines

## Requirements

- R (≥ 4.0)
- Required R packages:  
  `jsonlite`, `dplyr`, `tibble`, `reshape2`, `ggplot2`, `forecast`, `prophet`, `randomForest`, `xgboost`, `glue`

## Languages / Idiomas

Two versions of the forecasting script are available:

- [`bch_forecasting_en.R`](bch_forecasting_en.R): English version of the script (plots and labels in English).
- [`bch_forecasting_es.R`](bch_forecasting_es.R): Versión en español del script (gráficos y etiquetas en español).

## How to Run

1. **Clone the repository:**

```bash
git clone https://github.com/Henry-Osorto/BCH-API-Integration.git
cd BCH-API-Integration
```

2. Open the script of your choice in RStudio (bch_forecasting_en.R or bch_forecasting_es.R).

3. Replace the placeholder API key in the script:
   api_key <- "your_api_key_here"

4. Run the script. It will:
- Retrieve inflation data from the BCH API
- Apply six time series forecasting models
- Compute performance metrics (MAE, RMSE, MAPE)
- Generate a comparative PDF chart of actual vs. predicted values
- Save both the plot and a CSV file with error metrics in your working directory

## License

This repository is licensed under the Creative Commons Attribution 4.0 International License (CC BY 4.0).
See the LICENSE.md file for full details.

## Author

Henry Osorto
