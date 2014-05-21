# what is the mean of 'Sepal.Length' for the species virginica?

library(datasets)
data_iris = data(iris)

s <- split(iris, iris$Species)
lapply(s, function(x) colMeans(x[,c("Sepal.Length")]))

