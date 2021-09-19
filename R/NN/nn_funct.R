nn_pi_train_sigma <- function(nn_model,train_dframe) {
  sigma <- 0.1
  PICP <- 0
  nvar <- ncol(train_dframe)
  z_pred <- matrix(nrow = 3, ncol = nrow(train_dframe))
  obs <- train_dframe$z
  print(sigma)
  while (PICP < 0.95) {
    for(i in 1:nrow(train_dframe)) {
      x1 <- train_dframe[i,]
      df1 <- as.data.frame(lapply(x1, rep, 100))
      rmat <- matrix(rnorm(n = nvar*100, mean = 0, sd = sigma),nrow = 100, ncol = nvar)
      df1 <- df1 + rmat
      y1 <- predict(nn_model, newdata=df1)
      # obtain quantiles
      z_pred[1:3,i] <- c(mean(y1),max(y1),min(y1))
    }
    sumc <- sum((z_pred[2,] > obs) & (z_pred[3,] < obs))
    PICP <- sumc / nrow(train_dframe)
    sigma <- sigma + 0.1
    print(sigma)
  }
  return(sigma)
}

nn_pred_int <- function(nn_model,full_dframe, sigma) {
  year <- 24*365
  z_pred <- matrix(nrow = 9, ncol = year)
  nvar <- ncol(full_dframe)
  for(i in 1:(year-2)) {
    x1 <- full_dframe[2*year+i-1,]
    df1 <- as.data.frame(lapply(x1, rep, 100))
    rmat <- matrix(rnorm(n = nvar*100, mean = 0, sd = sigma),nrow = 100, ncol = nvar)
    df1 <- df1 + rmat
    y1 <- predict(nn_model, newdata=df1)
    # obtain quantiles
    z_pred[1:3,i] <- c(mean(y1),max(y1),min(y1))
    y1 <- mean(y1)
    x2 <- full_dframe[2*year+i,]
    x2[(nvar-1)] <- y1
    df2 <- as.data.frame(lapply(x2, rep, 100))
    rmat <- matrix(rnorm(n = nvar*100, mean = 0, sd = sigma),nrow = 100, ncol = nvar)
    df2 <- df2 + rmat
    y2 <- predict(nn_model, newdata=df2)
    z_pred[4:6,i] <- c(mean(y2),max(y2),min(y2))
    y2 <- mean(y2)
    x3 <- full_dframe[2*year+i+1,]
    x3[(nvar-1)] <- y2
    x3[(nvar-2)] <- y1
    df3 <- as.data.frame(lapply(x3, rep, 100))
    rmat <- matrix(rnorm(n = nvar*100, mean = 0, sd = sigma),nrow = 100, ncol = nvar)
    df3 <- df3 + rmat
    y3 <- predict(nn_model, newdata=df3)
    z_pred[7:9,i] <- c(mean(y3),max(y3),min(y3))
  }
  i = year - 1
  x1 <- full_dframe[2*year+i-1,]
  df1 <- as.data.frame(lapply(x1, rep, 100))
  rmat <- matrix(rnorm(n = nvar*100, mean = 0, sd = sigma),nrow = 100, ncol = nvar)
  df1 <- df1 + rmat
  y1 <- predict(nn_model, newdata=df1)
  # obtain quantiles
  z_pred[1:3,i] <- c(mean(y1),max(y1),min(y1))
  y1 <- mean(y1)
  x2 <- full_dframe[2*year+i,]
  x2[(nvar-1)] <- y1
  df2 <- as.data.frame(lapply(x2, rep, 100))
  rmat <- matrix(rnorm(n = nvar*100, mean = 0, sd = sigma),nrow = 100, nvar)
  df2 <- df2 + rmat
  y2 <- predict(nn_model, newdata=df2)
  z_pred[4:6,i] <- c(mean(y2),max(y2),min(y2))
  i = year
  x1 <- full_dframe[2*year+i-1,]
  df1 <- as.data.frame(lapply(x1, rep, 100))
  rmat <- matrix(rnorm(n = nvar*100, mean = 0, sd = sigma),nrow = 100, ncol = nvar)
  df1 <- df1 + rmat
  y1 <- predict(nn_model, newdata=df1)
  # obtain quantiles
  z_pred[1:3,i] <- c(mean(y1),max(y1),min(y1))
  z_pred
}