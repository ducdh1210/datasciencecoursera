makeVector <- function(x = numeric()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setmean <- function(mean) m <<- mean
  getmean <- function() m
  list(set = set, get = get,
       setmean = setmean,
       getmean = getmean)
}

new_vector = makeVector()
new_vector$set(c(1,2,3,4,5))
new_vector$get()
new_vector$setmean(mean(new_vector$get()))
new_vector$getmean()

