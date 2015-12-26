#
# Fetch the project dataset
#

zipURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
zipFile <- basename(URLdecode(zipURL))

if (!file.exists(zipFile)) {
    cat('Downloading', zipFile)
    download.file(zipURL, zipFile)
}

if (!all(sapply(unzip(zipFile, list=TRUE)$Name, file.exists))) {
    cat('Unzipping', zipFile)
    unzip(zipFile)
}
