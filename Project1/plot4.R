#
# Make an overlayed line plot of the Submetering
#

source('fetch.dataset.R')
source('read.dataset.R')

png(filename='plot4.png', width=480, height=480)

# mfcol goes down columns
par('mfcol' = c(2, 2))

# First plot (topleft)
with(hpc, plot(datetime, Global_active_power, type='l',
               ylab='Global Active Power', xlab=''))

# Second plot (bottomleft)
with(hpc, plot(datetime, Sub_metering_1, type='l',
               xlab='', ylab='Energy sub metering'))
with(hpc, points(datetime, Sub_metering_2, type='l', col='red'))
with(hpc, points(datetime, Sub_metering_3, type='l', col='blue'))

legend('topright',
       c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       lty=c(1,1,1),
       col=c('black', 'red', 'blue')
)

# Third plot (topright)
with(hpc, plot(datetime, Voltage, type='l'))

# Fourth plot (bottomright)
with(hpc, plot(datetime, Global_reactive_power, type='l'))

dev.off()

