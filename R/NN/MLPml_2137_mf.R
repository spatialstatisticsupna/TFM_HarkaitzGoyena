library(doParallel)
library(caret)
library(Metrics)
source("nn_funct.R")
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
significantHarmonics <- c(year,halfyear,day,12,8:1)
ts_matrix2137 <- matrix(nrow = length(wind_res2137) - max(significantHarmonics),
                        ncol = length(significantHarmonics))
y_2137 <- wind_res2137[(year+1):length(wind_res2137)]
for (hour in (max(significantHarmonics) + 1):length(wind_res2137)) {
  for (harmonic in 1:length(significantHarmonics)) {
    ts_matrix2137[(hour-max(significantHarmonics)),harmonic] <- wind_res2137[(hour-significantHarmonics[harmonic])] 
  }
}
###############
# Validaction and Training
###############
# Build data frame
Xy_2137 <- cbind(ts_matrix2137,y_2137)
ts_dframe_2137 <- data.frame(Xy_2137)
names(ts_dframe_2137) <- c('x1y','xhalfy','x1d','x12h','x8h','x7h','x6h','x5h',
                           'x4h','x3h','x2h','x1h','z')
## use first two year data to train
#Fit model
my.grid <- expand.grid(layer1 = 7:10, layer2 = 1:7, layer3 = 7:10)
train_df_2137 <- ts_dframe_2137[1:(2*year),]
ctrl <- trainControl(method = "cv",
                     verboseIter = TRUE,
                     savePredictions = TRUE)
form = as.formula("z ~ x1y + xhalfy + x1d + x12h + x8h + x7h + x6h + x5h + x4h + x3h + x2h + x1h")

cl <- makePSOCKcluster(4)
registerDoParallel(cl)

set.seed(2021)
## All subsequent models are then run in parallel
nnetFit2137ML <- caret::train(form, 
                        data = train_df_2137,
                        method = 'mlpML',
                        trControl = ctrl,
                        maxit = 500,
                        tuneGrid = my.grid)

## When you are done:
stopCluster(cl)

saveRDS(nnetFit2137ML,"mlp2137ml_all.RDS")

# predictions
nnetFit2137ML <- readRDS("mlp2137ml_all.RDS") # 7,3,7 entrenamos nuevo modelo
set.seed(2021)
z_pi_2137 <- nn_pred_int(nnetFit2137ML,ts_dframe_2137)
saveRDS(z_pi_2137,"mlp2137mlall_pi.rds")
## obtain RMSE
z_pi_2137 <- readRDS("mlp2137all_pi.rds")
rmse(z_pi_2137[1,], wind_res2137[(3*year+1):(4*year)])
rmse(z_pi_2137[4,1:(year-1)], wind_res2137[(3*year+2):(4*year)])
rmse(z_pi_2137[7,1:(year-2)], wind_res2137[(3*year+3):(4*year)])
## plot PI
plot(1:(24*7),wind_res2137[(3*year+1):(3*year+24*7)],type = 'l', xlab = 'Hora', ylab = 'Residual', 
     main = 'Predicciones a 1 hora',col='red')
lines(1:(24*7),z_pi_2137[2,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),z_pi_2137[3,1:(24*7)],lty=2, col = 'blue')
lines(1:(24*7),z_pi_2137[1,1:(24*7)], col = 'blue')
legend("bottomright",
       c("PI","Observed"),
       fill=c("blue","red")
)
