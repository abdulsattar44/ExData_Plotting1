#download and unzip file
library(lubridate)
library(dplyr)
library(data.table)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!dir.exists("~/ExData_Plotting1"))
{dir.create("~/ExData_Plotting1")}
setwd("~/ExData_Plotting1")
download.file(url, destfile = "power.zip")
unzip("power.zip", junkpaths=TRUE)

#read data
filename <- "household_power_consumption.txt"
tmp <- fread(filename, na.strings = "?")

tmp$Date <- dmy(tmp$Date)

df <- filter(tmp, (tmp$Date == "2007-02-01" | tmp$Date == "2007-02-02"))
df$Time <- as.ITime(df$Time)
df <- mutate(df, "FullDate" = as.POSIXct(paste(df$Date, df$Time), tz="UTC"))

## Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(df, {
  plot(FullDate, Global_active_power, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  
  plot(FullDate, Voltage, type = "l",
       ylab = "Voltage (volt)", xlab = "datetime")
  
  plot(FullDate, Sub_metering_1, type =  "l",
       ylab="Global Active Power (kilowatts)")
  lines(FullDate, Sub_metering_2, col = "red")
  lines(FullDate, Sub_metering_3, col = "blue")
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col = c("black", "red", "blue"), lty = 1)
  
  plot(FullDate, Global_reactive_power, type = "l",
       ylab = "Global Rective Power (kilowatts)",xlab = "datetime")
})

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()