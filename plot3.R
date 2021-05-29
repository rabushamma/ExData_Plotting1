setwd("Desktop/Programming/Coursera/Data Science- R Specialization/Explotatory Data Analysis/Week 1 Project/") 

data <- read.table("household_power_consumption.txt",skip=1,sep=";", na.strings = "?")#read data as data table

names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3") #rename columns

data_subsetted <- subset(data, data$Date == "1/2/2007" | data$Date == "2/2/2007")

data_subsetted$Date <- as.Date(data_subsetted$Date, format = "%d/%m/%Y")
data_subsetted$Time <- as.POSIXlt(data_subsetted$Time, format = "%H:%M:%S")

str(data_subsetted) #confirm removal of rows via subset() and conversion of Date/Time class via as.Date() and as.POSIXlt(). See new format of POSIXlt

#format new Date/POSIXlt classes for each of the two days
data_subsetted[1:1440, 2] <- format(data_subsetted[1:1440,2], "2007-02-01 %H:%M:%S")
data_subsetted[1440:2880, 2] <- format(data_subsetted[1440:2880, 2], "2007-02-02 %H:%M:%S")

dev.copy(png, filename = "plot3.png") #open file device
with(data_subsetted, plot(Time, Sub_metering_1, type = "l", xaxt = "n", xlab = "", ylab = "Energy sub metering")) #plot with first line 
lines(data_subsetted$Time, data_subsetted$Sub_metering_2, type = "l", col = "red") #add second line
with(data_subsetted, lines(Time, Sub_metering_3, type = "l", col = "blue")) #add third line
sum_time <- summary(data_subsetted$Time) #make for x-axis labels 
axis(side = 1, at = c(sum_time[1], sum_time[4], sum_time[6]), labels = c("Thu", "Fri", "Sat")) #label x-axis according to day of week
legend("topright", lty = 1, legend = names(data_subsetted)[7:9], col = c("black", "red", "blue")) #add legend specifying line type and color
dev.off() #close file device


