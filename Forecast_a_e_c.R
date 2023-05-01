library(readxl)
library(forecast)
library(fable)
library(fabletools)
library(lubridate)
library(magrittr)
library(dplyr)
library(tsibble)


setwd('C:/CIS4930')
data <- read_xlsx("74955.xlsx")
  
#Convert to TS and mutate date

data<-data%>%
  mutate(sdate=yearweek(sdate))%>%
  as_tsibble()

#Filling missing dates and 0s

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

