# Import libraries
library(forecast)
require(graphics)
library(tseries)
library(Metrics)
source("forecast_arma.R")
###############
# LOAD DATA
###############
wind_res73 <- readRDS(file = "Wind_res73.rds")
ts_73<-ts(wind_res73, start=2013,  frequency=length(wind_res73)/4)
wr_y1 <- wind_res73[1:(24*365)]
wr_y2 <- wind_res73[(1 + 24*365):(2*24*365)]
wr_y3 <- wind_res73[(1 + 2*24*365):(3*24*365)]
wr_y4 <- wind_res73[(1 + 3*24*365):(4*24*365)]
#########################
# Preliminary Analysis
#########################
# Is the TS stationary?
# Show Time Series and ACF
par(mfrow=c(3,1))
plot(ts_73)
acf(ts_73,lag.max=80)
pacf(ts_73,lag.max=80)
# KPSS test
kpss.test(ts_73) # p-value > 0.1
# Augmented Dickey-Fuller test
adf.test(ts_73, alternative='s') # p-value < 0.01
## We got a stationary TS, let's try different models
#########################
# Model selection
#########################
train_ts <- window(ts_73,start = 2013, end = (2015 - 1e-6))
val_ts <- window(ts_73, start = 2015, end = (2016 - 1e-6))
test_ts = window(ts_73, start = 2016)
par(mfrow=c(2,1))
Acf(train_ts,lag.max=(24*7))
Pacf(train_ts,lag.max=(24*7))
## The ACF is 'sinusoidal' and PACF 'ends' at lag 24, let's try an AR model
#####
# AR(24)
#####
wr.ar24 <- arima(train_ts, order = c(24,0,0),include.mean = FALSE)
saveRDS(wr.ar24,"ar24_73.rds")
checkresiduals(wr.ar24) # p-value < 2.2e-16
###############
# Validate training data size
###############
# 2 year time series
ts_2y <- ts(wind_res73[1:(2*24*365)], start=2013,  frequency=length(wind_res73)/4)
# automatic arma(24,q) model
wrARMAauto2y <- auto.arima(ts_2y, start.p = 24, max.p = 24, max.q = 24, max.order = 50, stationary = TRUE, seasonal = FALSE, stepwise = FALSE)
saveRDS(wrARMAauto2y,"auto_ARMA_24_q_2y.rds")
# 1 year time series
ts_1y <- ts(wind_res73[(1+24*365):(2*24*365)], start=2014,  frequency=length(wind_res73)/4)
wrARMAauto1y <- auto.arima(ts_1y, start.p = 24, max.p = 24, max.q = 24, max.order = 50, parallel = TRUE, stationary = TRUE, seasonal = FALSE, stepwise = FALSE)
saveRDS(wrARMAauto1y,"auto_ARMA_24_q_1y.rds")
# 6 month time series
ts_6m <- ts(wind_res73[(1+1.5*24*365):(2*24*365)], start=2014.5,  frequency=length(wind_res73)/4)
wrARMAauto6m <- auto.arima(ts_6m, start.p = 24, max.p = 24, max.q = 24, max.order = 50, parallel = TRUE, stationary = TRUE, seasonal = FALSE, stepwise = FALSE)
saveRDS(wrARMAauto6m,"auto_ARMA_24_q_6m.rds")
# 3 month time series
ts_3m <- ts(wind_res73[(1+1.75*24*365):(2*24*365)], start=2014.75,  frequency=length(wind_res73)/4)
wrARMAauto3m <- auto.arima(ts_3m, start.p = 24, max.p = 24, max.q = 24, max.order = 50, parallel = TRUE, stationary = TRUE, seasonal = FALSE, stepwise = FALSE)
saveRDS(wrARMAauto3m,"auto_ARMA_24_q_3m.rds")

