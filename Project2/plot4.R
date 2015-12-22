# Across the United States, how have emissions from coal combustion-related
# sources changed from 1999–2008?

source('fetch.dataset.R')

library(ggplot2)
suppressPackageStartupMessages(library(dplyr))

plot4 <- function () {
    
    balt_pm25 <- pm25 %>%
        filter(grepl('^Fuel Comb - .* - Coal$', EI.Sector)) %>%
        group_by(year) %>%
        summarize(total_emissions = sum(Emissions) / 1000)
    
    p <- qplot(year, total_emissions, data=balt_pm25) +
        geom_line() +
        geom_smooth(method="lm", se=FALSE, linetype=8, col='red') +
        labs(y = 'Total PM2.5 Emissions\n(x 1000 tons)') +
        labs(x = 'Year') +
        labs(title = 'Total Coal PM2.5 Emissions By Year')
    print(p)
}

plot4()