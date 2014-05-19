####################

x <- c("a","b","c","d")

for (i in 1:4){
    print(x[i])
}

for (i in seq_along(x)){
  print(x[i])
}

for(letter in x) {
  print(letter)
}

for(i in 1:4) print(x[i])

####################

z <- 5
while (z>=3 && z <=10){ #random walk
  print(z)
  coin <- rbinom(1,1,0.5)
  
  if (coin == 1){
    z <- z+1
  }else{
    z <- z -1
  }
}

####################

x0 <- 1
tol <- 1e-8

repeat{
    x1 <- computeEstimate()
    
    if (abs(x1-x0) < tol){
        break
    }else{
        x0 <- x1
    }
}

########################################
#              FUNCTION                #
########################################

f <- function(<argument>){
    ## do something interesting
}

mydata <- rnorm(100)
sd(mydata)
sd(x=mydata)
sd(x=mydata,na.rm=FALSE)

lm(y-x, mydata, 1:100, model=False)

increment <- function(x){
  x <- x + 1
}

y = increment(x=3)
print(y)

paste("a","b", sep=":")

#########################################

above10 <- function(x){
    use <- x > 10
    x[use]
}

above <- function(x, n=10){
    use <- x>n
    x[use]
}

x <- 1:20
above(x)


columnmean <- function(y, removeNA=TRUE){
    nc <- ncol(y)
    means <- numeric(nc)
    for (i in 1:nc){
        means[i]  <- mean(y[,i], na.rm = removeNA)
    }
    means
}

########################################
#              SCOPING                 #
########################################

make.power <- function(n){
    pow <- function(x){
        x^n
    }
    pow
}












