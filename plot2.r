## Exploratory Data Analysis Course Project 1
# File plot1.r

## Get the data

datafile <- "household_power_consumption.txt" 
zipfile = "exdata_data_household_power_consumption.zip"
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists(datafile)){
    
    if(!file.exists(zipfile)){
        download.file(fileUrl, destfile = zipfile)
    }
    unzip(zipfile)
}

EPC<-read.table("household_power_consumption.txt",  sep = ";",
                colClasses = EPCclasses,
                na.string ="?", header = TRUE)

measureDate <- as.Date(EPC[,"Date"], format="%d/%m/%Y", tz="America/Los_Angeles")

## Determine the rows of interest
startDate = "2007-02-01"
endDate = "2007-02-02"
useRows <- (measureDate >= startDate)&(measureDate <= endDate)

## Focus on the rows of interest
EPCROI <- EPC[useRows,]
EPCROI[,"DateTime"] <- as.POSIXct(paste(EPCROI[,"Date"], EPCROI[,"Time"]), 
                                  format="%d/%m/%Y %H:%M:%S", tz="America/Los_Angeles")

## Construct plot 2 as a png file
png(filename = "plot2.png", width = 480, height = 480)
plot(EPCROI[,"DateTime"],EPCROI[,"Global_active_power"], 
     type = "l",xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
