setwd("/Users/reemabushamma/Desktop/Programming/Coursera/Data Science- R Specialization/Explotatory Data Analysis/Week 1 Project/")

data <- read.table(file = "household_power_consumption.txt", skip = 1, sep = ";", na.strings = "?") #read data as data table

names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3") #rename columns

data_subsetted <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")

data_subsetted$Date <- as.Date(data_subsetted$Date, format = "%d/%m%/%Y")
data_subsetted$Time <- as.POSIXlt(data_subsetted$Time, format = "%H:%M:%S")

str(data_subsetted)

data_subsetted[1:1440, 2] <- format(data_subsetted[1:1440, 2], "2007-02-01 %H:%M:%S")
data_subsetted[1440:2880,2] <- format(data_subsetted[1440:2880, 2], "2007-02-02 %H:%M:%S")



dev.copy(png, filename = "plot4.png")

par(mfcol=c(2,2)) #make space for 4 plots in a 2x2 grid; fill them column-wise

#first plot (i.e. plot3.png)
with(data_subsetted, plot(Time, Global_active_power, type = "l", ylab = "Global Active Power", xaxt = "n", xlab = "")) #basic plotting function with Time on x axis and global active power on y axis
sum_time<- summary(data_subsetted$Time) #Make sum_time vector for labeling x-axis
axis(side = 1, at = c(sum_time[1], sum_time[4], sum_time[6]), labels = c("Thu", "Fri", "Sat")) #add anotation with labels

#second plot (i.e. plot3.png)
with(data_subsetted, plot(Time, Sub_metering_1, type = "l", xaxt = "n", xlab = "", ylab = "Energy sub metering")) #plot with first line 
lines(data_subsetted$Time, data_subsetted$Sub_metering_2, type = "l", col = "red") #add second line
with(data_subsetted, lines(Time, Sub_metering_3, type = "l", col = "blue")) #add third line
axis(side = 1, at = c(sum_time[1], sum_time[4], sum_time[6]), labels = c("Thu", "Fri", "Sat")) #label x-axis according to day of week
legend("topright", lty = 1, legend = names(data_subsetted)[7:9], col = c("black", "red", "blue"), bty = "n") #add legend specifying line type and color; argument bty = "n" removed boarder around legend

#third plot: 
with(data_subsetted, plot(Time, Voltage, type = "l", xaxt = "n", xlab = "" ))
axis(side= 1, at =c(sum_time[1], sum_time[4], sum_time[6]), labels = c("Thu", "Fri", "Sat"))
title(xlab = "datetime")

#fourth plot: 
with(data_subsetted, plot(Time, Global_reactive_power, type = "l", xaxt = "n", xlab = ""))
axis(side = 1, at = c(sum_time[1], sum_time[4], sum_time[6]), labels = c("Thu", "Fri", "Sat"))
title(xlab = "datetime")

dev.off()