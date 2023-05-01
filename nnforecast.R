##Separate section for neural network


library(nnfor)

library(readxl)
setwd('C:/CIS4930')
data <- read_xlsx("74955.xlsx")

neuraldata <- select(data,c('sdate','Cases'))

neuraldata <- ts(data = neuraldata)

plot(neuraldata)

mlp.fit <- mlp(neuraldata[,2])

plot(mlp.fit)


mlp.forecast <- forecast(mlp.fit,h = 52,include = 20)

plot(mlp.forecast)

nnforecast <- data.frame(mlp.forecast[["mean"]])

