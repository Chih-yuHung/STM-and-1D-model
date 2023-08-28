# Combine two ways, long (plots) and wide (numeric evaluation)

# Merge
meas[, slurry_temp_meas := temp]
stm_sub <- stm[, .(site, date, doy, slurry_mass, slurry_depth, air_temp, slurry_temp_stm)]
a1d_sub <- a1d[, .(site, date, doy, slurry_temp_a1d)]
mod <- merge(stm_sub, a1d_sub, by = c('site', 'date', 'doy'), all = TRUE)
dat <- merge(meas, mod, by = c('site', 'date', 'doy'), all = TRUE)

# Trim to within model data period (instead of all = FALSE above to get gap in Tjele data)
dat[, `:=` (date.min = min(date[!is.na(slurry_temp_meas)]), date.max = max(date[!is.na(slurry_temp_meas)])), by = site]
dat <- dat[date >= date.min & date <= date.max, ]

# long format for plots
dl <- melt(dat, id.vars = c('site', 'date', 'doy'),
           measure.vars = c('air_temp', 'slurry_temp_stm', 'slurry_temp_a1d', 'slurry_temp_meas', 'slurry_depth'))

dl$variable <- factor(dl$variable, levels = c('air_temp', 'slurry_temp_meas', 'slurry_temp_stm', 'slurry_temp_a1d', 'slurry_depth'), 
		      labels = c('Meas. air T', 'Meas. slurry T', 'STM slurry T', 'A1D slurry T', 'Slurry depth'))

dl[, vtype := 'temp']
dl[variable == 'Slurry depth', vtype := 'level']
dl[, vtype := factor(vtype, levels = c('temp', 'level'), labels = c('Temperature', 'Slurry depth'))]
