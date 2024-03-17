# Prophet Method

library(prophet)

# Assuming CPI is your vector
# Convert it to a data frame with dates and values
cpi_data <- data.frame(
  ds = seq(as.Date("1970-01-01"), by = "month", length.out = length(food_cpi_lst)),
  y = food_cpi_lst
)

cpi_data$ds <- as.Date(cpi_data$ds)

# Split the data into training and test sets
train_data <- cpi_data[cpi_data$ds < as.Date("2021-01-01"), ]
test_data <- cpi_data[cpi_data$ds >= as.Date("2021-01-01"), ]

# Fit the prophet model on the training set
model <- prophet(train_data)
summary(model)

# Make a future dataframe for forecasting (including the test period)
future <- make_future_dataframe(model, periods = nrow(test_data), freq = 'month')

# Generate forecasts
forecast <- predict(model, future)


accuracy(tail(forecast$yhat,12),test)

#Train Accuracy
all_except_last_12 <- forecast$yhat[1:(length(forecast$yhat) - 12)]
accuracy(all_except_last_12,train)

residuals_training <- with(cpi_data, y - forecast$yhat)# Check for Normality
shapiro_test <- shapiro.test(residuals_training)
cat("Shapiro-Wilk Test for Normality of Residuals:\n", "W =", shapiro_test$statistic, ", p-value =", shapiro_test$p.value, "\n")

# Check for Autocorrelation in Residuals
Box.test(residuals_training, lag = 20, type = "Ljung-Box")

dyplot.prophet(model,forecast)

