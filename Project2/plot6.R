# Compare emissions from motor vehicle sources in Baltimore City with
# emissions from motor vehicle sources in Los Angeles County, California
# (fips == "06037"). Which city has seen greater changes over time in motor
# vehicle emissions?

source('fetch.dataset.R')

library(ggplot2)
library(lattice)
suppressPackageStartupMessages(library(dplyr))

plot6 <- function () {
    
    comp_pm25 <- pm25 %>%
        filter(fips == '24510' | fips == '06037') %>%
        filter(grepl('^Mobile - On-Road', EI.Sector)) %>%
        group_by(year, fips) %>%
        summarize(total_emissions = sum(Emissions))
    
    # This is a bit ugly, but it makes the factor plot display come out nicely.
    
    comp_pm25$fips[comp_pm25$fips == '24510'] <- c('Baltimore City')
    comp_pm25$fips[comp_pm25$fips == '06037'] <- c('Los Angeles County')
    
    p <- qplot(year, total_emissions, data=comp_pm25) +
        facet_wrap(~fips, ncol=2, scale='free') +
        geom_line() +
        geom_smooth(aes(color=fips), method="lm", se=FALSE, linetype=8) +
        labs(y = 'Total PM2.5 Emissions (tons)\n(Scaled separately)') +
        labs(x = 'Year') +
        labs(title = 'Motor Vehicle PM2.5 Emissions By Year')
    
    print(p)

}

# Lattice plot version, just for fun.
plot6lattice <- function () {
    
    comp_pm25 <- pm25 %>%
        filter(fips == '24510' | fips == '06037') %>%
        filter(grepl('^Mobile - On-Road', EI.Sector)) %>%
        group_by(year, fips) %>%
        summarize(total_emissions = sum(Emissions))
    
    # This is a bit ugly, but it makes the factor plot display come out nicely.
    
    comp_pm25$fips[comp_pm25$fips == '24510'] <- c('Baltimore City')
    comp_pm25$fips[comp_pm25$fips == '06037'] <- c('Los Angeles County')
    
    p <- xyplot(total_emissions ~ year | fips, data=comp_pm25,
                main = 'Motor Vehicle PM2.5 Emissions By Year',
                xlab = 'Year',
                ylab = 'Total PM2.5 Emissions (tons)\n(Scaled Separately)',
                scales=list('relation'='free'),
                panel = function (...) {
                    panel.xyplot(..., type='b')
                    panel.grid(...)
                    panel.lmline(..., lty=8)
                })
    
    print(p)
}

png(filename='plot6.png', width=480, height=480)
plot6()
graphics.off()
