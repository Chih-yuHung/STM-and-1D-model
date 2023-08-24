
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

stm[, model := 'STM']

stm[site == 'H', year := 2016 + year]
stm[site != 'H', year := 2017 + year]
stm[, date := as.POSIXct(paste(year, doy), format = '%Y %j', tz = 'EST')]

stm[, slurry_temp_stm := slurry_temp]

# Drop 2 start-up years
##stm <- subset(stm, year > 2019)
# NTS

a1d <- data.table()
d <- fread('../1D-model/output/Canada/Canada_result_1.csv', header = TRUE)
d[, site := 'H']
a1d <- rbind(a1d, d)

d <- fread('../1D-model/output/Sweden/Sweden_result_1.csv', header = TRUE)
d[, site := 'A']
a1d <- rbind(a1d, d)

a1d[, slurry_temp := (temp.05 + temp.15 + temp.25) / 3]
a1d[, slurry_temp_a1d := slurry_temp]

a1d[, model := 'A1D']
a1d[, date := as.POSIXct(paste(Year, DOY), format = '%Y %j', tz = 'EST')]
#a1d[, date := as.POSIXct(paste(Year, Month, Day), format = '%Y %m %d')]
a1d[, doy := DOY]

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
