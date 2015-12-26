# Have total emissions from PM2.5 decreased in the United States from 1999 to
# 2008? Using the base plotting system, make a plot showing the total PM2.5
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# fetch.dataset leaves a tidied pm25 in the global environment for us to work on.
source('fetch.dataset.R')

# Bar plot version. I like the bar plot but you can't include the abline (easily) because
# the X coords of the plot are not the X values of the data.

plot1bar <- function () {
    
    # Use dplyr to sum emissions per year.
    total_pm25 <- pm25 %>%
        group_by(year) %>%
        summarize(total_emissions = sum(Emissions) / 1e6)
    
    # Base graphics needs a bigger left margin to fit in our two-line ylab
    par(mar=c(3,6,3,1))
    
    # Wrapper the whole thing in with() to avoid having to use total_pm25$xxx everywhere.
    with(total_pm25, {
        # The return value from barplot is the x positions of the middle of each bar
        x_offsets <-barplot(total_emissions,
                            names=year,
                            col="wheat",
                            ylim=c(0,8),
                            ylab='U.S.A. Total PM2.5 Emissions\n(x 1e6 tons)')
        
        # So we can use the X positions to place our text values
        text(x_offsets, total_emissions,
             label = paste(round(total_emissions, digits = 2), 'M', sep=''),
             pos = 3,
             col = "steelblue")
        
        title('Total PM2.5 Emissions By Year')
    })
}

# Scatter plot version.
plot1scatter <- function () {
    
    # Use dplyr to sum emissions per year.
    total_pm25 <- pm25 %>%
        group_by(year) %>%
        summarize(total_emissions = sum(Emissions) / 1e6)
    
    # Base graphics needs a bigger left margin to fit in our two-line ylab
    par(mar=c(3,6,3,1))
    
    # Wrapper the whole thing in with() to avoid having to use total_pm25$xxx everywhere.
    with(total_pm25, {
        
        plot(year, total_emissions, pch=19,
             xlim=c(1998,2009),
             ylim=c(0,8),
             ylab='Total PM2.5 Emissions\n(x 1e6 tons)')
        
        lines(year, total_emissions)
        
        # Linear regression line in red.
        abline(lm(total_emissions ~ year), lty=5, col='red')
        
        text(year, total_emissions,
             label = paste(round(total_emissions, digits = 2), 'M', sep=''),
             pos = 3,
             col = "steelblue")
        
        title('U.S.A. Total PM2.5 Emissions By Year')
    })
}

png(filename='plot1.png', width=480, height=480)
plot1scatter()
graphics.off()