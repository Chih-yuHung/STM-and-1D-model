# Fit stats

# Trim to obs with both (2) models and measurements
datstat <- dat[!is.na(slurry_temp_meas) & !is.na(slurry_temp_stm) & !is.na(slurry_temp_a1d), ]

dsl <- melt(datstat, id.vars = c('site', 'date', 'doy', 'slurry_temp_meas', 'air_temp', 'slurry_depth'),
            measure.vars = c('slurry_temp_stm', 'slurry_temp_a1d'))

fit <- dsl[, .(rmse = rmse(slurry_temp_meas, value),
               mae = mae(slurry_temp_meas, value),
               mbe = mbe(slurry_temp_meas, value),
               me = me(slurry_temp_meas, value)
               ), by = .(site, variable)]

fit <- rounddf(fit, 2)
