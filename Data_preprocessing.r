pkg <- c('TSA', 'pdR')
install.packages(pkg)

library(aTSA)
library(forecast)
library(tidyverse)
library(tibbletime)
library(anomalize)
library(timetk)
library(TSA)    
library(tidyr)
library(tidyverse)
library(ggplot2)
library(ggfortify)
library(pdR)
library(fUnitRoots)
library(lmtest)
library(tseries)


Food_cpi = read.csv("/kaggle/input/consumer-food-price-index/SeriesReport-FOOD- Consumer Price Index.csv",skip =11, header = TRUE)

time_series_data <- Food_cpi[c(-1,-14,-15)]
time_series_data <- time_series_data[-nrow(time_series_data), ]


# Get the number of rows and columns in the data frame
num_rows <- nrow(time_series_data)
num_cols <- ncol(time_series_data)
food_cpi_lst = c() 

for (i in 1:num_rows) {
  for (j in 1:num_cols) {
    food_cpi_lst = c(food_cpi_lst, time_series_data[[i, j]])
  }
}
Cpi_data_ts <- ts(food_cpi_lst, start = c(1970, 1), frequency = 12)


Cpi_data_ts = tsclean(Cpi_data_ts)
train = window(Cpi_data_ts, start = 1970, end = c(2020,12))
test = window(Cpi_data_ts, start = 2021, end = c(2021,12))
food_cpi_lst_train = food_cpi_lst[1:(length(food_cpi_lst) - 12)]


# Create a tibble with Date and Value columns
food_cpi_tbl <- tibble(
  Date = seq(as.Date("1970-01-01"), by = "month", length.out = length(food_cpi_lst_train)),
  Value = unlist(food_cpi_lst_train)
)

food_cpi_tbl %>%
  time_decompose(Value, method = "stl", frequency = "auto", trend = "auto") %>%
  anomalize(Date, remainder, .iqr_alpha = 0.5, .clean_alpha = 0.2) %>%
  plot_anomalies_decomp(Date)

food_cpi_tbl %>%
  time_decompose(Value, method = "stl", frequency = "auto", trend = "auto") %>%
  anomalize(Date, remainder, .iqr_alpha = 0.05, .clean_alpha = 0.5) %>%
  plot_anomalies(Date)

train = tsclean(train, replace.missing = T, iterate = 5 )


BoxCox.ar(train,method = c("yule-walker"))


autoplot(train)

par(mfrow = c(2,1))
ggAcf(train, lag.max = 32) +
  labs(title = "ACF of Food Consumer Index")

ggPacf(train, lag.max = 5) +
  labs(title = "PACF of Food Consumer Index")

kpss.test(train, null = c('Level'))

kpss.test(train, null = c('Trend'))
mean(train)

sd(train)

adfTest(train, lags=1, type="c")

adfTest(train, lags=1, type="ct")

out<-HEGY.test(wts=train, itsd=c(1,1,0), regvar=0, selectlags=list(mode="signf", Pmax=NULL))

out$stats

library(uroot)
ch.test(train,type = "dummy",sid=c(1:12)) #since we have monthly data, we use sid=c(1:12)

cat('Number of Regular Differencing Needed: ', ndiffs(train), '\n')

cat('Number of Seasonal Differencing Needed: ', nsdiffs(diff(train)), '\n')

diff_train = diff(train)
#diff_train = diff(diff_train, 12)

ch.test(diff_train,type = "dummy",sid=c(1:12)) #since we have monthly data, we use sid=c(1:12)

## Tests After Differencing
kpss.test(diff_train, null = c('Level'))

kpss.test(diff_train, null = c('Trend'))

out<-HEGY.test(wts=diff_train, itsd=c(1,1,0), regvar=0, selectlags=list(mode="signf", Pmax=NULL))
out$stats

####
par(mfrow = c(1,3))
autoplot(diff_train)

ggAcf(diff_train, lag.max = 35) +
  labs(title = "ACF of Food Consumer Index")

# %% [code] {"execution":{"iopub.status.busy":"2024-01-21T13:43:39.505462Z","iopub.execute_input":"2024-01-21T13:43:39.507086Z","iopub.status.idle":"2024-01-21T13:43:39.788348Z"}}
ggPacf(diff_train, lag.max = 35) +
  labs(title = "PACF of Food Consumer Index")

