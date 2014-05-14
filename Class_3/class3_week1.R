getwd()
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
#download.file(fileUrl, destfile = "../Class_3/housing.csv",method = "curl")
list.files()
housingData <- read.table("housing.csv", sep=",", header = TRUE)
#head(housingData)
housingData[,1] #first column 

# lookup code book --> (1) house value has header VAL (2) all house has VAL's column equal or above 24 has value > $1,000,000
houseValueSubset <- subset(housingData, VAL>=24)

#How many housing units in this survey were worth more than $1,000,000?
dim(houseValueSubset) # --> 53 188, then the answer is 53

######################

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl,destfile="../Class_3/gas.xlsx",method="curl")

library(xlsx)
gasData <- read.xlsx("gas.xlsx",sheetIndex=1,header=TRUE)

colIndex <- 7:15
rowIndex <- 18:23

dat <- read.xlsx("gas.xlsx",sheetIndex=1,colIndex=colIndex,rowIndex=rowIndex)
sum(dat$Zip*dat$Ext,na.rm=T) #na.rm to exclude missing value from analyses

########################

library(XML)
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <-xmlTreeParse(fileUrl, useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode) # --> "response"

testList = xpathApply(rootNode,"//zipcode",xmlValue)

length(testList) # number of element in a list
length(testList[testList==21211])

########################

#install.packages("data.table")
library(data.table)
comTable <- fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv")

# start <- Sys.time();DT[,mean(pwgtp15),by=SEX]; end <- Sys.time(); (end-start)*100000




