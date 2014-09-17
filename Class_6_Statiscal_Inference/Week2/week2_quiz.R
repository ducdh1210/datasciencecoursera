#Question 2
#Suppose that diastolic blood pressures (DBPs) for men aged 35-44 are normally distributed with a mean of 80 (mm Hg) 
#and a standard deviation of 10. About what is the probability that a random 35-44 year old has a DBP less than 70?
pnorm(70, mean = 80, s = 10)


#Transform: 10x + 80 = 70 --> x = -1 --> -1 deviation from mean --> P =  0.16


#Question 3
#Brain volume for adult women is normally distributed with a mean of about 1,100 cc for women with a standard deviation of 75 cc. 
#About what brain volume represents the 95th percentile? 
qnorm(0.95, mean=1100, s=75)
qnorm(0.95)*75+1100

#Question 4
#Refer to the previous question. 
#Brain volume for adult women is about 1,100 cc for women with a standard deviation of 75 cc. 
#Consider the sample mean of 100 random adult women from this population. 
#Around what is the 95th percentile of the distribution of that sample mean?
mean <- 1100
sd <- 75
n <- 100

( mean + c(-1,1)*qnorm(0.95)*sd/sqrt(n) )
mean + qnorm(0.975)*sd/sqrt(100)

mean <- 1100
sd <- 75
nCol <- 100
nRow <- 100000

womenMatrix <- matrix(rnorm(nRow*nCol,mean=mean, sd=sd), nRow)
temp <- apply(womenMatrix,1,mean)
sd(temp)

qnorm(0.95, mean = 1100, sd = 7.5)
qnorm(0.95)*7.5+1100


#Question 5
pbinom(q=4, size=5, prob=0.5, lower.tail=FALSE) 
pbinom(q=3, size=5, prob=0.5, lower.tail=FALSE) 

#Question 6
#The respiratory disturbance index (RDI), a measure of sleep disturbance, 
#for a specific population has a mean of 15 (sleep events per hour) and a standard deviation of 10.
#They are not normally distributed. 
#Give your best estimate of the probability that a sample mean RDI of 100 people is between 14 and 16 events per hour?

# http://openstudy.com/updates/536ef58fe4b0d61a13c8067c

#Question 7
#Consider a standard uniform density. The mean for this density is .5 and the variance is 1 / 12. 
#You sample 1,000 observations from this distribution and take the sample mean,
#what value would you expect it to be near?
sd <- sqrt(1/12)
mean <- 0.5
n <- 1000
mean + c(1,-1)*sd/sqrt(n)

#Question 8
#Consider a standard uniform density. The mean for this density is .5 and the variance is 1 / 12. 
#You sample 1,000 sample means where each sample mean is comprised of 100 observations.
#You take the standard deviation of the 1,000 sample means. About what number would you expect it to be?
nRow <- 100000000
ran_var <- runif(nRow*100)
ran_matrix <- matrix(ran_var, nrow = nRow)
temp <- apply(ran_matrix, 1, mean)
sd(temp)

#Question 9
#The number of people showing up at a bus stop is assumed to be Poisson with a mean of 5 people per hour. 
#You watch the bus stop for 3 hours. About what's the probability of viewing 10 or fewer people?

ppois(10, lambda = 5*3, lower.tail=TRUE)

#Question 10
#You are playing a game with a friend 
#where you flip a coin and if it comes up heads you give her 1 dollar and if it comes up tails she gives you one dollar.
#What would be the variance of your earnings?
option <- c(-1,1)
variables <- sample(option,10000,replace=TRUE)
var(variables)
matrix <- matrix(variables, nrow = 100)
temp <- apply(matrix, 1, mean)










