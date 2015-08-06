# PROJECT 1: PLOT 3
# Jan Flowers, Coursera JHU Exploratory Data

# Examine how household energy usage varies over a 2-day period in February, 2007. 
# Your task is to reconstruct the following plots below, all of which were constructed using the base plotting system.
# First you will need to fork and clone the following GitHub repository: https://github.com/rdpeng/ExData_Plotting1
# For each plot you should
#     1.Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
#     2.Name each of the plot files as plot1.png, plot2.png, etc.
#     3.Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, 
#         i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data 
#         so that the plot can be fully reproduced. You must also include the code that creates the PNG file.
#     4.Add the PNG file and R code file to the top-level folder of your git repository (no need for separate sub-folders)


plot3 <- function(){
  
  require(sqldf)
  
  #read in the file with only data from the dates 2007-02-01 and 2007-02-02
  powerData <- read.csv.sql("household_power_consumption.txt", sql="select * from file where Date in ('1/2/2007', '2/2/2007')",header=TRUE, sep=";")
  closeAllConnections()
  
  #convert the data into a data frame, convert the date and time variables into classes
  dfPower <- as.data.frame(powerData)
  dfPower$Date <- as.Date(dfPower$Date, "%d/%m/%Y")
  dfPower$Time <- paste(dfPower$Date, dfPower$Time)
  dfPower$Time <- strptime(dfPower$Time, "%Y-%m-%d %H:%M:%S")
  
  ## output the plot Energy Sub Metering 1,2,3 over Time to PNG
  
  #open the png device, set options
  png("plot3.png", height=480, width=480, units = "px")
  
  #plot
  ylimits = range(c(dfPower$Sub_metering_1, dfPower$Sub_metering_2, dfPower$Sub_metering_3))
  plot(dfPower$Time, dfPower$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", ylim=ylimits)
  lines(dfPower$Time, dfPower$Sub_metering_2, col="red")
  lines(dfPower$Time, dfPower$Sub_metering_3, col="blue")
  legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lwd=c(2,2,2))
  
  #close the png device
  dev.off()
  
}