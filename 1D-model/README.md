# Introduction to the 1D-model
  This repo showed our script to simulate manure temperatures in three tanks in Canada, Denmark and Sweden.

# Data input
  Data input are in the folder **input**. Four input files are needed for the simulation. __daily env input_*.csv__ is the environmental input file. __Initial M temp.csv__ is the initial manure temperature and __Initial S temp.csv__ is the initial soil temperature. These two initial temperature barely influence simulation results because the a four-year simulation was conducted to stabilize the result. 
  Parameters input files are named with the city. __Backa_*.csv__, __Ottawa_*.csv__, __Tjele_*.csv__ are provided to obtain the result in the manuscript. 
  
  
# Model description
##  Over all control
  Scripts 1 to 7 are the scripts for temperature simualtion. __1. Main.R__ is the script used to provide tank name and test number, which controls the parameter inputs,e.g. __Ottawa_*.csv__. People who wants to try the influence of parameters can adjust the parameters in the csv file. 
  In the __1. Main.R__, it reads __3.Parameters.R__ and __4.Constant.R__ before running the simulation __2. Main loop.R__. The previous two script read and calculate necessary parameters and variables for the simulation. The __2. Major loop.R__ then run the simulations that calculate snow depth, heat transfer between manure, air, and soil, and manure volume. Detailed information regarding the model is described in the manuscript.
  
## function of the script
  __3.1 snow depth.R__ calculate the snow depths (work while reading the parameters) and pass the snow depth to __3.2.Alpha.s_adjustment.R__ to obtain the new daily alpha.

  __5. Manure volume.R__ and __5.1 Manure volume removal.R__ control the daily manure volume, and please note that __5.1 Manure volume removal.R__ is a added submodel in this study.
  
  __6. Solar radiation and soil temp_shade.R__ is the major part to calcualte heat transfer. It calculates solar radiation with shade revision, evaporation heat transfer, convection heat transfer between air and manure and between manure layers, conduction heat transfer between manure layers and between manure and soil. Daily evaporation depth is alos obtained in this script. __6.1 Enthalpy calculation.R__ calculate the enthalpy at the end of day that influenced by precipitation and manure removal/addition. 
  
  __7. hourly temp.R__ and __7.1 temp at three depth.R__ do not involve in manure temperature calculation, but calculate results. 

## Input parameters
The **Start date** and **End date** indicate the start and end date of simulation. The **removal start date** and **removal end date** are the dates of removal. 

**mixing day** is an unessential parameter when farms pump manure to tanks daily. 

Basic characteristic of tanks are necessary for the model, including **Htank (height of tank)**, **ri (radius of tank)**, **Latitude**, and **altitude**. 

Some manure properties are also essential as they influence heat transfer and absorption, including **Total volatile solid**, **Incoming manure temperature**, **Solar absroptivity**,**Emissivity**.

Meteorological parameters can be assumed including **Extraterrestrial solar flux density**, **Atmospheric transimttance**, **air thermal conductivity**, 

Vapouration affects heat loss in summer and winter. We therefore include Teten's equation (**Teten's constant**) and **freezing and thawing point**, which could change due to the solid protion in slurry.

Soil properties influence heat transfer between the bottom of manure tanks and soils. **Soil density**, **Soil thermal conductivity**, **Soil specific heat** are required for the simulation. 

Snow accumulation reduce heat transfer from cold air to manure and reflect more solar radiation, and it prevent increasing manure volume before snow melting. Model users should decide the snow melting temperatures for simulating snow accumulation in **snow min crit, max crit, melt r, sublimation threshold, sublimation r**


