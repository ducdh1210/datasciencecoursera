## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'pollutant' is a character vector of length 1 indicating
## the name of the pollutant for which we will calculate the
## mean; either "sulfate" or "nitrate".

## 'id' is an integer vector indicating the monitor ID numbers
## to be used

## Return the mean of the pollutant across all monitors list
## in the 'id' vector (ignoring NA values)

pollutantmean <- function(directory, pollutant, id = 1:332) {
  ##Get a list of filenames
  #filenames <- list.files(path=directory, pattern="*.csv")
  
  ## Initialize a vector to hold values
  vals <- vector()
  
  ## Loop over the passed id's
  for(i in id) {
    
    ## Create file name and file path using i
    filename <- sprintf("%03d.csv", i) # return looks like: "001.csv"
    filepath <- paste(directory, filename, sep="/") # kind of like concatenate string with seperator
    
    ## Load the data
    data <- read.csv(filepath)
    
    ## Select our column --> Note that the return value is of type numeric. If d <- data[pollutant], then d is of type data.frame. Good lesson here
    d <- data[,pollutant]
    
    ## Ignore NAs
    d <- d[!is.na(d)]
    
    ## append to our vector
    vals <- c(vals, d)
  }
  
  ## Return the value rounded to 3 dec places
  round(mean(vals), 3)
}