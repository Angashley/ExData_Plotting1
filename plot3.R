# plot3.R - This script creates a time series graph of the Energy sub metering variable 

# Download the dataset 
# First check if the household_power_consumption.txt file exists
if (!file.exists("household_power_consumption.txt")) {
      temp <- tempfile()
      download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                    , destfile = temp)
      unzip(temp)
      unlink(temp)
}

# Load the data where dates are 2007-02-01 and 2007-02-02
lines <- readLines("household_power_consumption.txt")
subL <- grep("^[1,2]/2/2007", lines, value = TRUE)
dataFeb <- read.table(text = subL, header = TRUE
                      , col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power"
                                      , "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2"
                                      , "Sub_metering_3"), sep = ";")

# Combine the date and time into a datetime
dataFeb$DateTime <- strptime(paste(dataFeb$Date, dataFeb$Time), format = "%d/%m/%Y %H:%M:%S")

# Create a .png file in the working directory (default width = 480, height = 480)
png(file = "plot3.png")

# Plot a time series graph of Energy sub metering 1, 2 and 3
# Use xaxt = "n" to suppress x axis
# Use format = "%a" to plot bottom axis with the abbreviated weekday name
plot(dataFeb$DateTime, dataFeb$Sub_metering_1, type = "l", xaxt = "n", xlab ="", ylab = "Energy sub metering")
lines(dataFeb$DateTime, dataFeb$Sub_metering_2, col = "red")
lines(dataFeb$DateTime, dataFeb$Sub_metering_3, col = "blue")

axis.POSIXct(1, dataFeb$DateTime, format = "%a")

# Create legend in the topright corner
legend("topright", lty = c(1,1,1), col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Close the device
dev.off()
