library(data.table)
#wrangle weather data in Ottawa

#to obtain RH and wind data
#read data
Ottawa <- read.csv("input/weather data/Ottawa_2020.csv",header = T)

site.name <- list.files(path = "input/weather data/hourly/",
                        pattern = "*.csv",
                        recursive = TRUE)
#read the data 
temp <- list()
for (i in 1:12) {
  temp[[i]] <- fread(paste("input/weather data/hourly/",site.name[i],sep = ""),
                     select = c(6:9,14,20),fill = TRUE)
}
#rbind them and set as dataframe
DF <- rbindlist(temp)
setDF(DF)

#RH
Ottawa$RH.6 <- DF$`Rel Hum (%)`[DF$`Time (LST)` == "06:00"]
Ottawa$RH.15 <- DF$`Rel Hum (%)`[DF$`Time (LST)` == "15:00"]

#wind speed
wind <- tapply(DF$`Wind Spd (km/h)`,list(DF$Month,DF$Day),mean,na.rm = TRUE)
Ottawa$wind <- round(na.omit(c(t(wind))),2)


#cloud cover
Ottawa$cloud <- round(pmin(Ottawa$SR/Ottawa$Srmax,1),2)

#Date ID
Ottawa$DateID <- as.numeric(as.Date(1:366,origin = "2020-01-01"),by = "days")

#write the csv file
write.csv(Ottawa,file = "input/daily env input_Ottawa.csv",
          row.names = FALSE)
