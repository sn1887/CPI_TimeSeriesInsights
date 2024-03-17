# GARCH MODEL
library(rugarch)

# Create a GARCH specification with the extracted ARMA coefficients
spec <- ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(0, 1)),
                   mean.model = list(armaOrder = c(2, 1),arfima = 1) )

spec=ugarchspec(variance.model = list(model="apARCH",garchOrder = c(0,1)),
                mean.model = list(armaOrder = c(2, 1),arfima = 1) )

print(spec)


def.fit = ugarchfit(spec = spec, data = train,solver ='hybrid')
print(def.fit)

f_garch<-ugarchforecast(def.fit,n.ahead = 12)
s<-as.vector(f_garch@forecast$seriesFor)
accuracy(s,test)

## Train SET Accuracy
accuracy(as.vector(fitted(def.fit)), train)

library(ggplot2)
library(gridExtra)

# Assuming 'def.fit' is your fitted model and 'train' is your observed data
# Make sure that 'def.fit' and 'train' are appropriately defined

# Create a data frame for ggplot
df <- data.frame(Time = time(train), Observed = as.numeric(train), Fitted = as.numeric(fitted(def.fit)))

# Plot observed vs fitted values with ggplot2
plot_observed <- ggplot(df, aes(x = Time)) +
  geom_line(aes(y = Observed), color = 'blue', size = 1) +
  labs(title = 'Observed Values',
       x = 'Time',
       y = 'Value') +
  theme_minimal()

plot_fitted <- ggplot(df, aes(x = Time)) +
  geom_line(aes(y = Fitted), color = 'red', linetype = 'dotted', size = 1) +
  labs(title = 'Fitted Values',
       x = 'Time',
       y = 'Value') +
  theme_minimal()

# Arrange plots side by side
grid.arrange(plot_observed, plot_fitted, ncol = 2)


# Assuming 'test' and 's' are your time series objects
s <- ts(s, frequency = 12)

# Create a data frame for ggplot
df <- data.frame(Time = time(train), Observed = as.numeric(train), Fitted = as.numeric(fitted(def.fit)))

# Plot with ggplot2
ggplot(df, aes(x = Time)) +
  geom_line(aes(y = Observed), color = 'blue', size = 1.5) +
  geom_line(aes(y = Fitted), color = 'red', size = 1, alpha = .4) +
  labs(title = 'Observed vs Fitted Values',
       x = 'Time',
       y = 'Value') +
  theme_minimal()


s <- ts(s, frequency = 12)

# Create a data frame for ggplot
df <- data.frame(Time = time(test), Observed = as.numeric(test), Fitted = as.numeric(s))

# Plot with ggplot2
ggplot(df, aes(x = Time)) +
  geom_line(aes(y = Observed), color = 'blue', size = 1.5) +
  geom_line(aes(y = Fitted), color = 'red', size = 1, alpha = .4) +
  labs(title = 'Observed vs Fitted Values',
       x = 'Time',
       y = 'Value') +
  theme_minimal()