
###############################
#         Question 1          #
###############################
# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications
#    Insert your values below - if secret is omitted, it will look it up in
#    the GITHUB_CONSUMER_SECRET environmental variable.
#
#    Use http://localhost:1410 as the callback url
myapp <- oauth_app("github", "8bcec9aaceaca804349f", secret="a6695bbb3c95ff8a1ca2acd41f1a6a9a83919ede")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
req <- GET("https://api.github.com/rate_limit", config(token = github_token))
stop_for_status(req)
content(req)

json1 = content(req)
json2 = jsonlite::fromJSON(toJSON(json1))

json2_subset <- subset(json2, json2[2]=='datasharing')
json2_subset['created_at']

###############################
#         Question 2,3        #
###############################


download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "acs.csv", method = "curl")
acs = read.csv("acs", sep=",", na.strings=NA, header=TRUE)
sqldf("select * from acs")
  
sqldf("select * from acs where AGEP < 50")  
  
###############################
#         Question 4          #
###############################

library(XML)
url <- "http://biostat.jhsph.edu/~jleek/contact.html"
html <- htmlTreeParse(url, useInternalNodes=T)

con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)

htmlCode
nchar(htmlCode[10])
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])

###############################
#         Question 5          #
###############################

download.file("http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for", destfile = "ncep.for", method = "curl")
temp <- read.fwf("ncep.for", skip=4,widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4)); temp;
sum(temp[4])
names(temp)



