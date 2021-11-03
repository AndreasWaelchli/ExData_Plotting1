# load the dplyr package so that we can use the %>% operator
library(dplyr)

# load the data from disk using the read.csv2 function, because it has
# appropriate default values for sep=";" and header=TRUE
# also specify the "?" as missing values
myData <- read.csv2("household_power_consumption.txt", na.strings = "?")

# make the necessary data manipulation:
# - combine Time and Date to create a DateTime variable using strptime()
# - convert the Date column into Date class using as.Date()
# - convert the Global_active_power column into numeric class using as.numeric()
# - convert the Sub_metering_i columns into numeric class using as.numeric()

myData <- myData %>%
    mutate(
        DateTime = strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"),
        Date = as.Date(Date, format="%d/%m/%Y"),
        Global_active_power = as.numeric(Global_active_power),
        Sub_metering_1 = as.numeric(Sub_metering_1), 
        Sub_metering_2 = as.numeric(Sub_metering_2), 
        Sub_metering_3 = as.numeric(Sub_metering_3), 
        ) %>%
    filter(Date >= as.Date("2007-02-01"), Date <= as.Date("2007-02-02"))

# open/starts the graphics device for PNG (portable network graphics) and
# provide appropriate filename
png(filename = "plot3.png")

# create the plot with the y-axis label, but do not show data
plot(myData$DateTime, myData$Sub_metering_1, type = "n", 
     xlab = "", ylab = "Energy sub metering")
# now add the line charts
lines(myData$DateTime, myData$Sub_metering_1, col = "black")
lines(myData$DateTime, myData$Sub_metering_2, col = "red")
lines(myData$DateTime, myData$Sub_metering_3, col = "blue")
# finally add the legend by specifying position, legend, linetype and colours
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = "solid", col = c("black", "red", "blue"))

# VERY IMPORTANT: stop/close the graphics device using dev.off()
dev.off()

