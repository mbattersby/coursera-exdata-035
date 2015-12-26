#
# Make a line plot of the Global Active Power
#

source('fetch.dataset.R')
source('read.dataset.R')

png(filename='plot2.png', width=480, height=480)

with(hpc,
     plot(datetime, Global_active_power, type='l',
          ylab = 'Global Active Power (kilowatts)',
          xlab=''))

dev.off()

