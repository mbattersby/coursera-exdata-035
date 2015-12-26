#
# Make a red-colored histogram plot of the Global Active Power
#

source('fetch.dataset.R')
source('read.dataset.R')

png(filename='plot1.png', width=480, height=480)

hist(hpc$Global_active_power, 
     col='red',
     main='Global Active Power',
     xlab='Global Active Power (kilowatts)')

dev.off()
