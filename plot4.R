#Load libraries
library(readr)
library(dplyr)
library(chron)
library(lubridate)

#Load dataset from file
ds<- read.csv2(file="household_power_consumption.txt",header = TRUE, sep=";", na.strings=c("?"), stringsAsFactors = FALSE)

#Create dataset with new field DateandTime
hhpc_total<- mutate(ds, DateandTime = as.POSIXct(paste(ds$Date, ds$Time),format="%d/%m/%Y %H:%M:%S"))

#Filter only required dates
hhpc<- filter(hhpc_total, hhpc_total$DateandTime >= ymd("2007-02-01") & hhpc_total$DateandTime < ymd("2007-02-03"))

#Create PNG file in the current directory
png(filename="plot4.png", width = 480, height = 480 )

#It will contain 4 graphics
par(mfrow=c(2,2))    # set the plotting area into a 2*2 array

#Make 1st plot
with(hhpc, plot(DateandTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")) 

#Make 2nd plot
with(hhpc, plot(DateandTime, Voltage, type="l", ylab="Voltage", xlab="datetime")) 

#Make 3rd plot
with(hhpc, plot(DateandTime, Sub_metering_1, type="l", col="black", ylab="Energy sub metering", xlab="")) 
lines(hhpc$DateandTime, hhpc$Sub_metering_2, type="l", col="red")
lines(hhpc$DateandTime, hhpc$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),lty=c(1,1), lwd=c(2.5,2.5),col=c("black", "red", "blue"))

#Make 4th plot
with(hhpc, plot(DateandTime, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")) 

#Close file
dev.off()