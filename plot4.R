# This downloads and reads the data, if necessary.
if(!exists("power") || !is(power,"data.frame")) {
    if(!file.exists("household_power_consumption.txt")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "data.zip")
        unzip("data.zip")
    }
    print("Reading table")
    power<-read.table("household_power_consumption.txt", 
                      sep=";", header=TRUE, na.strings="?",
                      colClasses=c("character", "character", rep("numeric",7)))
    power<-power[power$Date=="1/2/2007"| power$Date=="2/2/2007" ,]
    power$datetime=as.POSIXct(paste(power$Date, power$Time), 
                              format="%d/%m/%Y %H:%M:%S")    
}


png("plot4.png")
par(mfcol=c(2,2))
# This is plot2, with a shortened y label
with(power, plot(Global_active_power ~ datetime, type="l", 
                 ylab="Global Active Power", xlab=""))
# This is plot3, without the box around the legend
with(power, {plot(Sub_metering_1 ~ datetime, 
                  type="l",  ylab="Energy sub metering", 
                  xlab="")
             lines(Sub_metering_2~datetime, type="l", col="red")
             lines(Sub_metering_3~datetime, type="l", col="blue")
})
legend("topright", legend=names(power[7:9]), 
       lwd=1,col=c("black","red","blue"), bty="n")
# Voltage by datetime
with(power, plot(Voltage~datetime, type="l"))
#Global reactive power by datetime
with(power, plot(Global_reactive_power~datetime, type="l"))

dev.off()



