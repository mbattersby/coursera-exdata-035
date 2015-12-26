# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a
# plot answering this question.

# fetch.dataset leaves a tidied pm25 in the global environment for us to work on.
source('fetch.dataset.R')

# Bar plot version, ultimately not used because the lmline was too useful.
plot2bar <- function () {
    
    # dplyr, filter by fips of Baltimore City
    balt_pm25 <- pm25 %>%
        filter(fips == '24510') %>%
        group_by(year) %>%
        summarize(total_emissions = sum(Emissions) / 1e3)
    
    # Bigger margins again, to fit in the 2-line ylab
    par(mar=c(3,6,3,1))
    
    with(balt_pm25, {
        
        # The return value from barplot is the x positions of the middle of each bar
        
        x_offsets <- barplot(total_emissions,
                             names=year,
                             col="wheat",
                             ylim=c(0,4),
                             ylab='Total PM2.5 Emissions\n(x 1000 tons)')
        
        
        # So we can use the X positions to place our text values
        
        text(x_offsets, total_emissions,
             label = paste(round(total_emissions, digits = 2), 'M', sep=''),
             pos = 3,
             col = "steelblue")
        
        points(x_offsets, total_emissions, pch=15)
        lines(x_offsets, total_emissions, lty=5)
        
        title('Baltimore PM2.5 Emissions By Year')
    })
}

plot2scatter <- function () {
    
    balt_pm25 <- pm25 %>%
        filter(fips == 24510) %>%
        group_by(year) %>%
        summarize(total_emissions = sum(Emissions) / 1000)
    
    par(mar=c(3,6,3,1))
    
    with(balt_pm25, {
        
        # The return value from barplot is the x positions of the middle of each bar
        
        plot(year, total_emissions, pch=19,
             xlim=c(1998,2009),
             ylim=c(0,4),
             ylab='Total PM2.5 Emissions\n(x 1000 tons)')
        
        lines(year, total_emissions)
        
        abline(lm(total_emissions ~ year), lty=5, col='red')
        
        # So we can use the X positions to place our text values
        
        text(year, total_emissions,
             label = paste(round(total_emissions, digits = 2), 'M', sep=''),
             pos = 3,
             col = "steelblue")
        
        title('Baltimore City PM2.5 Emissions By Year')
    })
}

png(filename='plot2.png', width=480, height=480)
plot2scatter()
graphics.off()
