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
png("plot1.png")
hist(data$Global_active_power, col='red', xlab='Global Active Power (kilowatts)')
dev.off()
