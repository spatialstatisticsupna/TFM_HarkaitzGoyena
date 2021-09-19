library(caret)
library(nnet)
library(Metrics)
library(doParallel)
source("nn_funct.R")
#####
# 73
#####
# build data matrix from time series data
wind_res73 <- readRDS(file = "Wind_res73.rds")
# signicant harmonics
year <- 24*365
halfyear <- (24*365)/2
day <- 24
# plus 8 and 12 hours
significantHarmonics <- c(year,halfyear,day,12,8)
ts_matrix <- matrix(nrow = length(wind_res73) - max(significantHarmonics),
                    ncol = length(significantHarmonics))
y <- wind_res73[(year+1):length(wind_res73)]
for (hour in (max(significantHarmonics) + 1):length(wind_res73)) {
  for (harmonic in 1:length(significantHarmonics)) {
    ts_matrix[(hour-max(significantHarmonics)),harmonic] <- wind_res73[(hour-significantHarmonics[harmonic])] 
  }
}
###
# Validaction and Training
###
# Build data frame
Xy <- cbind(ts_matrix,y)
ts_dframe <- data.frame(Xy)
names(ts_dframe) <- c('x1y','xhalfy','x1d','x12h','x8h','z')
## use first two year data to train
#Fit model
my.grid <- expand.grid(.decay = c(0.5, 0.1, 0.01), .size = 1:25)
train_df <- ts_dframe[1:(2*year),]
ctrl <- trainControl(method = "cv", 
                     verboseIter = TRUE,
                     savePredictions = TRUE)
cl <- makePSOCKcluster(4)
registerDoParallel(cl)
set.seed(2021)
nnetFit <- train(z ~ ., 
                 data = train_df,
                 method = "nnet",
                 trControl = ctrl,
                 tuneGrid = my.grid,
                 metric = "RMSE",
                 linout=TRUE)
stopCluster(cl)
saveRDS(nnetFit,"nnet73fit25_osh.rds")
# predictions
nnetFit_73 <- readRDS("nnet73fit25_osh.rds")
set.seed(2021)
z_pi_73 <- nn_pred_int(nnetFit_73,ts_dframe,1)
saveRDS(z_pi_73,"nnet73osh25_pi.rds")
## obtain RMSE
rmse(z_pi_73[1,], wind_res73[(3*year+1):(4*year)]) 
## plot PI
plot(1:(24*7),wind_res73[(3*year+1):(3*year+24*7)],type = 'l', xlab = 'Hora', ylab = 'Residual', 
     main = 'Predicciones a 1 hora',col='red')
lines(1:(24*7),z_pi_73[2,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),z_pi_73[3,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),z_pi_73[1,1:(24*7)], col = 'blue')
legend("bottomleft",
       c("PI","Observed"),
       fill=c("blue","red")
)
#####
# 2137
#####
# build data matrix from time series data
wind_res2137 <- readRDS(file = "Wind_res2137.rds")
# signicant harmonics
year <- 24*365
halfyear <- (24*365)/2
day <- 24
# plus 8 and 12 hours
significantHarmonics <- c(year,halfyear,day,12,8)
ts_matrix2137 <- matrix(nrow = length(wind_res2137) - max(significantHarmonics),
                    ncol = length(significantHarmonics))
y <- wind_res2137[(year+1):length(wind_res2137)]
for (hour in (max(significantHarmonics) + 1):length(wind_res2137)) {
  for (harmonic in 1:length(significantHarmonics)) {
    ts_matrix2137[(hour-max(significantHarmonics)),harmonic] <- wind_res2137[(hour-significantHarmonics[harmonic])] 
  }
}
###############
# Validation and Training
###############
# Build data frame
Xy <- cbind(ts_matrix2137,y)
ts_dframe <- data.frame(Xy)
names(ts_dframe) <- c('x1y','xhalfy','x1d','x12h','x8h','z')
## use first two year data to train
#Fit model
my.grid <- expand.grid(.decay = c(0.5, 0.1, 0.01), .size = 1:25)
train_df <- ts_dframe[1:(2*year),]
ctrl <- trainControl(method = "cv", 
                     verboseIter = TRUE,
                     savePredictions = TRUE)
cl <- makePSOCKcluster(4)
registerDoParallel(cl)
set.seed(2021)
nnetFit2137 <- train(z ~ ., 
                     data = train_df,
                     method = "nnet",
                     trControl = ctrl,
                     tuneGrid = my.grid,
                     metric = "RMSE",
                     linout=TRUE)
stopCluster(cl)
saveRDS(nnetFit2137,"nnet2137fit25_osh.rds")
# predictions
nnetFit2137 <- readRDS("nnet2137fit25_osh.rds")
set.seed(2021)
z_pi_2137 <- nn_pred_int(nnetFit2137,ts_dframe,1)
saveRDS(z_pi_2137,"nnet2137osh25_pi.rds")
## obtain RMSE
rmse(z_pi_2137[1,], wind_res2137[(3*year+1):(4*year)]) 
## plot PI
plot(1:(24*7),wind_res2137[(3*year+1):(3*year+24*7)],type = 'l', xlab = 'Hora', ylab = 'Residual', 
     main = 'Predicciones a 1 hora',col='red')
lines(1:(24*7),z_pi_2137[2,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),z_pi_2137[3,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),z_pi_2137[1,1:(24*7)], col = 'blue')
legend("bottomleft",
       c("PI","Observed"),
       fill=c("blue","red")
)
                       