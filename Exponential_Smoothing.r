# Exponential Smoothing
fit_ets <- ets(train)
# Use summary() to see the model parameters
summary(fit_ets)

# Check Residuals
residuals_ets <- residuals(fit_ets)

# Plot ACF and PACF of residuals
par(mfrow = c(2, 1))
ggAcf(residuals_ets, lag.max = 20,  na.action = na.pass)

ggPacf(residuals_ets, lag.max = 20, na.action = na.pass)

par(mfrow = c(1, 1))

# Check for Normality
shapiro_test <- shapiro.test(residuals_ets)
cat("Shapiro-Wilk Test for Normality of Residuals:\n", "W =", shapiro_test$statistic, ", p-value =", shapiro_test$p.value, "\n")

autoplot(forecast(fit_ets, h = 12*5))

accuracy(forecast(fit_ets, h = 12), Cpi_data_ts)

