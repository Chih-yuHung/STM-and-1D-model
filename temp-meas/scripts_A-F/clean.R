
dat.se$country <- 'Sweden'
dat.dk$country <- 'Denmark'

dat <- rbind(dat.se, dat.dk)

dat$date.time <- ymd_hm(dat$date.time)
dat$date <- date(dat$date.time)

# Save all depths for plotting
dat.all <- dat

# Find highest and lowest depths for calculating unbiased average
dat[, depth.min := min(depth), site]
dat[, depth.max := max(depth), site]

# Subset to min and max depths (so only top and bottom are used for average, I think)
dat <- subset(dat, depth == depth.min | depth == depth.max)

# Remove what are apparently air or sensor-in-sun temperatures from early site C measurements
dat <- subset(dat, site != 'C' | as.Date(date) > as.Date('2020-06-18'))

# And remove some strange Tjele measurements at start and end, presumably sensors not in slurry
dat <- subset(dat, site != 'E' | as.Date(date) > as.Date('2020-09-26'))

# Average measured temperature
dat.mean <- data.table(aggregate(temp ~ site + date, data = dat, FUN = mean))

# DOY
dat.mean$doy <- as.integer(as.character(dat.mean$date, format = '%j'))

# Get unique depths used for reporting
depths <- unique(dat[, c('site', 'depth.min', 'depth.max')])

# Get date ranges
dates <- aggregate(date ~ site, data = dat.mean, FUN = function(x) as.character(range(x)))
