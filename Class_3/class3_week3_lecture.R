############################### 
#   Subsetting and sorting    #
############################### 
set.seed(13435)
X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X <- X[sample(1:5),];
X$var2[c(1,3)]=NA

# subset row and column
X[,1] # return vector
X[,"var1"]
X[1:2,"var2"]

# Logical
X[(X$var1 <=3 & X$var3>11),] # return data frame
X[(X$var1 <=3 | X$var3>11),]

# deal with missing value
X[which(X$var2>8),]

#sorting
sort(X$var1)
sort(X$var1, decreasing=TRUE)
sort(X$var2, na.last=TRUE)

# order
X[order(X$var1),]
X[order(X$var1,X$var3),]
library(plyr)
arrange(X,var1)
arrange(X,desc(var1))

#add rows and columns
X$var4 <- rnorm(5)        
Y <- cbind(X,rnorm(5))

############################### 
#     Summarizing data        #
###############################

if (!file.exists("./data")){
  dir.create("./data")
}
fileUrl <- "https://data.baltimorecity.gov/api/views/kewm-hd3n/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="restaurants.csv",method="curl")
restData <- read.csv("restaurants.csv")

head(restData,n=3)
tail(restData,n=3)

#summary
summary(restData)

# depth information
str(restData)

# quantiles of quantitative variables
quantile(restData$councilDistrict, na.rm=TRUE)
quantile(restData$councilDistrict, probs=c(0.5,0.75,0.9))

# make table
table(restData$zipCode,useNA="ifany")
table(restData$zipCode,restData$zipCode)

# check for missing value
sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0) #check for condition

# row and column sum
colSums(is.na(restData))
all(colSums(is.na(restData))==0)

# values with specific characteristics
table(restData$zipCode %in% c("21209")) # are there any zipcode equals to 21209?
condition = table(restData$zipCode %in% c("21209","21211")) # are there any zipcode equals to 21209 or 21211?
restData[condition,]

# cross tab
data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions) #create data frame from dataset
summary(DF)
xt <- xtabs(Freq ~ Gender + Admit, data=DF) # we want Freq as number in the table, and break down by two dimensions, which are Gender and Admit
xt2 <- xtabs(Freq ~ Gender + Dept, data=DF)
xt3 <- xtabs(Freq ~ Gender + Dept + Admit, data=DF)

# flat tables
library("datasets")
require(stats)
warpbreaks$replicate <- rep(1:9,len=54)
xt = xtabs(breaks ~., data=warpbreaks) # ~. means look at all other variables
ftable(xt)

# size of dataset
fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData),units="Mb")


############################### 
#   Creating New Variables    #
###############################
fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="restaurants_more.csv",method="curl")
restData <- read.csv("restaurants_more.csv")

# creating sequences
# why? sometimes you need to index your data set
s1 <- seq(1,10,by=2); s1
s2 <- seq(1,10,length=3); s2
x <- c(1,3,8,25,100); seq(along=x) # create indexes for x

# subsetting variables
restData$nearMe = restData$neighborhood %in% c("Roland Park","Homeland")
table(restData$nearMe)

# creating binary variables
restData$zipWrong = ifelse(restData$zipCode<0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode <0)

# creating categorical variables
restData$zipGroups = cut(restData$zipCode, breaks=quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups,restData$zipCode)

# easier cutting
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g=4)
table(restData$zipGroups)

# creating factor variables
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]

# level of factor variables
yesno <- sample(c("yes","no"),size=10,replace=TRUE)
yesnofac = factor(yesno,levels=c("yes","no")) # reorder level
relevel(yesnofac,ref="yes")
as.numeric(yesnofac)

# cutting produces factor variables
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g=4) # 4 groups of quantiles
table(restData$zipGroups)

# using the mutate function
library(Hmisc); library(plyr)
restData2 = mutate(restData,zipGroups=cut2(zipCode,g=4))
table(restData2$zipGroups)

############################### 
#        Reshaping data       #
###############################

library(reshape2)
head(mtcars)

# melt dataset
mtcars$carname <-rownames(mtcars)
carMelt <- melt(mtcars,id=c("carname","gear","cyl"),measure.vars=c("mpg","hp"))

# casting data frame
cylData <- dcast(carMelt, cyl ~ variable) # for each row, return number of observations of mpg and hp with given cyl
cylData <- dcast(carMelt, cyl ~ variable, mean)

# averaging values
head(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray, sum)

# another way
spIns = split(InsectSprays$count, InsectSprays$spray)
sprCount = lapply(spIns, sum)
unlist(sprCount)

sapply(spIns, sum)

# another way
library(plyr)
ddply(InsectSprays,.(spray),summarise,sum=sum(count))
ddply(InsectSprays,.(spray),summarise,sum=ave(count,FUN=sum))

############################### 
#        Merging data         #
###############################

fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1, destfile="reviews.csv",method="curl")
download.file(fileUrl2, destfile="solutions.csv",method="curl")
reviews <- read.csv("reviews.csv")
solutions <- read.csv("solutions.csv")

head(reviews,2)
head(solutions,2)

names(reviews)
names(solutions)

# merging data
mergedData = merge(reviews, solutions, by.x="solution_id", by.y="id",all=TRUE)
head(mergedData)

# default - merge all common column names
intersect(names(solutions),names(reviews))
mergedData2 = merge(reviews,solutions,all=TRUE)
head(mergedData2)

# using join in the plyr package
df1 = data.frame(id=sample(1:10),x=rnorm(10))
df2 = data.frame(id=sample(1:10),y=rnorm(10))
arrange(join(df1,df2),id)

df3 = data.frame(id=sample(1:10),z=rnorm(10))
dfList = list(df1, df2, df3)
join_all(dfList)
















































