## Convert Columns (1 - Date, 2 - ch, 3 - 9 numeric) and add Column datetime
data[,1]<- as.Date(data[,1], "%d/%m/%Y")
data$datetime <- paste(data[,1], data[,2])
data$datetime<-strptime(data$datetime, "%Y-%m-%d %H:%M:%S")

cols = c(3:9)
data[,cols] = apply(data[,cols], 2, function(x) as.numeric(as.character(x)))
## First entry in 2007-02-01 & last entry in 2007-02-02

start <- min(which(data$Date == "2007-02-01"))
end <- max(which(data$Date == "2007-02-02"))
subset <- data[start:end,]

# Set LC_Time to english 
Sys.setlocale("LC_TIME","C")

# Create Plots
png(file="Plot4.png", width=480, height=480)
par(mfrow=c(2,2))
plot(subset$datetime, subset$Global_active_power, 
     type ="l", xlab="", yaxt="n", ylab="Global Active Power")
axis(2, at= seq(0,6,by=2))
plot(subset$datetime, subset$Voltage, type="l", xlab="date", ylab="Voltage")
plot(subset$datetime, subset$Sub_metering_1, type="l"
     , col="black",xlab="", yaxt="n", ylab="Energy sub metering")
axis(2, at= seq(0,30,by=10))
lines(subset$datetime, subset$Sub_metering_2, type="l", col="red")
lines(subset$datetime, subset$Sub_metering_3, type="l", col="blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_1"), col=c("black", "red", "blue"), lwd=1)
plot(subset$datetime, subset$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()