###############
# LOAD SECOND LOCATION DATA
###############
wind_res2137 <- readRDS(file = "Wind_res2137.rds")
ts_2137<-ts(wind_res2137, start=2013,  frequency=length(wind_res2137)/4)
wr_y1_2137 <- wind_res2137[1:(24*365)]
wr_y2_2137 <- wind_res2137[(1 + 24*365):(2*24*365)]
wr_y3_2137 <- wind_res2137[(1 + 2*24*365):(3*24*365)]
wr_y4_2137 <- wind_res2137[(1 + 3*24*365):(4*24*365)]
#########################
# Preliminary Analysis
#########################
# Is the TS stationary?
# Show Time Series and ACF
par(mfrow=c(3,1))
plot(ts_2137)
acf(ts_2137,lag.max=120)
pacf(ts_2137,lag.max=120)
# KPSS test
kpss.test(ts_2137) # p-value = 0.088
# Augmented Dickey-Fuller test
adf.test(ts_2137, alternative='s') # p-value < 0.01
# ndiffs
ndiffs(ts_2137)
## We got a stationary TS, let's try different models
#########################
# Model selection
#########################
train_ts_2137 <- window(ts_2137,start = 2013, end = (2015 - 1e-6))
val_ts <- window(ts_2137, start = 2015, end = (2016 - 1e-6))
test_ts = window(ts_2137, start = 2016)
par(mfrow=c(2,1))
Acf(train_ts_2137,lag.max=(24*7))
Pacf(train_ts_2137,lag.max=(24*7))
## The ACF is 'sinusoidal' and PACF 'ends' at lag 24, let's try an AR model
#####
# AR(24)
#####
wr.ar24 <- arima(train_ts_2137, order = c(24,0,0))
saveRDS(wr.ar24,"ar24_2137.rds")
###############
# Validate training data size
###############
# 2 year time series
ts_2y <- ts(wind_res2137[1:(2*24*365)], start=2013,  frequency=length(wind_res2137)/4)
# automatic arma(24,q) model
wrARMAauto2y <- auto.arima(ts_2y, start.p = 24, max.p = 24, max.q = 24, max.order = 50, stationary = TRUE, seasonal = FALSE, stepwise = FALSE)
saveRDS(wrARMAauto2y,"auto_ARMA_24_q_2y_2137.rds")
# 1 year time series
ts_1y <- ts(wind_res2137[(1+24*365):(2*24*365)], start=2014,  frequency=length(wind_res2137)/4)
wrARMAauto1y <- auto.arima(ts_1y, start.p = 24, max.p = 24, max.q = 24, max.order = 50, parallel = TRUE, stationary = TRUE, seasonal = FALSE, stepwise = FALSE)
saveRDS(wrARMAauto1y,"auto_ARMA_24_q_1y_2137.rds")
# 6 month time series
ts_6m <- ts(wind_res2137[(1+1.5*24*365):(2*24*365)], start=2014.5,  frequency=length(wind_res2137)/4)
wrARMAauto6m <- auto.arima(ts_6m, start.p = 24, max.p = 24, max.q = 24, max.order = 50, parallel = TRUE, stationary = TRUE, seasonal = FALSE, stepwise = FALSE)
saveRDS(wrARMAauto6m,"auto_ARMA_24_q_6m_2137.rds")
# 3 month time series
ts_3m <- ts(wind_res2137[(1+1.75*24*365):(2*24*365)], start=2014.75,  frequency=length(wind_res2137)/4)
wrARMAauto3m <- auto.arima(ts_3m, max.p = 24, max.q = 24, max.order = 50, parallel = TRUE, stationary = TRUE, seasonal = FALSE, stepwise = FALSE)
saveRDS(wrARMAauto3m,"auto_ARMA_24_q_3m_2137.rds")
###############
# Forecast
###############
# AR
wrAR24.73 <- readRDS("ar24_73.rds")
# add series to object in order to apply forecasting function
wrAR24.73$x <- train_ts
y.predAR73 <- forecast_arma(wrAR24.73,wr_y3)
wrAR24.2137 <- readRDS("ar24_2137.rds")
# add series to object in order to apply forecasting function
wrAR24.2137$x <- train_ts_2137
y.predAR2137 <- forecast_arma(wrAR24.2137,wr_y3_2137)
# 3 month training models
wrARMA3m73 <- readRDS("auto_ARMA_24_q_3m.rds")
y.pred3m73 <- forecast_arma(wrARMA3m73,wr_y3)
wrARMA3m2137 <- readRDS("auto_ARMA_24_q_3m_2137.rds")
y.pred3m2137 <- forecast_arma(wrARMA3m2137,wr_y3_2137)
# 6 month training models
wrARMA6m73 <- readRDS("auto_ARMA_24_q_6m.rds")
y.pred6m73 <- forecast_arma(wrARMA6m73,wr_y3)
wrARMA6m2137 <- readRDS("auto_ARMA_24_q_6m_2137.rds")
y.pred6m2137 <- forecast_arma(wrARMA6m2137,wr_y3_2137)
# 1 year training models
wrARMA1y73 <- readRDS("auto_ARMA_24_q_1y.rds")
y.pred1y73 <- forecast_arma(wrARMA1y73,wr_y3)
wrARMA1y2137 <- readRDS("auto_ARMA_24_q_1y_2137.rds")
y.pred1y2137 <- forecast_arma(wrARMA1y2137,wr_y3_2137)
# 2 year training models
wrARMA2y73 <- readRDS("auto_ARMA_24_q_2y.rds")
y.pred2y73 <- forecast_arma(wrARMA2y73,wr_y3)
wrARMA2y2137 <- readRDS("auto_ARMA_24_q_2y_2137.rds")
y.pred2y2137 <- forecast_arma(wrARMA2y2137,wr_y3_2137)
## PLOTS
# 3 month training models
#####
# 73
#####
# AR
par(mfrow=c(2,2))
rmse(y.predAR73[1,],wr_y3)# = 0.5044542
rmse(y.predAR73[4,1:(length(wr_y3)-1)],wr_y3[2:length(wr_y3)])# = 0.7181819
rmse(y.predAR73[7,1:(length(wr_y3)-2)],wr_y3[3:length(wr_y3)])# = 0.8186915
# 1 h ahead pedictions
plot(1:(24*7), y.predAR73[1,1:(24*7)],type = 'l', xlab = 'Hora', ylab = 'Residual', 
     main = 'Predicciones a 1 hora',col='blue')
