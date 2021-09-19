forecast_arma <- function(ARMAmodel,val) {
  y.pred <- matrix(nrow=9,ncol = length(val))
  
  ts_i_m1 = ARMAmodel$x
  for (i in 1:length(val)) {
    # forecast i-th val value
    y_i.pred = forecast(object = ts_i_m1,h=3,model = ARMAmodel)
    y.pred[1,i] = y_i.pred$mean[1]
    y.pred[2,i] = y_i.pred$lower[1]
    y.pred[3,i] = y_i.pred$upper[1]
    y.pred[4,i] = y_i.pred$mean[2]
    y.pred[5,i] = y_i.pred$lower[2]
    y.pred[6,i] = y_i.pred$upper[2]
    y.pred[7,i] = y_i.pred$mean[3]
    y.pred[8,i] = y_i.pred$lower[3]
    y.pred[9,i] = y_i.pred$upper[3]
    # add observed data to model
    ts_i_m1 <- ts(c(ts_i_m1,val[i]), start=2013, frequency = 24*365)
  }
  y.pred
}