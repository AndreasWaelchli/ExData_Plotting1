# load the dplyr package so that we can use the %>% operator
library(dplyr)

# load the data from disk using the read.csv2 function, because it has
# appropriate default values for sep=";" and header=TRUE
# also specify the "?" as missing values
myData <- read.csv2("household_power_consumption.txt", na.strings = "?")

# make the necessary data manipulation:
# - convert the Date column into Date class using as.Date()
# - convert the Global_active_power column into numeric class using as.numeric()

myData <- myData %>%
    mutate(
        Date = as.Date(Date, format="%d/%m/%Y"),
        Global_active_power = as.numeric(Global_active_power),
        ) %>%
    filter(Date >= as.Date("2007-02-01"), Date <= as.Date("2007-02-02"))

# open/starts the graphics device for PNG (portable network graphics) and
# provide appropriate filename
png(filename = "plot1.png")

# create the histogram with colour, x-axis label and title
hist(myData$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)",
     main="Global Active Power")

# VERY IMPORTANT: stop/close the graphics device using dev.off()
dev.off()