lines(1:(24*7),y.predAR73[2,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),y.predAR73[3,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),wr_y3[1:(24*7)], col = 'red')
## ARMA
## 2 year training
# rmse
rmse(y.pred2y73[1,],wr_y3)# = 0.5025062
rmse(y.pred2y73[4,1:(length(wr_y3)-1)],wr_y3[2:length(wr_y3)])# = 0.7138486
rmse(y.pred2y73[7,1:(length(wr_y3)-2)],wr_y3[3:length(wr_y3)])# = 0.8130757
# zoom at first 7 days
plot(1:(24*7), y.pred2y73[1,1:(24*7)],type = 'l', xlab = 'Hora', ylab = 'Residual', 
     main = 'Predicciones a 1 hora',col='blue')
lines(1:(24*7),y.pred2y73[2,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),y.pred2y73[3,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),wr_y3[1:(24*7)], col = 'red')
## 1 year training
# rmse
rmse(y.pred1y73[1,],wr_y3)# = 0.503946
rmse(y.pred1y73[4,1:(length(wr_y3)-1)],wr_y3[2:length(wr_y3)])# = 0.7153927
rmse(y.pred1y73[7,1:(length(wr_y3)-2)],wr_y3[3:length(wr_y3)])# = 0.8145664
# zoom at first 7 days
plot(1:(24*7), y.pred1y73[1,1:(24*7)],type = 'l', xlab = 'Hora', ylab = 'Residual', 
     main = 'Predicciones a 1 hora',col='blue')
lines(1:(24*7),y.pred1y73[2,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),y.pred1y73[3,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),wr_y3[1:(24*7)], col = 'red')
## 6 month training
checkresiduals(wrARMA6m73)
rmse(y.pred6m73[1,],wr_y3)# = 0.5094853
rmse(y.pred6m73[4,1:(length(wr_y3)-1)],wr_y3[2:length(wr_y3)])# = 0.7257241
rmse(y.pred6m73[7,1:(length(wr_y3)-2)],wr_y3[3:length(wr_y3)])# = 0.8281664
# zoom at first 7 days
plot(1:(24*7), y.pred6m73[1,1:(24*7)],type = 'l', xlab = 'Hora', ylab = 'Residual', 
     main = 'Predicciones a 1 hora',col='blue')
