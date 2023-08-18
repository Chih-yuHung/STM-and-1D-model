library(REdaS); library(xlsx); library(beepr) ;library(dplyr); library(imputeTS)
#Set location, initial date and end time; date origin in R, 1970-1-1

test <- 1  #the test number
Location <- "Ottawa"
source("1D-model/3. Parameters.R",echo = F)  #Parameters we can change
source("1D-model/4. Constants.R",echo = F)   #Constants no need to change
#The major loop for original model
source("1D-model/2. Major loop.R",echo = F)
source("1D-model/Result comparison.R",echo = F)
source("1D-model/stat output.R", echo =  F)



