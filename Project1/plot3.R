#
# Make an overlayed line plot of the Submetering
#

source('fetch.dataset.R')
source('read.dataset.R')

png(filename='plot3.png', width=480, height=480)

with(hpc, plot(datetime, Sub_metering_1, type='l',
               xlab='', ylab='Energy sub metering'))
with(hpc, points(datetime, Sub_metering_2, type='l', col='red'))
with(hpc, points(datetime, Sub_metering_3, type='l', col='blue'))

legend('topright',
       c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       lty=c(1,1,1),
       col=c('black', 'red', 'blue')
       )

dev.off()

