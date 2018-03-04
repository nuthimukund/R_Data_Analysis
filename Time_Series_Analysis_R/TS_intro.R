library(TSstudio)
library(xts) 
library(zoo)

#Loading dataset from web.
ts_raw <- scan("http://robjhyndman.com/tsdldata/data/fancy.dat")

timeseries <- ts(ts_raw, frequency=12, start=c(1987,1))

timeseries

ts_plot(timeseries)

#Seasonality Plots

ts_seasonal(timeseries, type = "normal")
ts_seasonal(timeseries, type = "cycle")
ts_seasonal(timeseries, type = "box")

#HeatMaps

ts_heatmap(timeseries)
ts_surface(timeseries)


#Polar Plots
ts_polar(timeseries)

#Splitting dataset into training and testing
test_months <- 12
split_timeseries <- ts_split(timeseries, sample.out = test_months)
train <- split_timeseries$train
test <- split_timeseries$test

#TIME SERIES FORECASTING 

library(forecast)

fit <- auto.arima(train, lambda = BoxCox.lambda(train))

# Plotting Residuals for ARIMA
check_res(fit)

# Forescasting on Test Data
fc <- forecast(fit, h = test_months)

#Plotting the Forecast using TSStudio
test_forecast(actual = timeseries, forecast.obj = fc, test = test)
