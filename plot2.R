## Script to produce plot2.png from downloading the dataset to create a png file.
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
png("plot2.png", width = 480, height = 480)
with(tbl.filter, plot(Time, Global_active_power, type="n", xlab = "", ylab = "Global Active Power (kilowatts)"))
with(tbl.filter, lines(Time, Global_active_power))
dev.off()