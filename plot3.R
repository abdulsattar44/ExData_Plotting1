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

## Plot 3
with(df, {
  plot(FullDate, Sub_metering_1, type =  "l",
       ylab="Global Active Power (kilowatts)")
  lines(FullDate, Sub_metering_2, col = "red")
  lines(FullDate, Sub_metering_3, col = "blue")
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col = c("black", "red", "blue"), lty = 1)
  
})

## Export the file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()