lines(1:(24*7),y.pred6m73[2,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),y.pred6m73[3,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),wr_y3[1:(24*7)], col = 'red')
## 3 month training
rmse(y.pred3m73[1,],wr_y3)# = 0.5112428
rmse(y.pred3m73[4,1:(length(wr_y3)-1)],wr_y3[2:length(wr_y3)])# = 0.724563
rmse(y.pred3m73[7,1:(length(wr_y3)-2)],wr_y3[3:length(wr_y3)])# = 0.8261759
# zoom at first 7 days
plot(1:(24*7), y.pred3m73[1,1:(24*7)],type = 'l', xlab = 'Hora', ylab = 'Residual', 
     main = 'Predicciones a 1 hora',col='blue')
lines(1:(24*7),y.pred3m73[2,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),y.pred3m73[3,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),wr_y3[1:(24*7)], col = 'red')



#####
# 2137
#####
wr_y3 <- wind_res2137[(1 + 2*24*365):(3*24*365)]
## AR
checkresiduals(wrAR24.2137)
rmse(y.predAR2137[1,],wr_y3_2137)# = 0.5210577
rmse(y.predAR2137[4,1:(length(wr_y3)-1)],wr_y3_2137[2:length(wr_y3)])# = 0.7055411
rmse(y.predAR2137[7,1:(length(wr_y3)-2)],wr_y3_2137[3:length(wr_y3)])# = 0.7996031
# 1 h ahead pedictions
plot(1:(24*7), y.predAR2137[1,1:(24*7)],type = 'l', xlab = 'Hora', ylab = 'Residual', 
     main = 'Predicciones a 1 hora',col='blue')
lines(1:(24*7),y.predAR2137[2,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),y.predAR2137[3,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),wr_y3_2137[1:(24*7)], col = 'red')
##ARMA
# 2y
checkresiduals(wrARMA2y2137)
rmse(y.pred2y2137[1,],wr_y3_2137)# = 0.518497
rmse(y.pred2y2137[4,1:(length(wr_y3)-1)],wr_y3_2137[2:length(wr_y3)])# = 0.6998522
rmse(y.pred2y2137[7,1:(length(wr_y3)-2)],wr_y3_2137[3:length(wr_y3)])# = 0.7924363
# 1 h ahead pedictions
plot(1:(24*7), y.pred2y2137[1,1:(24*7)],type = 'l', xlab = 'Hora', ylab = 'Residual', 
     main = 'Predicciones a 1 hora',col='blue')
lines(1:(24*7),y.pred2y2137[2,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),y.pred2y2137[3,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),wr_y3_2137[1:(24*7)], col = 'red')
# 1y
checkresiduals(wrARMA1y2137)
rmse(y.pred1y2137[1,],wr_y3_2137)# = 0.5199321
rmse(y.pred1y2137[4,1:(length(wr_y3)-1)],wr_y3_2137[2:length(wr_y3)])# = 0.7008557
rmse(y.pred1y2137[7,1:(length(wr_y3)-2)],wr_y3_2137[3:length(wr_y3)])# = 0.7937331
# 1 h ahead pedictions
plot(1:(24*7), y.pred1y2137[1,1:(24*7)],type = 'l', xlab = 'Hora', ylab = 'Residual', 
     main = 'Predicciones a 1 hora',col='blue')
lines(1:(24*7),y.pred1y2137[2,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),y.pred1y2137[3,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),wr_y3_2137[1:(24*7)], col = 'red')
# 6m
checkresiduals(wrARMA6m2137)
rmse(y.pred6m2137[1,],wr_y3_2137)# = 0.5223883
rmse(y.pred6m2137[4,1:(length(wr_y3)-1)],wr_y3_2137[2:length(wr_y3)])# = 0.7056722
rmse(y.pred6m2137[7,1:(length(wr_y3)-2)],wr_y3_2137[3:length(wr_y3)])# = 0.7990686
# 1 h ahead pedictions
plot(1:(24*7), y.pred6m2137[1,1:(24*7)],type = 'l', xlab = 'Hora', ylab = 'Residual', 
     main = 'Predicciones a 1 hora',col='blue')
