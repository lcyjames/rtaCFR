library(genlasso)

rtaCFR_SIM<-function(ct, pt, seed = NA, F_mean = 15.43, F_shape = 2.03){
  if(is.numeric(seed)){set.seed(seed)}
  if(length(ct)!=length(pt)){print("ERROR: The length of ct is not equal to that of pt.");break}
  N<-length(ct)
  dt <-rbinom(n = N,size = ct, prob = pt)
  fs    <-diff(pgamma(q=c(0:N), shape = F_shape,rate = F_shape/F_mean))
  dt_d  <- sapply(c(1:N),function(o){sum(dt[1:o]*rev(fs[1:o]))})
  return(data.frame(ct=ct, dt=dt_d))
}

rtaCFR_EST<-function(ct, dt, F_mean = 15.43, F_shape = 2.03, maxsteps = 10000){
  if(length(ct)!=length(dt)){print("ERROR: The length of ct is not equal to that of dt.");break}
  N<-length(ct)
  fs  <-diff(pgamma(q=c(0:N), shape = F_shape,rate = F_shape/F_mean))
  fmat<-matrix(0,nrow = N,ncol = N)
  for(i in c(1:N)){fmat[i,c(1:i)]<-rev(fs[1:i])}
  Xmat    <-fmat%*%diag(ct) #Xi
  D_mat   <-cbind(diag(1,length(dt)-1),0)-cbind(0,diag(1,length(dt)-1))
  a0      <-fusedlasso(y = dt,X = Xmat, D = D_mat, gamma = 0,maxsteps = maxsteps,minlam = 0)
  Sum_a0  <-as.data.frame(summary(a0),row.names = F)
  steps   <-nrow(Sum_a0)
  cd      <-which(as.numeric(apply((a0$beta>=0)*(a0$beta<=1),MARGIN = 2,prod))==1)
  cd_star <-which(Sum_a0$rss==min(Sum_a0$rss[cd]))
  p_hat   <-a0$beta[,cd_star]
  lam_star<-Sum_a0$lambda[cd_star]
  return(list(p_hat=p_hat, lambda_star=lam_star, steps=steps, p_matrix=a0$beta, sol_path=Sum_a0))
}

# data   <-rtaCFR_SIM(ct = 3000-5*abs(100-c(1:200)), pt = 0.01*exp(0.012*c(1:200)), seed = 1)
# rt_fit <-rtaCFR_EST(ct = data$ct, dt = data$dt)
# plot(rt_fit$p_hat, type="b", pch=19, ylab="Fatality rates", xlab="time", col="red", cex=0.6)
# lines(c(1:200),0.01*exp(0.012*c(1:200)), lwd=2)
# legend("topleft", legend=c("rtaCFR", "true"), col=c("red", "black"), lty=1:2, cex=0.8)

