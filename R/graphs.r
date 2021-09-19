require(graphics)
library(raster)
library(mapview)
###############
# plot locations in map
###############
# original data
loc73 <- c(73, 36.8419, 26.0991)
loc2137 <- c(2137, 48.3264, 20.8656)
data <- rbind(loc73,loc2137)
loc.spdf <- SpatialPointsDataFrame(data[,c(2,3)], data.frame(data[,1]), proj4string = CRS('+proj=longlat'))
mapview(loc.spdf)

###############
# 73 location mean wind speed
###############
wind_res73 <- readRDS(file = "Wind_res73.rds")
wr_y1 <- wind_res73[1:(24*365)]
wr_y2 <- wind_res73[(1 + 24*365):(2*24*365)]
wr_y3 <- wind_res73[(1 + 2*24*365):(3*24*365)]
wr_y4 <- wind_res73[(1 + 3*24*365):(4*24*365)]

yearlydata <- rbind(wr_y1,wr_y2,wr_y3,wr_y4)
means <- matrix(nrow = 4,ncol = 24)
sds <- matrix(nrow = 4,ncol = 24)
hdata <- matrix(nrow = 365,ncol = 24)
i = 1
for (i in c(1:4)) {
  year <- yearlydata[i,]
  for (day in c(1:365)){
    hdata[day,] <- year[1:24]
    year <- year[25:length(year)]
  }
  for (hour in c(1:24)) {
    ddata <- hdata[,hour]
    means[i,hour] <- mean(ddata)
    sds[i,hour] <- sd(ddata)
  }
  i = i+1
}

par(mfrow = c(2,2))

plot(x=c(1:24),sds[1,],type = 'l', xlab = 'Hora', ylab = 'Residual', main = 'Año 2013',col='red', ylim=c(-0.5,1.5))
points(x=c(1:24),sds[1,],pch = 23, col = 'red')
lines(x=c(1:24),means[1,], col = 'blue')
points(x=c(1:24),means[1,],pch = 24, col = 'blue')

plot(x=c(1:24),sds[2,],type = 'l', xlab = 'Hora', ylab = 'Residual', main = 'Año 2014',col='red', ylim=c(-0.5,1.5))
points(x=c(1:24),sds[2,],pch = 23, col = 'red')
lines(x=c(1:24),means[2,], col = 'blue')
points(x=c(1:24),means[2,],pch = 24, col = 'blue')

plot(x=c(1:24),sds[3,],type = 'l', xlab = 'Hora', ylab = 'Residual', main = 'Año 2015',col='red', ylim=c(-0.5,1.5))
points(x=c(1:24),sds[3,],pch = 23, col = 'red')
lines(x=c(1:24),means[3,], col = 'blue')
points(x=c(1:24),means[3,],pch = 24, col = 'blue')

plot(x=c(1:24),sds[4,],type = 'l', xlab = 'Hora', ylab = 'Residual', main = 'Año 2016',col='red', ylim=c(-0.5,1.5))
points(x=c(1:24),sds[4,],pch = 23, col = 'red')
lines(x=c(1:24),means[4,], col = 'blue')
points(x=c(1:24),means[4,],pch = 24, col = 'blue')


###############
# 2137 location mean wind speed
###############
wind_res2137 <- readRDS(file = "Wind_res2137.rds")
wr_y1_2137 <- wind_res2137[1:(24*365)]
wr_y2_2137 <- wind_res2137[(1 + 24*365):(2*24*365)]
wr_y3_2137 <- wind_res2137[(1 + 2*24*365):(3*24*365)]
wr_y4_2137 <- wind_res2137[(1 + 3*24*365):(4*24*365)]

yearlydata <- rbind(wr_y1_2137,wr_y2_2137,wr_y3_2137,wr_y4_2137)
means <- matrix(nrow = 4,ncol = 24)
sds <- matrix(nrow = 4,ncol = 24)
hdata <- matrix(nrow = 365,ncol = 24)
i = 1
for (i in c(1:4)) {
  year <- yearlydata[i,]
  for (day in c(1:365)){
    hdata[day,] <- year[1:24]
    year <- year[25:length(year)]
  }
  for (hour in c(1:24)) {
    ddata <- hdata[,hour]
    means[i,hour] <- mean(ddata)
    sds[i,hour] <- sd(ddata)
  }
  i = i+1
}

plot(x=c(1:24),sds[1,],type = 'l', xlab = 'Hora', ylab = 'Residual', main = 'Año 2013',col='red', ylim=c(-0.5,1.5))
points(x=c(1:24),sds[1,],pch = 23, col = 'red')
lines(x=c(1:24),means[1,], col = 'blue')
points(x=c(1:24),means[1,],pch = 24, col = 'blue')

plot(x=c(1:24),sds[2,],type = 'l', xlab = 'Hora', ylab = 'Residual', main = 'Año 2014',col='red', ylim=c(-0.5,1.5))
points(x=c(1:24),sds[2,],pch = 23, col = 'red')
lines(x=c(1:24),means[2,], col = 'blue')
points(x=c(1:24),means[2,],pch = 24, col = 'blue')

plot(x=c(1:24),sds[3,],type = 'l', xlab = 'Hora', ylab = 'Residual', main = 'Año 2015',col='red', ylim=c(-0.5,1.5))
points(x=c(1:24),sds[3,],pch = 23, col = 'red')
lines(x=c(1:24),means[3,], col = 'blue')
points(x=c(1:24),means[3,],pch = 24, col = 'blue')

plot(x=c(1:24),sds[4,],type = 'l', xlab = 'Hora', ylab = 'Residual', main = 'Año 2016',col='red', ylim=c(-0.5,1.5))
points(x=c(1:24),sds[4,],pch = 23, col = 'red')
lines(x=c(1:24),means[4,], col = 'blue')
points(x=c(1:24),means[4,],pch = 24, col = 'blue')
