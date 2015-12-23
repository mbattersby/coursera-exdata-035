# Compare emissions from motor vehicle sources in Baltimore City with
# emissions from motor vehicle sources in Los Angeles County, California
# (fips == "06037"). Which city has seen greater changes over time in motor
# vehicle emissions?

source('fetch.dataset.R')

library(ggplot2)
suppressPackageStartupMessages(library(dplyr))

plot6 <- function () {
    
    balt_pm25 <- pm25 %>%
        filter(fips == '24510' | fips == '06037') %>%
        filter(grepl('^Mobile - On-Road', EI.Sector)) %>%
        group_by(year, fips) %>%
        summarize(total_emissions = sum(Emissions))
    
    p <- qplot(year, total_emissions, data=balt_pm25) +
        facet_wrap(~fips, ncol=2, scale='free') +
        geom_line() +
        geom_smooth(method="lm", se=TRUE, linetype=8, col='red') +
        labs(y = 'Total PM2.5 Emissions (tons)') +
        labs(x = 'Year') +
        geom_hline(yintercept=0) +
        labs(title = 'Motor Vehicle PM2.5 Emissions By Year')
    print(p)
}

plot6()