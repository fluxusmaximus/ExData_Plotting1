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

##Plot 3
with(wantedSet, {
        plot(wantedSet$Time,wantedSet$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
        lines(wantedSet$Time,wantedSet$Sub_metering_2,type="l", col = "red")
        lines(wantedSet$Time,wantedSet$Sub_metering_3,type="l", col = "blue")
        
})

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=c(1,1), col=c("black", "red", "blue"))


dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()