#Radiation data from 2020/5/1-2021/4/30 from 
rad<-read.csv("1D-model/input/raw weather data/solar radiation Tjele_20010101-20230817.csv",
              header=T)
rad$monthday<-substring(rad[,1],first=6,last=10)
rad$glorad <- ifelse(rad$glorad == "null", 0, rad$glorad)
radiation.max<-tapply(as.numeric(rad$glorad),rad$monthday,max)
radiation.max1<-radiation.max[c(275:366,1:59,61:275)] #to start from Oct 1.

env<-read.csv("1D-model/input/daily env input_Tjele.csv",
              header=T)

env$Srmax <- radiation.max1
# it's not linear regression between SR and SRmax
env$cloud <- pmin(ifelse(env$SR<env$Srmax,((1-env$SR/env$Srmax)/0.72)^(1/3.2),0),1)

write.csv(env,file = "1D-model/input/daily env input_Tjele.csv")
