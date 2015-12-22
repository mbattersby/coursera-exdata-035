# Have total emissions from PM2.5 decreased in the United States from 1999 to
# 2008? Using the base plotting system, make a plot showing the total PM2.5
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

source('fetch.dataset.R')

plot1bar <- function () {
    
    total_pm25 <- pm25 %>%
        group_by(year) %>%
        summarize(total_emissions = sum(Emissions) / 1e6)
    
    par(mar=c(3,6,3,1))
    
    with(total_pm25, {
        x_offsets <-barplot(total_emissions,
                            names=year,
                            col="wheat",
                            ylim=c(0,8),
                            ylab='Total PM2.5 Emissions\n(x 1e6 tons)')
        
        text(x_offsets, total_emissions,
             label = paste(round(total_emissions, digits = 2), 'M', sep=''),
             pos = 3,
             col = "steelblue")
        
        points(x_offsets, total_emissions, pch=15)
        lines(x_offsets, total_emissions, lty=5)
        
        title('Total PM2.5 Emissions By Year')
    })
}

plot1scatter <- function () {
    
    total_pm25 <- pm25 %>%
        group_by(year) %>%
        summarize(total_emissions = sum(Emissions) / 1e6)
    
    par(mar=c(3,6,3,1))
    
    with(total_pm25, {
        
        # The return value from barplot is the x positions of the middle of each bar
        
        plot(year, total_emissions, pch=19,
             xlim=c(1998,2009),
             ylim=c(0,8),
             ylab='Total PM2.5 Emissions\n(x 1e6 tons)')
        
        lines(year, total_emissions)
        
        abline(lm(total_emissions ~ year), lty=5, col='red')
        
        # So we can use the X positions to place our text values
        
        text(year, total_emissions,
             label = paste(round(total_emissions, digits = 2), 'M', sep=''),
             pos = 3,
             col = "steelblue")
        
        title('Total PM2.5 Emissions By Year')
    })
}

plot1scatter()