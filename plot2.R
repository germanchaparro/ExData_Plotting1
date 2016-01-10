## use library dplyr for cleaning data purpouses 
library(dplyr)
library(lubridate)

# Parameters for reading and ploting the data
fileName <- "household_power_consumption.txt"
initDate <- "2007-02-01"
endDate <- "2007-02-02"
outputFileName <- "plot2.png"

## read the file into the table
print("Program started...")
print(paste("Reading file:", fileName, sep = " "))
if(!file.exists(fileName))
{
  print(paste("Input file", fileName, "does not exist in working directory: ", getwd(), sep = " "))
  print("Please check...")
  stop()
}

householdPC_DF <- read.table( file = fileName, sep = ";", 
                              header = TRUE, na.strings = c("?")
                            )

## filter rows occording to init and end dates 
print(paste("Filtering data with dates between", initDate, "and", endDate, sep = " "))
householdPC_DF <- filter( householdPC_DF, dmy(Date) == ymd(initDate) | dmy(Date) == ymd(endDate) )


# plot the data
print("Plotting data...")
png(filename = outputFileName, width = 480, height = 480)
plot( dmy_hms ( paste ( householdPC_DF$Date, householdPC_DF$Time, sep = " " ) ), 
      householdPC_DF$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines( dmy_hms(paste(householdPC_DF$Date, householdPC_DF$Time, sep = " ") ), 
       householdPC_DF$Global_active_power)

# send the plot to the png device
print("Sending the plot to png device")
dev.off()

print(paste("Program finished, please check the file", outputFileName, sep = " "))