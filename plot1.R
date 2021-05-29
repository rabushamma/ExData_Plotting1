setwd("Desktop/Programming/Coursera/Data Science- R Specialization/Explotatory Data Analysis/Week 1 Project/") 

file.size("household_power_consumption.txt") #file is sufficient size to read

#load relevant packages
library("data.table")
library("lubridate")
library("dplyr")

data <- fread("household_power_consumption.txt", na.strings = "?" ) #read file into RStudio and make ? as NAs

str(data)  #look at data dimensions and classes of columns 
data <- data[, Date:=as.Date(Date, format = "%d/%m/%Y")] #convert Date column to data class

data_subsetted <- filter(data, Date == "2007-02-01" | Date == "2007-02-02" ) #subset data to include only relevant dates
str(data_subsetted) #confirm removal of rows and conversion of Date class

png("plot1.png", width = 480, height = 480 )
hist(data_subsetted$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power" )
dev.off()

