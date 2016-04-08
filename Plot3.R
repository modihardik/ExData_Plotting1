# Exploratory Analysis Week 1 project
# Project is to reproduce plots provided


# Data from UCI machine learning repository
# "Individual household electric power consumption Data Set" 

# load libraries
library(dplyr)
library(data.table)
library(lubridate)

# read data, assume that this file is in current directory
pwr = fread("household_power_consumption.txt",na.strings = "?", stringsAsFactors = F)

# subsets data for required dates
february = filter(pwr, grep("^[1,2]/2/2007", Date))


# convert sub metering and voltage columns to numeric
february$Global_active_power = as.numeric(as.character(february$Global_active_power))
february$Sub_metering_1 = as.numeric(as.character(february$Sub_metering_1))
february$Sub_metering_2 = as.numeric(as.character(february$Sub_metering_2))
february$Sub_metering_3 = as.numeric(as.character(february$Sub_metering_3))
february$Voltage = as.numeric(as.character(february$Voltage))

# combining date and time so it can proper x-axis limit and label
february$TimeStamp = paste(february$Date,february$Time)

## Plot 3 date/tive vs Energy submeetering
# use the points generic function to overlay different sub metering
png('Plot3.png', width = 480, height = 480) 
plot(dmy_hms(february$TimeStamp), february$Sub_metering_1,type='n',
     xlab = "", 
     ylab = "Energy sub metering")
points(dmy_hms(february$TimeStamp), february$Sub_metering_1, 
       type = "l", 
       col = 'black')

points(dmy_hms(february$TimeStamp), february$Sub_metering_2, 
       type = "l", 
       xlab = "", 
       ylab = "Energy sub metering",
       col = 'red')
points(dmy_hms(february$TimeStamp), february$Sub_metering_3, 
       type = "l", 
       xlab = "", 
       ylab = "Energy sub metering",
       col = 'blue')
legend("topright", lty = 1, col=c('black','red','blue'), legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))

dev.off()



