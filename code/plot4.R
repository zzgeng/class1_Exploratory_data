library(dplyr)

data <- read.delim("/Users/gengzhilong/Desktop/household_power_consumption.txt", sep = ";")
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data_subset <- as.data.frame(data[data$Date == "2007-02-01"|data$Date == "2007-02-02",  ])

data_subset$Date_Time <- paste(data_subset$Date, data_subset$Time, sep = " ")
data_subset$Date_Time <- as.POSIXct(strptime(data_subset$Date_Time, format = "%Y-%m-%d %H:%M:%S"))


data_subset$Global_active_power <- as.numeric(data_subset$Global_active_power)
data_subset <- mutate(data_subset, GAP_killo = (Global_active_power / 1000))

png("/Users/gengzhilong/Desktop/plot4.png")

par(mfrow = c(2,2))

plot(y = data_subset$GAP_killo, x = data_subset$Date_Time, type = "l", xlab = "", ylab = "Global Active Power")

plot(x = data_subset$Date_Time, y = data_subset$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(x = data_subset$Date_Time, y = data_subset$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(data_subset$Date_Time, data_subset$Sub_metering_2, col = "red")
lines(data_subset$Date_Time, data_subset$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = c(2,2,2))

plot(y = data_subset$Global_reactive_power, x = data_subset$Date_Time, type = "l", xlab = "dateetime", ylab = "Global_reactive_power")

dev.off()
