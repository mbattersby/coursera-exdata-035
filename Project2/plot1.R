# Have total emissions from PM2.5 decreased in the United States from 1999 to
# 2008? Using the base plotting system, make a plot showing the total PM2.5
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

source('fetch.dataset.R')

plot1 <- function () {

    total_pm25 <- pm25 %>% group_by(year) %>% summarize(total_emissions = sum(Emissions) / 1e6)

    par(mar=c(3,6,3,1))
    
    p <-barplot(total_pm25$total_emissions,
                names.arg=total_pm25$year,
                col="wheat",
                ylim=c(0,8),
                ylab='Total PM25 Emissions\n(x 1e6 tons)')
    
    text(p, total_pm25$total_emissions,
         label = paste(round(total_pm25$total_emissions, digits = 2), 'M', sep=''),
         pos = 3,
         col = "steelblue")
    
    title('Total PM2.5 Emissions By Year')
}

plot1()