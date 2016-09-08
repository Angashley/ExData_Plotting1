# plot4.R - This script creates 4 plots in one overall graph 

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
dataFeb$datetime <- strptime(paste(dataFeb$Date, dataFeb$Time), format = "%d/%m/%Y %H:%M:%S")

# Create a .png file in the working directory (default width = 480, height = 480)
png(file = "plot4.png")

# Set up plotting of 4 plots in a 2x2 grid 
par(mfrow=c(2,2))

# Plot the 4 plots
plot(dataFeb$datetime, dataFeb$Global_active_power, type = "l", xaxt = "n", xlab ="", ylab = "Global Active Power (kilowatts)")
axis.POSIXct(1, dataFeb$datetime, format = "%a")

plot(dataFeb$datetime, dataFeb$Voltage, type = "l", xaxt = "n", xlab = "datetime", ylab = "Voltage")
axis.POSIXct(1, dataFeb$datetime, format = "%a")

plot(dataFeb$datetime, dataFeb$Sub_metering_1, type = "l", xaxt = "n", xlab ="", ylab = "Energy sub metering")
lines(dataFeb$datetime, dataFeb$Sub_metering_2, col = "red")
lines(dataFeb$datetime, dataFeb$Sub_metering_3, col = "blue")
axis.POSIXct(1, dataFeb$datetime, format = "%a")
legend("topright", lty = c(1,1,1), col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n")

plot(dataFeb$datetime, dataFeb$Global_reactive_power, type = "l", xaxt = "n", xlab = "datetime", ylab = "Global_reactive_power")
axis.POSIXct(1, dataFeb$datetime, format = "%a")

# Close the device
dev.off()
