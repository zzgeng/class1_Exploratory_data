library(dplyr)

data <- read.delim("/Users/gengzhilong/Desktop/household_power_consumption.txt", sep = ";")
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data_subset <- as.data.frame(data[data$Date == "2007-02-01"|data$Date == "2007-02-02",  ])

data_subset$Global_active_power <- as.numeric(data_subset$Global_active_power)
data_subset <- mutate(data_subset, GAP_killo = (Global_active_power / 1000))

png("/Users/gengzhilong/Desktop/plot2.png")

hist(data_subset$GAP_killo, main = "Global Active Power", xlab = "Glocal Active Power  (kilowatts)", col = "red")

dev.off()
