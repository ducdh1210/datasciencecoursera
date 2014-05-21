# QUESTION 1
# what is the mean of 'Sepal.Length' for the species virginica? # answer: 6.588
library(datasets)
data(iris)

s <- split(iris, iris$Species)
sapply(s, function(x) colMeans(x["Sepal.Length"], na.rm=TRUE))

# QUESTION 2
# returns a vector of the means of the variables 'Sepal.Length', 'Sepal.Width', 'Petal.Length', and 'Petal.Width'?
apply(iris[, 1:4], 2, mean)

# QUESTION 3
#How can one calculate the average miles per gallon (mpg) by number of cylinders in the car (cyl)?
library(datasets)
data(mtcars)
average_mpg_for_cyl = tapply(mtcars$mpg, mtcars$cyl, mean) #answer: 11.56364

# Question 4
#what is the absolute difference between the average horsepower of 4-cylinder cars and the average horsepower of 8-cylinder cars?
average_hp_for_cyl = tapply(mtcars$hp, mtcars$cyl, mean)
abs(average_hp_for_cyl['4'] - average_hp_for_cyl['8'])
