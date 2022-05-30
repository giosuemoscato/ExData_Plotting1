## download and unzip file in your wd
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists("household_power_consumption.txt")) {
        download.file(fileUrl, destfile = "household_power_consumption.zip", method = "curl")
        unzip("household_power_consumption.zip")
}

##construction of the dataset
power <- read.table("household_power_consumption.txt", sep=";", header = TRUE)
power_subset <- power[power$Date %in% c("1/2/2007","2/2/2007"),]

## creation of the column "DateTime" and removing "Date" and "Time" columns
DateTime <-strptime(paste(power_subset$Date, power_subset$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
power_subset <- power_subset[,-(1:2)]
power_subset <- cbind(DateTime, power_subset)

## converting the class of the columns with values from "character" to "numeric"
i <- 1
if (i <=8) {
        i <- i+1
        power_subset[,i] <- as.numeric(power_subset[,i])
}

##construction of the plot
png(filename = "plot3.png", width=480, height = 480, units="px" )
plot(power_subset$DateTime, power_subset$Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering")
lines(power_subset$DateTime, power_subset$Sub_metering_1, col="black")
lines(power_subset$DateTime, power_subset$Sub_metering_2, col="red")
lines(power_subset$DateTime, power_subset$Sub_metering_3, col="blue")
legend("topright", legend=names(power_subset[6:8]), col=c("black", "red", "blue"), lty=1, lwd=1)
dev.off()