# 6.  Model Identification

pkg <- "package:TSA"
detach(pkg, character.only = TRUE)


fit1 <- arima(train, order = c(0, 1, 1), seasonal = list(order = c(0, 0, 0), period = 12))
print(fit1)

fit2 <- arima(train, order = c(2, 1, 2), seasonal = list(order = c(0, 0, 0), period = 12))
print(fit2)

fit3 <- arima(train, order = c(1, 1, 1), seasonal = list(order = c(2, 0, 2), period = 12))
print(fit3)

fit4 <- arima(train, order = c(3, 1, 1), seasonal = list(order = c(2, 0, 2), period = 12))
print(fit4)

fit5 <- arima(train, order = c(3, 1, 3), seasonal = list(order = c(2, 0, 2), period = 12))
print(fit5)

fit6 <- arima(train, order = c(1, 1, 3), seasonal = list(order = c(2, 0, 2), period = 12))
print(fit6)

fit7 <- arima(train, order = c(1, 1, 1), seasonal = list(order = c(2, 0, 1), period = 12))
print(fit7)

fit8 <- arima(train, order = c(1, 1, 1), seasonal = list(order = c(1, 0, 1), period = 12))
print(fit8)

fit9 = auto.arima(train)
summary(fit9)

# 7.  Model Diagnostic
# Residuals
residuals <- residuals(fit8)

# Portmanteau Lack of Fit Test
portmanteau_test <- Box.test(residuals, lag = 1, type = "Ljung-Box")
cat("Portmanteau Lack of Fit Test (Ljung-Box):\n")
print(portmanteau_test)

# Perform Breusch-Godfrey test
bg_test_result <- bgtest(residuals ~ train, order = 12)  
bg_test_result

# ACF and PACF plots of the residuals
par(mfrow = c(2, 1))
ggAcf(residuals, lag.max = 12, main = "ACF of Residuals")

ggPacf(residuals, lag.max = 12, main = "PACF of Residuals")

standardized_residuals <- residuals / fit8$sigma

ggplot2::autoplot(standardized_residuals)+
  labs(x = "Time", y = "Standardized Residuals")

# Histogram
hist_plot <- ggplot(data.frame(Standardized_Residuals = standardized_residuals), aes(x = Standardized_Residuals)) +
  geom_histogram(binwidth = 0.2, fill = "blue", color = "black", alpha = 0.7) +
  labs(x = "Standardized Residuals", y = "Frequency", title = "Histogram of Standardized Residuals")

# QQ-plot
qq_plot <- ggplot(data.frame(Standardized_Residuals = standardized_residuals), aes(sample = Standardized_Residuals)) +
  geom_qq() +
  geom_qq_line(color = "blue") +
  labs(title = "QQ-Plot of Standardized Residuals")

# Print histogram and QQ-plot
print(hist_plot)

print(qq_plot)

# Calculate squared residuals
squared_residuals <- residuals^2
# ACF-PACF plots of squared residuals
par(mfrow = c(2, 1))
ggAcf(squared_residuals, lag.max = 20)+ labs(title = "ACF of Squared Residuals")

ggPacf(squared_residuals, lag.max = 20)+ labs(title = "PACF of Squared Residuals")

# Engle's ARCH Test
library(FinTS)

arch_test_result <- ArchTest(resid(fit8)/sd(residuals(fit8)))  # You can specify a different lag order if needed
arch_test_result

# Create a forecast for the next 12 periods
forecast_values <- forecast(fit8, h = 12)
autoplot(forecast_values)

# Plot the forecast with custom x-axis limits
autoplot(Cpi_data_ts) +
  xlim(c(2015, 2022)) + ylim(c(200,350))+ 
autolayer(forecast_values)

fc_sarima = forecast(fit8,12)

accuracy(fc_sarima, Cpi_data_ts)

