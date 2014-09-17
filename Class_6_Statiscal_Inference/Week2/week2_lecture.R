# variability
# standard normals have variance 1; means of n standards normals have standard deviation 1/sqrt(n)

nosim <- 1000
n <- 10
sd(apply(matrix(rnorm(nosim*n), nosim),1,mean)) #the matrix will have 1000 row, 10 columns (representing sample size = 10)
# then we find the mean of each row (so we will have 1000 means)
# then we find the std of that 1000 means 

# check with theoritical standard error (again 1= population stardard deviation)
1/sqrt(n)

# data example
library(UsingR)
data(father.son)

x <- father.son$fheight
n <- length(x)

round(c(var(x), var(x)/n, sd(x), sd(x)/sqrt(n)),2)

# Binomial Distribution
choose(8,7)*(0.5^7) + choose(8,8)*(0.5^8)
pbinom(6, size=8, prob=0.5, lower.tail=FALSE)

# Nornal Distribution
qnorm(0.95, mean=0, sd=1)
pnorm(5, mean=11, sd=2, lower.tail=FALSE)
qnorm(0.75, mean=1020, sd=50)

# Poisson Distribution
ppois(3, lambda = 2.5*4, lower.tail=TRUE)
ppois(40, lambda = 9*5, lower.tail=TRUE)

# Asymptotics

# Law of large numbers in action

# normal
n <- 10000; 
means <- cumsum(rnorm(n)) / (1  : n)
plot(1 : n, means, type = "l", lwd = 2, 
     frame = FALSE, ylab = "cumulative means", xlab = "sample size")
abline(h = 0)

n <- 10000
means <- cumsum(rnorm(n))/(1:n)
library(ggplot2)
g <- ggplot(data.frame(x = 1:n, y = means), aes(x = x, y = y));
g <- g + geom_hline(yintercept = 0) + geom_line(size = 2);
g <- g + labs(x = "Number of obs", y = "Cumulative mean")
g


# coin flip
means <- cumsum(sample(0:1, n, replace=TRUE)) / (1:n)
plot(1 : n, means, type = "l", lwd = 2, 
     frame = FALSE, ylab = "cumulative means", xlab = "sample size")
abline(h = 0)

means <- cumsum(sample(0:1, n, replace = TRUE))/(1:n)
g <- ggplot(data.frame(x = 1:n, y = means), aes(x = x, y = y));
g <- g + geom_hline(yintercept = 0.5) + geom_line(size = 2)
g <- g + labs(x = "Number of obs", y = "Cumulative mean")
g

# roll n dice, take their mean, substract off 3.5, and divide by 1.71/sqrt(n), repeat this over and over
nSim <- 10000
nCol <- 10

rVar <- sample (1:6, nSim, replace=TRUE)

rVar_matrix <- matrix(rVar, ncol = nCol)
rVar_matrix <- (rVar_matrix - 3.5)/(1.71/sqrt(nCol))
mean_vector <- apply(rVar_matrix, 1, mean)
par(mfrow = c(1, 1))
hist(mean_vector,breaks = 30)


# ## Simulation of mean of $n$ dice
```{r, echo = FALSE, fig.width=9, fig.height = 3}
par(mfrow = c(1, 3))
for (n in c(1, 2, 6)){
  temp <- matrix(sample(1 : 6, n * 10000, replace = TRUE), ncol = n)
  temp <- apply(temp, 1, mean)
  temp <- (temp - 3.5) / (1.71 / sqrt(n)) 
  plot(dty$x, dty$y, xlab = "", ylab = "density", type = "n", xlim = c(-3, 3), ylim = c(0, .5))
  title(paste("sample mean of", n, "obs"))
  lines(seq(-3, 3, length = 100), dnorm(seq(-3, 3, length = 100)), col = grey(.8), lwd = 3)
  lines(dty$x, dty$y, lwd = 2)
}

# Simulation of coin flip
```{r, echo = FALSE, fig.width=7.5, fig.height = 5}
par(mfrow = c(2, 3))
for (n in c(1, 10, 20)){
  temp <- matrix(sample(0 : 1, n * 10000, replace = TRUE), ncol = n)
  temp <- apply(temp, 1, mean)
  temp <- (temp - .5) * 2 * sqrt(n)
  dty <- density(temp)
  plot(dty$x, dty$y, xlab = "", ylab = "density", type = "n", xlim = c(-3, 3), ylim = c(0, .5))
  title(paste("sample mean of", n, "obs"))
  lines(seq(-3, 3, length = 100), dnorm(seq(-3, 3, length = 100)), col = grey(.8), lwd = 3)
  lines(dty$x, dty$y, lwd = 2)
}

# Confidence interval
library(UsingR)
data(father.son)
x <- father.son$sheight
(mean(x) + c(-1,1)*qnorm(0.975)*sd(x)/sqrt(length(x)))/12 #divide by 12 to convert unit to feet 
(mean(x) + c(-1,1)*qnorm(0.95)*sd(x)/sqrt(length(x)))/12

# binomial interval
0.56 + c(-1,1)*qnorm(0.975)*sqrt(0.56*(1-0.56)/100)
binom.test(56,100)$conf.int

# binomial simulation
#Let's say you wanted to simulate a class of 30 students rolling a dice 10 times, and you wished to count the number of 3's you observe for each student. You could simulate this experiment using the following code:
n <- 20
nosim <- 1000
pvals <- seq (0.1, 0.9, by=0.05)
checkpoint <- 123432
coverage <- sapply(pvals, function(p){
  phats <- rbinom(nosim, prob = p, size = n)/n
  ll <- phats - qnorm(0.975) * sqrt(phats*(1-phats)/n)
  ul <- phats + qnorm(0.975) * sqrt(phats*(1-phats)/n)
  checkpoint <- mean(ll<p & ul>p)
  #print(p);print(ll);print(ul);print(checkpoint);print("__")
})

# poisson confidence interval
x <- 5 
t <- 94.32
lambda <- x/t
round(lambda + c(-1,1)*qnorm(0.975)*sqrt(lambda/t),3) # t acts as n in this case

# or 
poisson.test(x, T=94.32)$conf

poisson.test(600, T=60)$conf

# self-understanding: if I keep drawing sample of size n (suppose n = 27), the confidence interval (suppose 95%) tell me that
# I am guessing that 95% of the time the sample mean will be within that range. Now, the important point is
# 95% is just a probability, you are not ensured it is true. By performing simulation, what we found is;
# 1) With smaller sample size, even though you said that you are confident 95% that the sample means will lie
# within a range, in fact, a true result can prove it can be only 50% or 60%
# By increasing the sample size, the confidence interval can be more correct
# 2) With small or large probability, the confident interval can also be incorrect. 
package(manipulate)
k <- 1000
xvals <- seq(-5,5,length=k)
myplot <- function(df){
  d <- data.frame(y=c(dnorm(xvals), dt=(xvals,df)),
                  x=xvals,
                  dist=factor(rep(c("Normal","T"),c(k,k))))
  g <- ggplot(d, aes(x=x, y=y))
  g <- g + geom_line(size=2, aes(colour=dist))
  g
}

manipulate(myplot(mu), mu=slider(1,20,step1))

# head example
data(sleep)
head(sleep)

g1 <- sleep$extra[1:10]; g2 <- sleep$extra[11:20]
difference <- g2 - g1
mn <- mean(difference); s <- sd(difference); n<-10

mn + c(-1,1) * qt(0.975,n-1) * s / sqrt(n)
t.test(difference)
t.test(g2,g1, paired=TRUE)
t.test(extra ~ I(relevel(group,2)),paired=TRUE, data=sleep)