lines(1:(24*7),y.pred6m2137[2,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),y.pred6m2137[3,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),wr_y3_2137[1:(24*7)], col = 'red')
# 3m
checkresiduals(wrARMA3m2137)
rmse(y.pred3m2137[1,],wr_y3_2137)# = 0.52185
rmse(y.pred3m2137[4,1:(length(wr_y3)-1)],wr_y3_2137[2:length(wr_y3)])# = 0.7068219
rmse(y.pred3m2137[7,1:(length(wr_y3)-2)],wr_y3_2137[3:length(wr_y3)])# = 0.8003817
# 1 h ahead pedictions
plot(1:(24*7), y.pred3m2137[1,1:(24*7)],type = 'l', xlab = 'Hora', ylab = 'Residual', 
     main = 'Predicciones a 1 hora',col='blue')
lines(1:(24*7),y.pred3m2137[2,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),y.pred3m2137[3,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),wr_y3_2137[1:(24*7)], col = 'red')


###############
# FINAL MODELS
###############
## 73
# 3 year time series
ts_3y <- ts(wind_res73[1:(3*24*365)], start=2013,  frequency=length(wind_res2137)/4)
# automatic ARMA model
wrARMAauto3y <- auto.arima(ts_3y, start.p = 24, max.p = 24, max.q = 24, max.order = 50, 
                           stationary = TRUE, parallel = TRUE, seasonal = FALSE, stepwise = FALSE)
saveRDS(wrARMAauto3y,"auto_ARMA_final_73.rds")
## 2137
# 3 year time series
ts_3y <- ts(wind_res2137[1:(3*24*365)], start=2013,  frequency=length(wind_res2137)/4)
# automatic ARMA model
wrARMAauto3y <- auto.arima(ts_3y, start.p = 24, max.p = 24, max.q = 24, max.order = 50, 
                           stationary = TRUE, parallel = TRUE, seasonal = FALSE, stepwise = FALSE)
saveRDS(wrARMAauto3y,"auto_ARMA_final_2137.rds")
## Predictions
wrARMAauto3y73 <- readRDS("auto_ARMA_final_73.rds")
y.predFINAL73 <- forecast_arma(wrARMAauto3y73,wr_y4)
wrARMAauto3y2137 <- readRDS("auto_ARMA_final_2137.rds")
y.predFINAL2137 <- forecast_arma(wrARMAauto3y2137,wr_y4_2137)
## 73
checkresiduals(wrARMAauto3y73)
rmse(y.predFINAL73[1,],wr_y4)# = 0.5077213
rmse(y.predFINAL73[4,1:(length(wr_y4)-1)],wr_y4[2:length(wr_y4)])# = 0.7181873
rmse(y.predFINAL73[7,1:(length(wr_y4)-2)],wr_y4[3:length(wr_y4)])# = 0.8156235
# 1 h ahead pedictions
plot(1:(24*7), y.predFINAL73[1,1:(24*7)],type = 'l', xlab = 'Hora', ylab = 'Residual', 
     main = 'Predicciones a 1 hora',col='blue')
lines(1:(24*7),y.predFINAL73[2,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),y.predFINAL73[3,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),wr_y4[1:(24*7)], col = 'red')
## 2137
checkresiduals(wrARMAauto3y2137)
rmse(y.predFINAL2137[1,],wr_y4_2137)# = 0.5210933
rmse(y.predFINAL2137[4,1:(length(wr_y4)-1)],wr_y4_2137[2:length(wr_y4)])# = 0.6915848
rmse(y.predFINAL2137[7,1:(length(wr_y4)-2)],wr_y4_2137[3:length(wr_y4)])# = 0.7886777
# 1 h ahead pedictions
plot(1:(24*7), y.predFINAL2137[1,1:(24*7)],type = 'l', xlab = 'Hora', ylab = 'Residual', 
     main = 'Predicciones a 1 hora',col='blue')
lines(1:(24*7),y.predFINAL2137[2,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),y.predFINAL2137[3,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),wr_y4_2137[1:(24*7)], col = 'red')