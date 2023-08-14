
# Measurements
meas <- fread('../temp_meas/daily_meas_temp.csv')
meas[site == 'A', country := 'Sweden']
meas[site == 'E', country := 'Denmark']

mh <- fread('../temp_meas/daily_meas_temp_H.csv')
mh[, site := 'H']

meas <- rbind(meas, mh, fill = TRUE)

meas$date <- as.POSIXct(meas$date, tz = 'EST')

# Model results
mod <- data.frame()
ff <- list.files('../stm_output', pattern = 'temp.csv')
for (i in ff) {
  d <- fread(paste0('../stm_output/', i), skip = 2, header = TRUE)
  d$site <- substr(i, 1, 1)
  mod <- rbind(mod, d)
}

mod[site == 'H', year := 2016 + year]
mod[site != 'H', year := 2017 + year]
mod[, date := as.POSIXct(paste(year, doy), format = '%Y %j', tz = 'EST')]
# Drop 2 start-up years
##mod <- subset(mod, year > 2019)
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

wthr <- data.frame()
ff <- list.files('../stm_output', pattern = 'weather.csv')
for (i in ff) {
  d <- fread(paste0('../stm_output/', i), skip = 2, header = TRUE)
  d$site <- substr(i, 1, 1)
  wthr <- rbind(wthr, d)
}
wthr[site == 'H', year := 2016 + year]
wthr[site != 'H', year := 2017 + year]
wthr[, date := as.POSIXct(paste(year, doy), format = '%Y %j', tz = 'EST')]
##wthr <- subset(wthr, year > 2019)
