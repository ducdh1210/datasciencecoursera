#######################
#       lapply        #
#######################

# Idea: loop over a list and evaluate a function on each element

# Input: (1) a list x
#        (2) a function (or the name of a function)
#        (3) other arguments via ...    

x <- list(a = 1:5, b = rnorm(10))
mean_list = lapply(x,mean) # lapply always returns a list

x <- 1:4
mean_list = lapply(x,runif) #runif(n) returns n uniform random variables

x <- 1:4
mean_list = lapply(x, runif, min = 0, max = 10) 

# lapply and friends make heavy use of anonymous function

x <- list(a=matrix(1:4,2,2), b=matrix(1:6,3,2))

# use anonymous function for extracting the first column of each matrix
lapply(x, function(elt) elt[,1])

#######################
#       sapply        #
#######################

## try to simplify the result of lapply if possible
x <- list(a = 1:4, b = rnorm(10), c = rnorm(20,1), d = rnorm(100,5))
mean_list = lapply(x, mean)
mean_vector = sapply(x, mean)

#######################
#       apply         #
#######################

## to evaluatte a function (often anonymous one) over a margins of an array
##    apply a function to rows or columns of a matrix
##    used with array, e.g. taking the average of an array of matrices
##    not faster than loop, but works in one line!

# function(x, MARGIN, FUN, ...)
# INPUT: (1) X is an array
#        (2) MARGIN is an integer vector indicating which margins should be "retained"
#        (3) FUN is function to be applied
#        (4) ... is/are extra argument(s) passed to FUN

x <- matrix(rnorm(200), 20, 10)
apply(x,2,mean) # mean of column. "2" means "keep the number of columns"
apply(x,1,sum) # mean of row. "1" means "keep the number of rows"

# Shortcuts: rowSums, rowMeans, colSums, colMeans

# Find quantile
x <- matrix(rnorm(200), 20, 10)
apply (x, 1, quantile, probs=(c(0.25,0.75)))

# Multi-dimensional array --> find average of matrix
a <- array(rnorm(2*2*10), c(2,2,10))
apply(a, c(1,2), mean) # find keep 1st and 2nd dimension, collapse 3rd dimension

rowMeans(a, dims=2)

#######################
#       tapply        #
#######################

# tapply(X, index, FUN = NULL, ..., simplify = TRUE)
# INPUT: (1) X is a vector
#        (2) INDEDx is a factor or a list of factors
#        (3) FUN is a function to be applied
#        (4) ... other arguments to be passed to FUN
#        (5) simplify, should we simplify the result

x <- c (rnorm(10), runif(10), rnorm(10,1))
f <- gl(3,10) # f is a factor, whose has 3 levels and each level is repeated 10 times
tapply(x,f,mean)
tapply(x,f,mean,simplify=FALSE) # return a list
tapply(x,f,range)

#######################
#       split         #
#######################

# Idea: takes a vector and other objects and splits it into groups determined by a factor or list of factors
# split(x, f, drop = FALSE, ...)
# INPUT: (1) x is a vector (or list) or data frame
#        (2) f is a vector (or coerced to one) or a list of factors
#        (3) drop indicates whether empty factors levels should be dropped
# OUTPUT: a list

x <- c (rnorm(10), runif(10), rnorm(10,1))
f <- gl(3,10) # f is a factor, whose has 3 levels and each level is repeated 10 times
split(x,f)

# Very common to use split with lapply
x <- c (rnorm(10), runif(10), rnorm(10,1))
f <- gl(3,10) # f is a factor, whose has 3 levels and each level is repeated 10 times
lapply(split(x,f), mean)

# Working with frame
library(datasets)
head(airquality)

s <- split(airquality, airquality$Month)
lapply(s, function(x) colMeans(x[,c("Ozone","Solar.R","Wind")]))

sapply(s, function(x) colMeans(x[,c("Ozone","Solar.R","Wind")], na.rm=TRUE))

# Splitting more than 1 level
x <- rnorm(10)
f1 <- gl(2,5)
f2 <- gl(5,2)
interaction(f1,f2)
str(split(x,list(f1,f2)))
str(split(x,list(f1,f2),drop=TRUE))

#######################
#       mapply        #
#######################

# Idea: multivariate apply of sorts which applies a function in parallel over a set of arguments
# syntax: mapply(FUN, ..., MoreArgs = NULL, SIMPLIFY = TRUE, USE.NAMES = TRUE)
# INPUT: (1) FUN:function to apply
#        (2) ... arguments to apply over
#        (3) MoreArgs: a list of other arguments to FUN
#        (4) SIMPLIFY: whether the result should be simplified

list(rep(1,4),rep(2,3),rep(3,2),rep(4,1))
# instead we can use
mapply(rep, 1:4, 4:1)

noise <- function(n,mean,sd){
  rnorm(n,mean,sd)
}

noise(5,1,2)
# how about noise(1:5,1:5,2)
mapply(noise, 1:5, 1:5, 2)

#######################
#    DEBUGGING P.1    #
#######################

printmessage <- function(x){
  if (is.na(x))
    print("x is a missing value")
  else if (x>0)
    print("x is greater than zero")
  else
    print("x is less than zero")
  invisible(x)
}

#######################
#    DEBUGGING P.3   #
#######################

lm(adf-uhn)
traceback()
























