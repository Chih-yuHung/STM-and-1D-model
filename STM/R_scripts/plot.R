# Very strange that some parts of the temp (meas) lines are not plotted with geom_line()
# Can eliminate by dropping temp == NA
# Problem seems to be multiple obs for same doy, some with NA

# Add blank for plot
dl <- rbind(dl, data.frame(site = 'E', date = as.POSIXct('2020-05-09', format = '%Y-%m-%d'), doy = 130, variable = 'Measured slurry', value = NA))

dat$site.nm <- factor(dat$site, levels = c('A', 'E', 'H'), labels = c('Sweden (A)', 'Denmark (E)', 'Canada (H)'))
dl$site.nm <- factor(dl$site, levels = c('A', 'E', 'H'), labels = c('Sweden (A)', 'Denmark (E)', 'Canada (H)'))
#rl$site.nm <- factor(rl$site, levels = c('C', 'E', 'F'), labels = c('Sweden (C)', 'Denmark (E)', 'Canada (F)'))
wthr$site.nm <- factor(wthr$site, levels = c('A', 'E', 'H'), labels = c('Sweden (A)', 'Denmark (E)', 'Canada (H)'))

#
dl <- dl[site %in% c('A', 'E', 'H'), ]
dat <- dat[site %in% c('A', 'E', 'H'), ]

## Issue is I want the NAs for the missing measurement period spring to summer, but I do not want them where there are other obs with measurements (different year)
#dl <- subset(dl, !is.na(value) | 
#	     (site == 'C' & date > as.POSIXct('2021-04-28') & date < as.POSIXct('2021-06-15')) |
#	     (site == 'E' & date > as.POSIXct('2021-03-09') & date < as.POSIXct('2021-07-14')))

dl <- dl[order(dl$doy), ]

ggplot(dl, aes(doy, value, colour = variable)) +
  geom_line() +
  facet_wrap(~ site.nm) +
  labs(x = 'Day of year', y = expression('Temperature'~(degree*C)), 
       colour = '') +
  theme_bw() +
  scale_color_brewer(palette = 'Dark2') +
  theme(legend.position = 'right')
ggsave('../plots/temp_comp_doy.png', height = 3, width = 7)

#ggplot(dat, aes(doy, temp)) +
#  geom_line(aes(doy, floor_temp), colour = 'gray32', lty = 1) +
#  geom_line(aes(doy, air_temp), colour = 'skyblue', lty = 1) +
#  geom_path(col = 'red') +
#  facet_wrap(~ site) +
#  labs(x = 'Day of year', y = expression('Temperature'~(degree*C)), 
#       colour = 'Position (from surface)') +
#  theme_bw() +
#  theme(legend.position = 'top')
#ggsave('../plots/ex3_ave_stor_temp_doy_floor.pdf', height = 3, width = 5)

ggplot(dat, aes(doy, slurry_depth)) +
  geom_line() +
  facet_wrap(~ site.nm) +
  labs(x = 'Day of year', y = 'Slurry depth (m)', 
       colour = 'Position (from surface)') +
  theme_bw() +
  theme(legend.position = 'top')
ggsave('../plots/depth_doy.png', height = 2.1, width = 7)

#ggplot(rl, aes(doy, value/1000, colour = variable)) +
#  geom_line(alpha = 0.7) +
#  facet_wrap(~ site.nm, scales = 'free') +
#  labs(x = 'Day of year', y = expression('Heat flow out'~(kW)), colour = '') +
#  scale_color_brewer(palette = 'Dark2') +
#  theme_bw() +
#  theme(legend.position = 'top') 
#ggsave('../plots/ex3_heat_flow.pdf', height = 3, width = 5)
#
#ggplot(wthr, aes(doy, rad)) +
#  geom_line(alpha = 0.7) +
#  facet_wrap(~ site.nm) +
#  labs(x = 'Day of year', y = expression('Radiation'~(W~m^'-2')), colour = '') +
#  theme_bw() +
#  theme(legend.position = 'top') 
#ggsave('../plots/ex3_radiation.pdf', height = 3, width = 5)
