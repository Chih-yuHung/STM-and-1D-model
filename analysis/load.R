
# Measurements
meas <- fread('../temp-meas/data-daily/daily_meas_temp.csv')
meas[site == 'A', country := 'Sweden']
meas[site == 'E', country := 'Denmark']

mh <- fread('../temp-meas/data-daily/daily_meas_temp_H.csv')
mh[, site := 'H']

meas <- rbind(meas, mh, fill = TRUE)

meas$date <- as.POSIXct(meas$date, tz = 'EST')

# STM results
stm <- data.frame()
ff <- list.files('../STM/stm_output', pattern = 'temp.csv')
for (i in ff) {
  d <- fread(paste0('../STM/stm_output/', i), skip = 2, header = TRUE)
  d$site <- substr(i, 1, 1)
  stm <- rbind(stm, d)
}

stm[site == 'H', year := 2016 + year]
stm[site != 'H', year := 2017 + year]
stm[, date := as.POSIXct(paste(year, doy), format = '%Y %j', tz = 'EST')]
# Drop 2 start-up years
##stm <- subset(stm, year > 2019)
# NTS

## Rates
#rates <- data.frame()
#ff <- list.files('../stm_output', pattern = 'rates.csv')
#for (i in ff) {
#  d <- fread(paste0('../stm_output/', i), skip = 2, header = TRUE)
#  d$site <- substr(i, 1, 1)
#  rates <- rbind(rates, d)
#}
#
#rl <- melt(rates, id.vars = c('day', 'doy', 'year', 'site'), 
#	   measure.vars = c('rad', 'air', 'floor', 'lower_wall', 'upper_wall', 'total'))
#
#rl$variable <- factor(rl$variable, levels = c('total', 'air', 'rad', 'upper_wall', 'lower_wall', 'floor'),
#                                   labels = c('Total', 'Air', 'Radiation', 'Upper wall', 'Lower wall', 'Floor'))

# 1D results . . .
a1d <- data.frame()

wthr <- data.frame()
ff <- list.files('../STM/stm_output', pattern = 'weather.csv')
for (i in ff) {
  d <- fread(paste0('../STM/stm_output/', i), skip = 2, header = TRUE)
  d$site <- substr(i, 1, 1)
  wthr <- rbind(wthr, d)
}
wthr[site == 'H', year := 2016 + year]
wthr[site != 'H', year := 2017 + year]
wthr[, date := as.POSIXct(paste(year, doy), format = '%Y %j', tz = 'EST')]
##wthr <- subset(wthr, year > 2019)
