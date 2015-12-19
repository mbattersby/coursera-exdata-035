#
# Fetch the project dataset
#

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
    
})()