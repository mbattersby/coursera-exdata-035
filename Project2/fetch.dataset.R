#
# Fetch the project dataset
#

suppressPackageStartupMessages(library(dplyr))
library(readr)

(function () {
    
    zipURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
    zipFile <- basename(URLdecode(zipURL))
    
    if (!file.exists(zipFile)) {
        cat('Downloading', zipFile)
        download.file(zipURL, zipFile)
    }
    
    if (!all(sapply(unzip(zipFile, list=TRUE)$Name, file.exists))) {
        cat('Unzipping', zipFile)
        unzip(zipFile)
    }
    
    SCC <- readRDS('Source_Classification_Code.rds')
    summarySCC <- readRDS('summarySCC_PM25.rds')
    
    pm25 <<- left_join(summarySCC, SCC, by = 'SCC')
    
})()