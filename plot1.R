# plot1.R - This script creates a histogram of the Global Active Power variable 

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

# Create a .png file in the working directory (default width = 480, height = 480)
png(file = "plot1.png")

# Plot a histogram of Global Active Power
hist(dataFeb$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# Close the device
dev.off()

