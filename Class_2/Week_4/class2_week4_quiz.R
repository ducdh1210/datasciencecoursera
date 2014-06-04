# Question 1
# What is produced at the end of this snippet of R code?
set.seed(1)
rpois(5,2)

set.seed(10)
x <- rbinom(10, 10, 0.5)
e <- rnorm(10, 0, 20)
y <- 0.5 + 2 * x + e
plot(x,y)

library(datasets)
Rprof()
fit <- lm(y ~ x1 + x2)
Rprof(NULL)