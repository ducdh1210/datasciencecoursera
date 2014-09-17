# Statistical Linear Regression
library(UsingR)
data(diamond)
plot(diamond$carat, diamond$price, xlab="Mass (carat", ylab="Price", bg="lightblue", col="black",cex=1.1,pch=21,frame=FALSE)
abline(lm(price~carat, data=diamond), lwd=2)
abline(lm(price~1,data=diamond),lwd=2)
#fitting the linear regression model
fit <- lm(price~carat, data=diamond)
coef(fit)
fit2 <- lm(price~I(carat-mean(carat)), data=diamond)
coef(fit2)
#changing scale
fit3 <- lm(price~I(carat*10),data=diamond)
coef(fit3)
#predict a price of a diamond
newx<-c(0.16,0.27,0.34)
coef(fit)[1]+coef(fit)[2]*newx
predict(fit,newdata=data.frame(carat=newx))

plot(diamond$carat, diamond$price, ylim=c(0,1000), xlim=c(0,1))
plot(diamond$carat - mean(diamond$carat), diamond$price, ylim=c(0,1000), xlim=c(0,1))

x <- c(1:10)
y <- 2 * x + 1
plot(x,y,xlim=c(0,30))

xnew <- x - 3
ynew <- 2 * x + 1
plot(xnew,ynew,xlim=c(0,30))

#residual variation
library(UsingR)
data(diamond)
library(ggplot2)
g = ggplot(diamond,aes(x=carat,y=price))
g = g + xlab("Mass (carats)")
g = g + ylab("Price (Singapore Dollars)")
g = g + geom_point(size=7, colour="black", alpha = 0.5)
g = g + geom_point(size=5, colour="blue", alpha = 0.2)
g = g + geom_smooth(method="lm",colour="black")
g

data(diamond)
y <- diamond$price; x <- diamond$carat; n <- length(y)
fit <- lm(y ~ x)
e <- resid(fit) #important command
yhat <- predict(fit)
max(abs(e -(y - yhat)))
max(abs(e - (y - coef(fit)[1] - coef(fit)[2] * x)))
sum(e)

plot(diamond$carat, diamond$price, xlab="Mass (carat", ylab="Price", bg="lightblue", col="black",cex=1.1,pch=21,frame=FALSE)
abline(fit, lwd=2)
for (i in 1:n)
  lines(c(x[i],x[i]),c(y[i],yhat[i]),col="red",lwd=2)

plot(x, e, xlab="Mass (carat)", ylab="Residual", bg="lightblue", col="black",cex=1.1,pch=21,frame=FALSE)
abline(h=0, lwd=2)
for (i in 1:n)
  lines(c(x[i],x[i]),c(e[i],0),col="red",lwd=2)

#non-linear data
x <- runif(100, -3, 3); y <- x + sin(x) + rnorm(100, sd = .2); 
plot(x, y); abline(lm(y ~ x))

plot(x, resid(lm(y ~ x))); 
abline(h = 0)

#Heteroskedasticity
x <- runif(100, 0, 6); y <- x + rnorm(100,  mean = 0, sd = .001 * x); 
plot(x, y); abline(lm(y ~ x)) 
plot(x, resid(lm(y ~ x))); 
abline(h = 0)

#diamond example
y <- diamond$price; x <- diamond$carat; n <- length(y)
fit <- lm(y ~ x)
summary(fit)$sigma
sqrt(sum(resid(fit)^2) / (n - 2))






