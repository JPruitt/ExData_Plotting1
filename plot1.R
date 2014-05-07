## Read in data
d<-read.table("household_power_consumption.txt", 
              sep=";", 
              skip = 1,
              col.names=c("Date", "Time", "Global_active_power", "Global_reactive_power",
                          "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
                          "Sub_metering_3"),
              colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", 
                           "numeric", "numeric", "numeric"),
              na.strings = "?",
              fill=F,
              strip.white=T)

## Convert Date column to date class
d$Date<-as.Date(d$Date, "%d/%m/%Y")

## Subset the data to the two days of interest
subD<-subset(d, d$Date == "2007-02-01" | d$Date == "2007-02-02")

## Open png device
png(file = "plot1.png", width = 480, height = 480, units = "px") 

## Create plot and send to png file 
## Plot 1
hist(as.numeric(subD$Global_active_power), col = "red", main = "Global Active Power", 
     xlab="Global Active Power (kilowatts)")

## Close the png device
dev.off() 
