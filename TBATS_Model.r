# TBATS Method

# Fit a TBATS model to the gas data
fit_tbats <- tbats(train,num.cores = 4,biasadj = TRUE)
fit_tbats

# Forecast the series for the next 5 years
fc <- forecast(fit_tbats, h = 12)

# Plot the forecasts
autoplot(fc)

# Check Residuals
residuals_tbats <- residuals(fit_tbats)

# Plot ACF and PACF of residuals
par(mfrow = c(2, 1))
ggAcf(residuals_tbats, lag.max = 20, main = "ACF of Residuals", )

ggPacf(residuals_tbats, lag.max = 20, main = "PACF of Residuals")

par(mfrow = c(1, 1))

# Check for Normality
shapiro_test <- shapiro.test(residuals_tbats)
cat("Shapiro-Wilk Test for Normality of Residuals:\n", "W =", shapiro_test$statistic, ", p-value =", shapiro_test$p.value, "\n")

# Check for Homoscedasticity
plot(residuals_tbats ~ fitted(fit_tbats), main = "Residuals vs. Fitted Values")

# Check for Autocorrelation in Residuals
Box.test(residuals_tbats, lag = 20, type = "Ljung-Box")

# Plot the forecast with custom x-axis limits
autoplot(Cpi_data_ts) +
  xlim(c(2015, 2022)) + ylim(c(200,350))+ 
autolayer(fc)

accuracy(fc, Cpi_data_ts)

