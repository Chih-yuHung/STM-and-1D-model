# Very strange that some parts of the temp (meas) lines are not plotted with geom_line()
# Can eliminate by dropping temp == NA
# Problem seems to be multiple obs for same doy, some with NA

# Add blank for gap in plot
dlp <- rbind(dl, data.frame(site = 'E', date = as.POSIXct('2020-05-09', format = '%Y-%m-%d'), doy = 130, variable = 'Measured slurry', value = NA, vtype = 'Temperature'), fill = TRUE)
dlp$site.nm <- factor(dlp$site, levels = c('A', 'E', 'H'), labels = c('Sweden (A)', 'Denmark (E)', 'Canada (H)'))
wthr$site.nm <- factor(wthr$site, levels = c('A', 'E', 'H'), labels = c('Sweden (A)', 'Denmark (E)', 'Canada (H)'))
dlp <- dlp[site %in% c('A', 'E', 'H'), ]
dlp <- dlp[order(dlp$doy), ]

ggplot(dlp, aes(doy, value, colour = variable)) +
  geom_hline(yintercept = 0, lty = '1111') +
  geom_line() +
  labs(x = 'Day of year', y = expression('Temperature'~(degree*C)), 
       colour = '') +
  theme_bw() +
  scale_color_brewer(palette = 'Dark2') +
  facet_grid(vtype ~ site.nm, scale = 'free_y') +
  theme(legend.position = 'top')
ggsave('../plots/temp_level.png', height = 4, width = 7)
