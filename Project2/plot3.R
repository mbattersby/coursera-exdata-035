# Of the four types of sources indicated by the type (point, nonpoint, onroad,
# nonroad) variable, which of these four sources have seen decreases in
# emissions from 1999–2008 for Baltimore City? Which have seen increases in
# emissions from 1999–2008? Use the ggplot2 plotting system to make a plot
# answer this question.

source('fetch.dataset.R')

library(ggplot2)
suppressPackageStartupMessages(library(dplyr))

plot3 <- function () {
    
    balt_pm25 <- pm25 %>%
        filter(fips == 24510) %>%
        group_by(year, type) %>%
        summarize(total_emissions = sum(Emissions))
    
    p <- qplot(year, total_emissions, data=balt_pm25) +
        geom_line() +
        geom_smooth(method="lm", se=FALSE, linetype=8, col='red') +
        labs(y = 'Total PM2.5 Emissions\n(x 1000 tons)') +
        labs(x = 'Year') +
        labs(title = 'Baltimore PM2.5 Emissions By Year') +
        facet_wrap(~type, ncol=2, scales='free')
    print(p)
}

png(filename='plot3.png', width=480, height=480)
plot3()
graphics.off()