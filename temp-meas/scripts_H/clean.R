
names(dat) <- tolower(names(dat))
dat$country <- 'Canada'
dat[, date := as.POSIXct(paste(year, month, day), format = '%Y %m %d')]

# Calculate average temperature as mean of only 2 depths
dat[, temp := temp.avg]

# Get date ranges
dates <- range(dat[, date])

# Select data for export
dat.sel <- dat[, .(year, date, doy, temp, country)]
