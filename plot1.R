#Load libraries
library(readr)
library(dplyr)
library(chron)
library(lubridate)


#Load dataset from file
ds<- read.csv2(file="household_power_consumption.txt",header = TRUE, sep=";", na.strings=c("?"), stringsAsFactors = FALSE)

#Convert dates from character to Date
hhpc_total<- mutate(ds, Date = as.Date(ds$Date, format="%d/%m/%Y"))
#convert times from character to Times
hhpc_total[,"Time"]<- times(hhpc_total[,"Time"])

#Filter only required dates
hhpc<- filter(hhpc_total, hhpc_total$Date >= ymd("2007-02-01") & hhpc_total$Date <= ymd("2007-02-02"))

#Create PNG file in the current directory
png(filename="plot1.png", width = 480, height = 480 )

#Make Histogram plot
valid_values<- !is.na(hhpc$Global_active_power)
hist(as.numeric(hhpc[valid_values,]$Global_active_power), col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")

#Close file
dev.off()