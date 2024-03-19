---

# Time Series Forecasting with State-of-the-Art Models

Time series forecasting has garnered significant attention in recent decades, with researchers striving to statistically and mathematically capture patterns inherent in time series datasets. While existing models outlined in literature have demonstrated proficiency in capturing data patterns, they often struggle with complex datasets or may be ineffective with small data samples.

In this project, the aim is to delve into and compare the performance of state-of-the-art models concerning univariate Consumer Price Index (CPI) datasets sourced from the [US Bureau of Labor Statistics](https://datasource.kapsarc.org/explore/dataset/consumer-price-index4/information/). Through this investigation, we aim to assess the efficacy of various forecasting techniques in handling real-world economic data.

## Dataset
The dataset utilized in this project is the Consumer Price Index (CPI) obtained from the US Bureau of Statistics. It encompasses a time series of economic indicators, crucial for understanding inflation trends within the US economy.

## Goals
- Investigate state-of-the-art time series forecasting models.
- Compare the performance of these models on CPI datasets.
- Assess the capability of each model to handle complex or limited data scenarios.


## Models Explored
- S/ARIMA, GARCH, TBATS, Exponential Smoothing, META's PROPHET, Neural Nets, and LSTM

## Results
Performance Metrics on the Test Set:
| Model Name            |   ME    | RMSE |  MAE  |  MPE  |  MAPE |  MASE |  ACF1 |
|-----------------------|---------|------|-------|-------|-------|-------|-------|
| SARIMA                |   4.54  |  6.3 |  4.58 |  1.6  |  1.62 |  0.99 |  0.78 |
| GARCH                 |   4.22  | 5.61 |  4.22 |  1.49 |  1.49 |  0.78 |  3.58 |
| TBATS                 |   3.48  |  5.1 |  3.73 |  1.22 |  1.32 |  0.81 |  0.78 |
| Exponential Smoothing |   4.07  | 5.43 |  4.07 |  1.44 |  1.44 |  0.88 |  0.78 |
| PROPHET               |   9.11  | 10.16|  9.11 |  3.25 |  3.25 |  0.78 |   NA  |
| Neural Nets           |   6.75  | 8.49 |  6.75 |  2.39 |  2.39 |  1.47 |  0.78 |
| LSTM                  | -0.234  | 0.711|  0.596|  0.081|  0.214|   NA  |   NA  |

Best Metrics were achieved by the LSTM model.
---
Time Series Graphs of the Best Model:





---

Feel free to adjust or expand upon any section to better suit your project's needs.
