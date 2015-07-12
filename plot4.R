##READING, CLEANING DATA

dataSet <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
wantedSet <- dataSet[which(dataSet$Date == "2/2/2007" | dataSet$Date == "1/2/2007"),]
wantedSet$Date <- as.Date(wantedSet$Date, "%d/%m/%Y")
wantedSet$Time <- paste(wantedSet$Date, wantedSet$Time)
wantedSet$Time <- strptime(wantedSet$Time, "%Y-%m-%d %H:%M:%S") 

##conversion to Numeric from Factor 
toNumeric <- function(x){ 
        for (i in 3:9){
                x[,i] = as.numeric(as.character(x[,i]))
        }
        return(x)
}
wantedSet <- toNumeric(wantedSet) 


##Plots
par(mfrow = c(2,2), mar = c(4,3,1,1), mgp = c(2,1,0))
fontScale = 0.7

#Plot 1
plot(wantedSet$Time,wantedSet$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)",cex.lab = fontScale, cex.axis = fontScale)

#Plot 2
plot(wantedSet$Time,wantedSet$Voltage, type = "l", xlab ="datetime", ylab = "Voltage",cex.lab = fontScale, cex.axis = fontScale)

#Plot 3
with(wantedSet, {
        plot(wantedSet$Time,wantedSet$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",cex.lab = fontScale, cex.axis = fontScale)
        lines(wantedSet$Time,wantedSet$Sub_metering_2,type="l", col = "red")
        lines(wantedSet$Time,wantedSet$Sub_metering_3,type="l", col = "blue")
        
})

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=c(1,1), col=c("black", "red", "blue"),cex = fontScale, bty = "n")

#Plot 4
plot(wantedSet$Time,wantedSet$Global_reactive_power, type = "l", xlab ="datetime", ylab = "Global_reactive_power", cex.lab = fontScale, cex.axis = fontScale)


dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()