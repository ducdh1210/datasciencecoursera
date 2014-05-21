####################################################################################################################################################
# Write a function that reads a directory full of files and reports the number of completely observed cases in each data file.                     #
# The function should return a data frame where the first column is the name of the file and the second column is the number of complete cases     #  
####################################################################################################################################################

## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'id' is an integer vector indicating the monitor ID numbers
## to be used

## Return a data frame of the form:
## id nobs
## 1  117
## 2  1041
## ...
## where 'id' is the monitor ID number and 'nobs' is the
## number of complete cases

# complete <- function(directory, id = 1:332) {
#   #initialize dataframe
#   #df <- data.frame(id,nrow=length(id),ncol=2)
#   #df[2] <- 0 #same effect as df[,2] <- 0 
#   
#   ## Initialize a vector to hold values
#   ids <- vector()
#   counts = vector()
#   
#   ## Loop over the passed id's
#   for(i in id) {
#     
#     ## Create file name and file path using i
#     filename <- sprintf("%03d.csv", i) # return looks like: "001.csv"
#     filepath <- paste(directory, filename, sep="/") # kind of like concatenate string with seperator
#     
#     ## Load the data
#     data <- read.csv(filepath) # --> data is a dataframe
#     
#     ## d is a subset with complete rows 
#     d <- subset(data,!is.na(data[1]) & !is.na(data[2]))
#     
#     ## count the number of not NA in d
#     nob <- dim(d)[1]
#     
#     ## Calculate and store the count of complete cases
#     #     completeCases <- data[complete.cases(data),]
#     #     counts <- c(counts, nrow(completeCases))
#     
#     ## Store the id
#     ids <- c(ids, i)
#     counts <- c(counts,nob)
#   }
#   ## Return the data frame
#   data.frame(id=ids, nobs=counts)
# }

complete <- function(directory, id = 1:332) {
  
  ## Get a list of filenames
  filenames <- list.files(path=directory, pattern="*.csv")
  
  ## Initialize variables
  ids <-vector()
  counts = vector()
  
  ## Loop over the passed id's
  for(i in id) {
    
    ## Pad the i to create a filename
    filename <- sprintf("%03d.csv", i)
    filepath <- paste(directory, filename, sep="/")
    
    ## Load the data
    data <- read.csv(filepath)
    
    ## Store the id
    ids <- c(ids, i)
    
    ## Calculate and store the count of complete cases
    completeCases <- data[complete.cases(data),]
    counts <- c(counts, nrow(completeCases))
  }
  
  ## Return the data frame
  data.frame(id=ids, nobs=counts)
}

