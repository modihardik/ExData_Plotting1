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

## Plot 4
# Need to plot four plotes
# Two plots in first and two in second row.
# All four plots are aganist date/time and Four plots are 
# 1) Global Active Power (same as plot 2)
# 2) Voltage
# 3) Energy sub metering (same as plot 3)
# 4) Global reactive power
png('Plot4.png', width = 480, height = 480) 

par(mfrow = c(2,2))
# 1) Global Active Power
plot(dmy_hms(february$TimeStamp), february$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power(kilowatts)"
)
# 2)
plot(dmy_hms(february$TimeStamp), february$Voltage, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Voltage"
)

# 3)
# Energy submeetering
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

# 4)
plot(dmy_hms(february$TimeStamp), february$Global_reactive_power, 
     type = "l", 
     xlab = "Global_reactive_power", 
     ylab = "Voltage"
)

dev.off()



