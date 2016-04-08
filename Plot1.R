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

## Plot 1 histogram of Global active power
png('Plot1.png', width = 480, height = 480)
hist(february$Global_active_power,
     col = 'red', 
     xlab = "Global Active Power (Kilowatts)",
     main = "Global Active Power"
    )
dev.off()



