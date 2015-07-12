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

##plot 1
hist(wantedSet$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, width= 480, height= 480, file = "plot1.png")
dev.off()
 