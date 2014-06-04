################################
#     the str function         #
################################

# Note: the diagnostic function: What is in the object?
str(str)
str(lm)
x <- rnorm(100,2,4)
summary(x)
str(x)
f <- gl(40,10)
str(f)

library(datasets)
str(airquality)

m <- matrix(rnorm(100),10,10)
str(m)

s <- split(airquality, airquality$Month)
str(s)

################################
#     Simulation part 1        #
################################

dnorm(x, mean=0, sd=1, log=FALSE)
pnorm(q, mean=0, sd=1, lower.tail=TRUE, log.p=FALSE)
qnorm(p, mean=0, sd=1, lower.tail=TRUE, log.p=FALSE)
rnorm(n, mean=0, sd=1)

x <- rnorm(10)
x <- rnorm(10,20,2)

# setting seed to ensure reproductivity
set.seed(1)
rnorm(5)
rnorm(5)
set.seed(1)
rnorm(5)

# poisson
rpois(10,1)
rpois(10,20)
ppois(2,2) #cummulative distribution P(x<=2)
ppois(4,2) #cummulative distribution P(x<=4)
ppois(6,2) #cummulative distribution P(x<=6)

################################
#     Simulation part 2        #
################################

# Generating random numbers from a linear model
set.seed(20)
x <- rnorm(100)
e <- rnorm(100,0,2)
y <- 0.5 + 2*x + e
summary(y)
plot(x,y)

# what if x is binary
set.seed(10)
x <- rbinom(100,1,0.5)
e <- rnorm(100,0,2)
y <- 0.5 + 2*x + e
summary(y)
plot(x,y)

# suppose we want to generate poisson model where
# Y ~ Poisson(mu)
# log(mu) = beta0 + beta1 * x
# betao0 = 0.5, beta1 = 0.3
set.seed(1)
x <- rnorm(100)
log.mu <- 0.5 + 0.3*x
y <- rpois(100,exp(log.mu))
summary(y)
plot(x,y)

# random sampling
set.seed(1)
sample(1:10,4)
sample(letters,5)
sample(1:10) #permutation
sample(1:10,replace=TRUE)

################################
#         R profile            #
################################

# Using system.time()

## elapsed time > user time , meaning that CPU does not bear a lot of work here, it is waiting for other things (in this case, the network)
# note: user time -> CPU time, elapsed time -> actual time user experience
system.time(readLines("http://www.jhsph.edu"))

# elapsed time < user time
hilbert <- function(n){
    i <- 1:n
    1/outer(i-1,i,"+")
}

x <- hilbert(1000)
system.time(svd(x))

# What if we dont know where to start looking? Rprof() amnd summaryRprof()
# Rprof() keeps track of the function call stack
# summaryRprof() tabulates the R profiler output

################################
#         Scoping              #
################################
















