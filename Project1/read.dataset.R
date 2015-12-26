#
# Read in the dataset
#

library(data.table)
library(dplyr)

hpc <- fread('household_power_consumption.txt', data.table=FALSE, na.strings='?') %>%
    filter(Date == '1/2/2007' | Date == '2/2/2007')

hpc$datetime = strptime(paste(hpc$Date, hpc$Time), '%d/%m/%Y %H:%M:%S')

