library(readxl)
library(forecast)
library(fable)
library(fabletools)
library(lubridate)
#library(tidyr)
library(magrittr)
library(dplyr)
library(tsibble)


getwd()
data <- read_xlsx("forecastproduct1142.xlsx")
  

data <- mutate(data, sdate=yearweek(sdate) )

data<-data%>%
  mutate(sdate=yearweek(sdate))%>%
  as_tsibble()

data<- as_tsibble(mutate(data,sdate=yearweek(sdate)))

data<-fill_gaps(data,.full = start())

data['Cases'] [is.na(data['Cases'])] <- 0
data['Shortcs'] [is.na(data['Shortcs'])] <- 0
data['Shippedcs'] [is.na(data['Shippedcs'])] <- 0

ETSmodel<-data%>%
  model(ETS(Cases))


ARIMAmodel<-data%>%
  model(ARIMA(Cases))

Crostonmodel<-data%>%
  model(CROSTON(Cases))


ETSforecast<-ETSmodel%>%
  forecast(h=52)


ARIMAforecast<-ARIMAmodel%>%
  forecast(h=52)

Crostonforecast<-Crostonmodel%>%
  forecast(h=52)


#neural net with nnfor
library(nnfor)
neuraldata <- select(data,c('sdate','Cases'))
neuraldata <- ts(data = neuraldata)
#plot(neuraldata)
mlp.fit <- mlp(neuraldata[,2])
#plot(mlp.fit)
#print(mlp.fit)
mlp.forecast <- forecast(mlp.fit,h = 52,include = 20)
#plot(mlp.forecast)
forecast <- mlp.forecast[["mean"]]
forecast <- data.frame(forecast)

last <-data %>% slice(n())
last <- last$sdate

forecast$fcsdate<- last
forecast$row_num <- seq.int(nrow(forecast))

forecast$Date <- ((forecast$row_num*7) + forecast$fcsdate)
forecast$Date <- forecast$fcsdate + days(forecast$row_num*7)


last <-data %>% slice(n())
last <- last$sdate
cbind(forecast, last$sdate + 7)

#print(forecast)

