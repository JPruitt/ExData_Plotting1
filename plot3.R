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

## Create date-time column and convert to date-time class
subD$Date<-as.character(subD$Date)
subD["dateTime"]<-paste(subD$Date, subD$Time)
subD$dateTime<-strptime(subD$dateTime, "%Y-%m-%d %H:%M:%S")
str(subD$dateTime)

## Open png device
png(file = "plot3.png", width = 480, height = 480, units = "px") 

## Create plot and send to png file 
## Plot 3
plot(subD$dateTime, subD$Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering")
lines(subD$dateTime, subD$Sub_metering_1, col = "black")
lines(subD$dateTime, subD$Sub_metering_2, col = "red")
lines(subD$dateTime, subD$Sub_metering_3, col = "blue")
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Close the png device
dev.off() 
