# plot2.R - This script creates a time series graph of the Global Active Power variable 

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
png(file = "plot2.png")

# Plot a time series graph of Global Active Power
# Use xaxt = "n" to suppress x axis
# Use format = "%a" to plot bottom axis with the abbreviated weekday name
plot(dataFeb$DateTime, dataFeb$Global_active_power, type = "l", xaxt = "n", xlab ="", ylab = "Global Active Power (kilowatts)")
axis.POSIXct(1, dataFeb$DateTime, format = "%a")

# Close the device
dev.off()
