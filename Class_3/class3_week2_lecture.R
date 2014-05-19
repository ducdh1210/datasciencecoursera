ucscDb <- dbConnect(MySQL(),user="genome",host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb,"show databases;");
dbDisconnect(ucscDb);

hg19 <- dbConnect(MySQL(),user="genome",db="hg19",host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)

allTables[1:5]

dbListFields(hg19,"affyU133Plus2") #list all fields (columns) in a table

dbGetQuery(hg19,"select count(*) from affyU133Plus2")

affyData <- dbReadTable(hg19,"affyU133Plus2")
head(affyData)

dbDisconnect(ucscDb);

#############################
#       HDF5                #
#############################
created = h5createFile("example.h5")
created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","baa")
created = h5createGroup("example.h5","foo/foobaa")
h5ls("example.h5")

A = matrix(1:10,nr=5,nc=2)
h5write(A,"example.h5","foo/A")
B = array(seq(0.1,2.0,by=0.1),dim=c(5,2))
attr(B,"scale") <- "liter"
h5write(B,"example.h5","foo/foobaa/B")
h5ls("example.h5")

#write a data set
df = data.frame(1L:5L,seq(0,1,length.out=5),c("ab","cde","fghi","a","s"),stringAsFactors=FALSE)
h5write(df,"example.h5","df")
h5ls("example.h5")

#read data set
readA = h5read("example.h5","foo/A")
readA = h5read("example.h5","foo/foobaa/B")
readdf = h5read("example.h5","df")
readA

#writing and reading chunks
h5write(c(12,13,14),"example.h5","foo/A",index=list(1:3,1))
h5read("example.h5","foo/A")

#############################
#       WEB                 #
#############################

con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode

# to get pretty format
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=T)

xpathSApply(html,"//title",xmlValue)

xpathSApply(html,"//td[@id='col-citedby']",xmlValue)

# use httr package
library(httr);
html2 = GET(url)
content2 = content(html2,as="text")
parsedHtml = htmlParse(content2,asText=TRUE)
xpathSApply(html,"//title",xmlValue)

# handle website requiring username and password
pg2 = GET("http://httpbin.org/basic-auth/user/passwd",authenticate("user","passwd"))
pg2

names(pg2)

# Using handles
google = handle("http://google.com")
pg1 = GET(handle=google,path="/")
pg2 = GET(handle=google,path="search")
pg1


#############################
#           API             #
#############################

myapp = oauth_app("twitter",key="4tRDkZMRxMd3msSEOiNFkQ",secret="aUqkQiRKPXRXIKyRdv64eVug5avgbmHPmkK6ews")
sig = sign_oauth1.0(myapp,token="51395803-hSMhx8QZA23TDT1NVRhllRnHgCRvnJHlgnh5rQKNC",token_secret="i2yrI5NH7O3Nkod45TJLg6DAZ5MNDH5n8HQchp5P55FRe")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json",sig)

json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]






