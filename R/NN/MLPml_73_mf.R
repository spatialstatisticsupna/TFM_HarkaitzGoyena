library(doParallel)
library(caret)
library(Metrics)
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
significantHarmonics <- c(year,halfyear,day,12,8:1)
ts_matrix73 <- matrix(nrow = length(wind_res73) - max(significantHarmonics),
                        ncol = length(significantHarmonics))
y_73 <- wind_res73[(year+1):length(wind_res73)]
for (hour in (max(significantHarmonics) + 1):length(wind_res73)) {
  for (harmonic in 1:length(significantHarmonics)) {
    ts_matrix73[(hour-max(significantHarmonics)),harmonic] <- wind_res73[(hour-significantHarmonics[harmonic])] 
  }
}
###############
# Validaction and Training
###############
# Build data frame
Xy_73 <- cbind(ts_matrix73,y_73)
ts_dframe_73 <- data.frame(Xy_73)
names(ts_dframe_73) <- c('x1y','xhalfy','x1d','x12h','x8h','x7h','x6h','x5h',
                         'x4h','x3h','x2h','x1h','z')
## use first two year data to train
#Fit model
my.grid <- expand.grid(layer1 = 3:10, layer2 = 1:7, layer3 = 1:10)
train_df_73 <- ts_dframe_73[1:(2*year),]
ctrl <- trainControl(method = "cv",
                     verboseIter = TRUE,
                     savePredictions = TRUE)
form = as.formula("z ~ x1y + xhalfy + x1d + x12h + x8h + x7h + x6h + x5h + x4h + x3h + x2h + x1h")

cl <- makePSOCKcluster(4)
registerDoParallel(cl)

set.seed(2021)
## All subsequent models are then run in parallel
nnetFit73ML <- caret::train(form, 
                              data = train_df_73,
                              method = 'mlpML',
                              trControl = ctrl,
                              maxit = 500,
                              linOut = TRUE,
                              tuneGrid = my.grid)

## When you are done:
stopCluster(cl)

saveRDS(nnetFit73ML,"mlp73_all.RDS")

# predictions
nnetFit73ML <- readRDS("mlp73_all.RDS")
set.seed(2021)
z_pi_73 <- nn_pred_int(nnetFit73ML,ts_dframe_73)
saveRDS(z_pi_73,"mlp73mlall_pi.rds")
## obtain RMSE
z_pi_73 <- readRDS("mlp73all_pi.rds")
rmse(z_pi_73[1,], wind_res73[(3*year+1):(4*year)])
rmse(z_pi_73[4,1:(year-1)], wind_res73[(3*year+2):(4*year)])
rmse(z_pi_73[7,1:(year-2)], wind_res73[(3*year+3):(4*year)])
## plot PI
plot(1:(24*7),wind_res73[(3*year+1):(3*year+24*7)],type = 'l', xlab = 'Hora', ylab = 'Residual', 
     main = 'Predicciones a 1 hora',col='red')
lines(1:(24*7),z_pi_73[2,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),z_pi_73[3,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),z_pi_73[1,1:(24*7)], col = 'blue')
legend("bottomright",
       c("PI","Observed"),
       fill=c("blue","red")
)
