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
png("plot3.png")
plot(data$DateTime, data$Sub_metering_1, type='l', xlab='', ylab='Global Active Power (kilowatts)')
lines(data$DateTime ,data$Sub_metering_2 ,col="red")
lines(data$DateTime ,data$Sub_metering_3 ,col="blue")
legend("topright", pch=1, col=c('black', 'red', 'blue'), legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd=3, lty=1)
dev.off()
