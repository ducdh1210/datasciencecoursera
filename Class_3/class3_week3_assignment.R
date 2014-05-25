# QUESTION 1
# Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. 
# Assign that logical vector to the variable agricultureLogical. 
# Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE. which(agricultureLogical) What are the first 3 values that result?

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv "
download.file(fileUrl,destfile="household.csv",method="curl")
hhData <- read.csv("household.csv")

head(hhData, n = 3)

agricultureLogical = (hhData$ACR >=3 & hhData$AGS >=6)
returnData <- hhData[which(agricultureLogical),]
head(returnData, n = 3) # RESULT: 125, 238, 262

# QUESTION 2
# Using the jpeg package read in the following picture of your instructor into R 
# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg 
# Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data?

#install.packages("jpeg")
library(jpeg)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileUrl,destfile="image_week3_quiz.jpg",method="curl")
testImg <- readJPEG("image_week3_quiz.jpg",native=TRUE)

quantile(testImg, probs=c(0.3,0.8)) # RESULT: -15259150 -10575416 

# QUESTION 3
# Load the Gross Domestic Product data for the 190 ranked countries in this data set: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# Load the educational data from this data set: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv 
# Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank. What is the 13th country in the resulting data frame? 
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl,destfile="gdp.csv",method="curl")
gdpData <- read.csv("gdp.csv")
head(gdpData,n=3)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl,destfile="education.csv",method="curl")
eduData <- read.csv("education.csv")
head(eduData,n=3)

names(gdpData)
names(eduData)

# Load the Gross Domestic Product data for the 190 ranked countries in this data set
gdpData <- gdpData[gdpData$X!="" & gdpData$Gross.domestic.product.2012!="",] # hacky way, should be a better way

# merge two datasets
mergedData = merge(gdpData, eduData, by.x="X", by.y="CountryCode",all=FALSE) # false because we want column with the same name
ordered_col_vector = order(as.numeric(as.character(mergedData$Gross.domestic.product.2012)),decreasing=TRUE)
orderedMergedData <- mergedData[ordered_col_vector,]

# QUESTION 4
# What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
tapply(as.numeric(as.character(mergedData$Gross.domestic.product.2012)),mergedData$Income.Group,mean)

# QUESTION 5
# Cut the GDP ranking into 5 separate quantile groups. 
# Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?
mergedData$gdpGroups = cut(mergedData$Gross.domestic.product.2012, breaks=quantile(mergedData$Gross.domestic.product.2012))
gdpVector <- as.numeric(as.character(mergedData$Gross.domestic.product.2012))

library(Hmisc)
mergedData$gdpGroups = cut2(gdpVector, g=5)
table(mergedData$gdpGroups,mergedData$Income.Group)


