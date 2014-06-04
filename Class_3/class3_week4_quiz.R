# Question 1

fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl1, destfile="housingIdaho.csv",method="curl")
housing <- read.csv("housingIdaho.csv")
splitNames = strsplit(names(housing),"\\wgtp")
splitNames[[123]]

# Question 2
fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl1, destfile="gdp.csv",method="curl")
gdpData <- read.csv("gdp.csv")
gdpData$X.3 <- gsub(",","",gdpData$X.3,)
gdpData$X.3 <- gsub(" ","",gdpData$X.3,)
bad_condition = (gdpData$X.3 == ".." | is.na(gdpData$X.3) | gdpData$X.3 == "" | gdpData$X == "" |  gdpData$Gross.domestic.product.2012 == "")
gdpData <- gdpData[!bad_condition,]
mean(as.numeric(gdpData$X.3))

# Question 3
length(grep("^United",gdpData$X.2))

# Question 4
fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl2, destfile="edu.csv",method="curl")
eduData <- read.csv("edu.csv")

mergedData = merge(gdpData, eduData, by.x="X", by.y="CountryCode",all=FALSE)
bad_condition = (mergedData$Gross.domestic.product.2012 == "")
mergedData <- mergedData[!bad_condition,]
length(grep("Fiscal year end: June",mergedData$Special.Notes))

# Question 5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
length(grep("^2012",sampleTimes))
library(lubridate);
sampleTimes <- gsub("-","",sampleTimes)
sampleTimes <- ymd(sampleTimes)
condition1 <- (year(sampleTimes) == 2012)
sampleTimes <- sampleTimes[condition1]
sum(wday(sampleTimes)==2)


