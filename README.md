---
name: "Simple 4 method time series forecasting"
about: The following R script allows you to quickly calculate a time series forecast with 4 different methods.
labels: Forecasting

---

## Description
The code can work as an easy to use forecasting tool for a single product. It uses 4 different types of forecasting methods: ARIMA, ETS, Croston, and neural network. The data used is a modified dataset, the column "cases" reflects the demand. The column "product" is a unique product number and "nationalaccount" and "warehouse" are both used for identification purposes. Download the spreadshit "74955" to try the code yourself.

## Libraries
- readxl
-forecast
-fable
-fabletools
-lubridate
-magrittr
-dplyr
-tsibble
-nnfor


### Basic example
 After loading the packages and the excel file, the data should look like this:
 
 <img width="956" alt="image" src="https://user-images.githubusercontent.com/129782426/235540706-fc2cd990-4ede-4a4f-83ea-5f13b78b83de.png">


Then you have to convert it into a time series and mutate the sdate column to have in weeks:

<img width="602" alt="image" src="https://user-images.githubusercontent.com/129782426/235540849-30ebbae4-d38c-4a6e-891c-6a6b18cb19cb.png">

The forecast functions won't understand that the missing weeks have 0 sales so You will have to fill the missing weeks and input the 0s, the result will be the following:

<img width="601" alt="image" src="https://user-images.githubusercontent.com/129782426/235541008-8c8e5c48-780a-43a8-9c4b-c62103e5072e.png">


Finally you can run the models and forecast, here is the result for the ARIMAforecast, the column ".mean" is the forecast value:

<img width="954" alt="image" src="https://user-images.githubusercontent.com/129782426/235541196-a664cfb3-4b27-4ee2-b385-c79d17c7ec16.png">


As you can tell, for the neural networks we have to do a slightly different process.

We first use the select function to create a new dataframe with only the date and the sales:

<img width="952" alt="image" src="https://user-images.githubusercontent.com/129782426/235541631-48426ffc-a292-45ed-a945-9b4ae918943c.png">

After converting the data into a time series we can fit it into the model, the following is a graphic of the model:

![image](https://user-images.githubusercontent.com/129782426/235541845-9e721694-a119-4cfe-a478-11b6975d3148.png)

Finally we produce the forecast which would look like this :

<img width="956" alt="image" src="https://user-images.githubusercontent.com/129782426/235542056-3e3fe15f-aabe-42da-8e17-23455afda244.png">






