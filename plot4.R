## Script to produce plot4.png from downloading the dataset to create a png file.
## Load library
library(tidyverse)
library(lubridate)

# Download, unzip and load the dataset
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "Data.zip")
unzip("Data.zip")

tbl <- read_delim("household_power_consumption.txt", delim = ";", na = "?")

# Filter date range in 1st and 2nd February of 2007
tbl.filter <- tbl %>% filter(Date == "1/2/2007" | Date == "2/2/2007")

# Convert date and time format to date and datetime format
tbl.filter$Time <- with(tbl.filter, as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M"))
tbl.filter$Date <- dmy(tbl.filter$Date)

# Plot and save the chart in png format with specific pixel size
png("plot4.png", width = 480, height = 480)
## grid plot
par(mfrow=c(2,2))

## top left plot
with(tbl.filter, plot(Time, Global_active_power, xlab = "", ylab = "Global Active Power", type="n"))
with(tbl.filter, lines(Time, Global_active_power))

## Top right plot
with(tbl.filter, plot(Time, Voltage, xlab = "datetime", ylab="Voltage", type="n"))
with(tbl.filter, lines(Time, Voltage))

## Bot left plot
with(tbl.filter, plot(Time, Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering"))
with(tbl.filter, lines(Time, Sub_metering_1))
with(tbl.filter, lines(Time, Sub_metering_2, col="red"))
with(tbl.filter, lines(Time, Sub_metering_3, col="blue"))
legend("topright", lty = c(1,1,1), col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

## Bot right plot
with(tbl.filter, plot(Time, Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", pch="."))
with(tbl.filter, lines(Time, Global_reactive_power))

dev.off()