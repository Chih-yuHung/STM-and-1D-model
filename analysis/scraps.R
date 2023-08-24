x <- subset(meas, site == 'H')
x$date
x <- subset(dat, site == 'H')
x$slurry_temp_meas

x <- subset(dl, site == 'H' & variable == 'Meas. slurry')
x$value
x$slurry_temp_meas
x[420:430, .(date, value)]
a1d_sub$date
stm_sub$date

