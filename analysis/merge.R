
# Merge
meas[, slurry_temp_meas := temp]
dat <- merge(meas, stm, by = c('site', 'date', 'doy'), all = TRUE)

# Trim to within model data period (instead of all = FALSE above to get gap in Tjele data)
dat[, `:=` (date.min = min(date[!is.na(slurry_temp_meas)]), date.max = max(date[!is.na(slurry_temp_meas)])), by = site]
dat <- dat[date >= date.min & date <= date.max, ]

# long format for plots
dl <- melt(dat, id.vars = c('site', 'date', 'doy'),
           measure.vars = c('air_temp', 'slurry_temp', 'slurry_temp_meas', 'slurry_depth'))

dl$variable <- factor(dl$variable, levels = c('air_temp', 'slurry_temp_meas', 'slurry_temp', 'slurry_depth'), 
		      labels = c('Measured air', 'Measured slurry', 'STM slurry', 'Slurry depth'))


dl[, vtype := 'temp']
dl[variable == 'Slurry depth', vtype := 'level']
dl[, vtype := factor(vtype, levels = c('temp', 'level'), labels = c('Temperature', 'Slurry level'))]
