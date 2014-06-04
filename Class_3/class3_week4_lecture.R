############################
#   Working with text      #
############################

cameraData <- read.csv("cameras.csv")
names(cameraData)

tolower(names(cameraData))

# fixing character vectors
splitNames = strsplit(names(cameraData),"\\.")
splitNames[[5]]

# quick aside, list
myList <- list(letters = c("A","b","c"), numbers = 1:3, matrix(1:25, ncol=5))
head(myList)

myList[1]
myList$letters
myList[[1]]

# sapply": apply a function to each element in a vector or list
splitNames[[6]][1]

firstElement <- function(x){x[1]}
sapply(splitNames,firstElement)

fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1, destfile="reviews.csv",method="curl")
download.file(fileUrl2, destfile="solutions.csv",method="curl")
reviews <- read.csv("reviews.csv")
solutions <- read.csv("solutions.csv")
head(reviews,2)
head(solutions,2)

# fix character vectors - sub()
names(reviews)
sub("_","",names(reviews),) # pattern, replacement, x
testName <- "this_is_a_test"
gsub("_","",testName)

# finding values - grep() grepl()
grep("Alameda",cameraData$intersection) # rows contains "Alameda"
table(grepl("Alameda",cameraData$intersection)) # Tables of False, True. False indicates number of intances when search returns False, same as True
cameraData2 <- cameraData[!grepl("Alameda",cameraData$intersection),]
grep("Alameda",cameraData$intersection,value=TRUE) # explicitly returns value where search is true
grep("JeffStret",cameraData$intersection)
length(grep("JeffStret",cameraData$intersection)) # check to see if search return any value

# useful string function
library(stringr)
nchar("Duc Do")
substr("Duc Do",1,7)
paste("Duc","Do")
paste0("Duc","Do")
str_trim("Duc      ")

############################
#   Regular expression     #
############################

# ^i think: matches all the lines starting with "i think"
# morning$: matches all the lines ending with "morning"
# [Bb][Uu][Ss][Hh]
# ^[Ii] am
# ^[0-9][a-zA-Z] : a range of letters. Note: orders does not matter
# [^?.]$: anything whose those ending character is neither (because of ^) ? or .
# . means any character. For example, 9.11 can refers to 9-11 or 9:11 or 9u11 or 9911
# | means or. Example: ^[Gg]ood|[Bb]ad --> beginning of the line with word good (maybe or maybe not capitalized) or any sentences containing bad (maybe or maybe not capitalized)
# ? means indicated expression is optional [Gg]eorge([Ww]\.)?[Bb]ush --> [Ww] is optional. Note \. means do not consider . is a metacharacter
# * and + means repetitions. * means any number, including none, + means at least one item
# example: [0-9]+(.*)[0-9]+ --> any number followed by any character followed by any number
# { and } are referred to as interval quantifiers, let us specify the minimum and maximum number of matches of an expression
# example: [Bb]ush( +[^ ]+ +){1,5} debate means 1 and 5 words between Bush and debate
# (and) can be used as :(1) limit the scope of alternatives divided by a "|" (2) remember text matched by subexpression enclosed
# refer to the matched text with \1 \2
# Expression:  +([a-zA-Z]+) +\1 + will matches "time for bed, night night twitter!" or "blah blah blah" or "my tataoo is so so ichy today"
# "*" is greedy so it always matches the longest possible string that satisfys the regular expression. To make it less greedy ^s(.*?)s$
 
############################
#   Working with Date      #
############################

d1 = date()
d1
class(d1)

d2 = Sys.Date()
d2
class(d2)

format(d2,"%a %b %d") # lower case means abbreviated format

# creating dates
x = c("1jan1960","2jan1960","31jan1960","30july1960"); z = as.Date(x, "%d%b%Y")
z[1] - z[2]
as.numeric(z[1] - z[2])
weekdays(d2)
months(d2)
julian(d2)

# using Lubridate
library(lubridate); ymd("20140108")
mdy("08/04/2013")
dmy("03-04-2013")
ymd_hms("2011-08-03 10:15:03")
ymd_hms("2011-08-03 10:15:03",tz="Pacific/Auckland")
?Sys.timezone

x = dmy(c("1jan1960","2jan1960","31jan1960","30july1960")); 
wday(x[1])
wday(x[1],label=TRUE)



