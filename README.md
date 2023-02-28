# STM-and-1D-model
In this project, Sasha Hafner and Chih-Yu Hung compared the performance two slurry temperature model with three data set measured in Canada, Denmark, and Sweden. 


# Input files
## Ottawa data
  The weather data, air temperature, wind speed, precipitation, and RH were obtained from Environment Canada. The missing data were interpolated. The solar radiation data were purchased from the Climatology Services. Maximum solar radiations were the maximum solar radiation for the period of 1971-2000 which were used in Rennie et al., 2021. 



# Output files/measured data
## Ottawa data
  The measured manure temperature data from Ottawa was obtained in 2020 ("2020 FF DatasetManureTemperatureAndDepth_Calmar2020_HB"). Manure temperatures at four depths (surface, upper, middle, which is 1m below surface, and bottom) were measured. The avg. manure temperature were the avg. of the four measurements. 
In the Ottawa.daily.csv, temp.s is the manure surface temperature, temp.up is the temperature below the surface float (15cm), temp.m is the temperature 1 m below the float, temp.b is the temperature 10 cm above the bottom. Note that the surface T is measured remotely (not physical in contact with the manure) using a sonic range sensor. However, the upper one is inside the manure measured using a thermistor (T109). The surface T and the Air T are very similar sometime the surf T is higher because the surface of manure which could absorb solar radiation.
 The depth data (Ottawa.depth.csv) was from the raw sheet "Chart3ManureDepth" as well. This was measureed by SR50AT
Sonic Distance Sensor with Temperature Sensor (https://www.campbellsci.ca/sr50at).
      
