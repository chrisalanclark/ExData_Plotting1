# This downloads and reads the data, if necessary.
if(!exists("power") || !is(power,"data.frame")) {
    if(!file.exists("household_power_consumption.txt")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "data.zip")
        unzip("data.zip")
    }
    print("Reading table")
    # read the full table
    power<-read.table("household_power_consumption.txt", 
                      sep=";", header=TRUE, na.strings="?",
                      colClasses=c("character", "character", rep("numeric",7)))
    # Filter for just the two days
    power<-power[power$Date=="1/2/2007"| power$Date=="2/2/2007" ,]
    # Create a datetime column
    power$datetime=as.POSIXct(paste(power$Date, power$Time), 
                              format="%d/%m/%Y %H:%M:%S")    
}

png("plot3.png")
# Transparent background, based on the figures provided in the Repo
par(bg=NA)
# Add the three line plots
with(power, {plot(Sub_metering_1 ~ datetime, 
                  type="l",  ylab="Energy sub metering", 
                  xlab="")
             lines(Sub_metering_2~datetime, type="l", col="red")
             lines(Sub_metering_3~datetime, type="l", col="blue")
})
# Add the legend
legend("topright", legend=names(power[7:9]), 
       lwd=1,col=c("black","red","blue"))

dev.off()



