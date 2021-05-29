setwd("Desktop/Programming/Coursera/Data Science- R Specialization/Explotatory Data Analysis/Week 1 Project/") 

data <- read.table("household_power_consumption.txt",skip=1,sep=";", na.strings = "?")#read data as data table

names(data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3") #rename columns

data_subsetted <- subset(data,data$Date=="1/2/2007" | data$Date =="2/2/2007") #subset data to include rows with relative dates only

data_subsetted$Date <- as.Date(data_subsetted$Date, format="%d/%m/%Y") #make "Date" class  Date
data_subsetted$Time <- strptime(data_subsetted$Time, format="%H:%M:%S") #make "Time" class POSIXlt

str(data_subsetted) #confirm removal of rows and conversion of Date/Time class. See new format of POSIXlt

#format new Date/POSIXlt classes for each of the two days
data_subsetted[1:1440, 2] <- format(data_subsetted[1:1440,2],"2007-02-01 %H:%M:%S") 
data_subsetted[1441:2880,2] <- format(data_subsetted[1441:2880,2],"2007-02-02 %H:%M:%S")


dev.copy(png, filename="plot2.png") #open file device to copy plot to (default is 480x480 pizels )
with(data_subsetted, plot(Time, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xaxt = "n", xlab = "")) #basic plotting function with Time on x axis and global active power on y axis
sum_time<- summary(data_subsetted$Time) #Make sum_time vector for labeling x-axis
axis(side = 1, at = c(sum_time[1], sum_time[4], sum_time[6]), labels = c("Thu", "Fri", "Sat")) #add anotation with labels
dev.off() #close file device 
