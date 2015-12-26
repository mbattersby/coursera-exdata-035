# How have emissions from motor vehicle sources changed from 1999–2008 in
# Baltimore City? 

source('fetch.dataset.R')

library(ggplot2)
suppressPackageStartupMessages(library(dplyr))

plot5 <- function () {
    
    balt_pm25 <- pm25 %>%
        filter(fips == 24510) %>%
        filter(grepl('^Mobile - On-Road', EI.Sector)) %>%
        group_by(year) %>%
        summarize(total_emissions = sum(Emissions))
    
    p <- qplot(year, total_emissions, data=balt_pm25) +
        geom_line() +
        geom_smooth(method="lm", se=TRUE, linetype=8, col='red') +
        labs(y = 'Total PM2.5 Emissions (tons)') +
        labs(x = 'Year') +
        geom_hline(yintercept=0) +
        labs(title = 'Motor Vehicle PM2.5 Emissions In Baltimore By Year')
    print(p)
}

png(filename='plot5.png', width=480, height=480)
plot5()
graphics.off()