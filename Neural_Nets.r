# Neural Nets


nn_fit <- nnetar(train,size = 25, decay = .0004, maxit=50000, repeats = 100)
print(nn_fit)

nn_forecast = forecast(nn_fit,PI=TRUE, h = 12)

autoplot(Cpi_data_ts) + autolayer(nn_forecast)

# Check Residuals
residuals_nn <- residuals(nn_forecast)

# Plot ACF and PACF of residuals
par(mfrow = c(2, 1))
ggAcf(residuals_nn, lag.max = 20,  na.action = na.pass)

ggPacf(residuals_nn, lag.max = 20, na.action = na.pass)

par(mfrow = c(1, 1))

# Check for Normality
shapiro_test <- shapiro.test(residuals_nn)
cat("Shapiro-Wilk Test for Normality of Residuals:\n", "W =", shapiro_test$statistic, ", p-value =", shapiro_test$p.value, "\n")

# Plot the forecast with custom x-axis limits
autoplot(Cpi_data_ts) +
  xlim(c(2015, 2022)) + ylim(c(200,350))+ 
autolayer(nn_forecast)

accuracy(nn_forecast, Cpi_data_ts)

