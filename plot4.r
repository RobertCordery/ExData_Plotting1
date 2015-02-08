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

## Construct plot 4 as a png file
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
with(EPCROI, {
    plot(EPCROI[,"DateTime"],EPCROI[,"Global_active_power"], 
         type = "l",xlab = "", ylab = "Global Active Power")
    
    plot(EPCROI[,"DateTime"],EPCROI[,"Voltage"], 
         type = "l",xlab = "datetime", ylab = "Voltage")
    
    
    plot(EPCROI[,"DateTime"],EPCROI[,7],type="l",lty = 1,col="black", 
         ylab = "Energy sub metering" ,xlab = "")
    matplot(EPCROI[,"DateTime"],EPCROI[,8:9],type="l",lty = 1, col=c("red","blue"), 
            ylab = "" ,xlab = "", add = TRUE)
    legend(x="topright",names(EPCROI[7:9]), lty=1, bty = "n",  col=c("black","red","blue"))
    
    plot(EPCROI[,"DateTime"],EPCROI[, "Global_reactive_power"],
         type = "l",xlab = "datetime", ylab =  "Global_reactive_power")
    
})
dev.off()
