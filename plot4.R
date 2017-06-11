# Download the file
destfile <- "household_power_consumption.txt"
if(!file.exists(destfile)){
  URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(URL, destfile = "downloaded.zip", method="curl")
  unzip('downloaded.zip')
}

# Read it into memory
data <- read.table(destfile, header = TRUE, sep = ";", na = "?", colClasses = c(rep("character", 2), rep("numeric", 7)))
data <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S") 

# Visualize the data
# summary(data)

# save the plot
png("plot4.png")
par(mfrow = c(2,2))
with (data, {
    plot(data$DateTime, data$Global_active_power, type='l', xlab='', ylab='Global Active Power (kilowatts)')
    plot(data$DateTime, data$Voltage, type='l', xlab='datetime', ylab='Voltage')
    plot(data$DateTime, data$Sub_metering_1, type='l', xlab='', ylab='Global Active Power (kilowatts)')
    lines(data$DateTime ,data$Sub_metering_2 ,col="red")
    lines(data$DateTime ,data$Sub_metering_3 ,col="blue")
    legend("topright", pch=1, col=c('black', 'red', 'blue'), legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd=3, lty=1)
    plot(data$DateTime, data$Global_reactive_power, type='l', xlab='datetime', ylab='Global_reactive_power')
})
dev.off()
