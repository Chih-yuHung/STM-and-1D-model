#to obtain RH6 and RH15 for Backa site
hourlydata <- read.csv("1D-model/input/raw weather data/Backa_hourly_20200516-20210516.csv",
                       header=T)
dailydata <- read.csv("1D-model/input/daily env input_Backa.csv",
                       header=T)

RH6 <- as.numeric(hourlydata$RH15[hourlydata$KL=="600"])
RH15 <- as.numeric(hourlydata$RH15[hourlydata$KL=="1500"])

dailydata$RH.6 <-RH6
dailydata$RH.15 <-RH15

#calculate cloud cover
dailydata$cloud <- round(ifelse(dailydata$SR<dailydata$Srmax,
                          ((1-dailydata$SR/dailydata$Srmax)/0.72)^(1/3.2),0),2)


write.csv(dailydata, 
          file = "1D-model/input/daily env input_Backa.csv")
