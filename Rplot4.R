## Doanload file from the link

if(!file.exists('data.zip')){
  url<-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  
  download.file(url,destfile = "data.zip")
}

## extrxt the compressed file

unzip("data.zip")

## Reading data

data<-read.table("household_power_consumption.txt",header = TRUE, sep= ";")

names(data)

## the result is ([1] "Date"                  "Time"                  "Global_active_power"   "Global_reactive_power" "Voltage"              
## [6] "Global_intensity"      "Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3")

lapply(data, class)

## Reviewing first five date values

data$Date[1:5]
data$Time[1:5]

## Formua of the date and time

data$DateTime<-paste(data$Date, data$Time)
data$DateTime<-strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")

data$Date[1:5]

## Reading specific data (from 2007-02-01 to 2007-02-02)

start<-which(data$DateTime==strptime("2007-02-01", "%Y-%m-%d"))
end<-which(data$DateTime==strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S"))
data2<-data[start:end,]

## chart 4

## split the screen to 4 parts 2:2
par(mfcol=c(2,2))

## Plot 1
plot(data2$DateTime, as.numeric(as.character(data2$Global_active_power)),type='l',ylab="Global Active Power", xlab="")

## Plot 2
plot(data2$DateTime, as.numeric(as.character(data2$Sub_metering_1)),type='l', 
     ylab ="Energy sub metering", xlab="")
lines(data2$DateTime, as.numeric(as.character(data2$Sub_metering_2)),type='l', col='red')
lines(data2$DateTime, data2$Sub_metering_3,type='l', col="blue")
legend("topright", c("SM1","SM2","SM3"),  fill=c(1:3),
       lty=c(1,1,1)
       ,col=c("black","red","blue"),  cex = 0.25)

## Plot 3
plot(data2$DateTime, as.numeric(as.character(data2$Voltage)),type='l', 
     ylab="Voltage",xlab="datetime" )

## Plot 4
plot(data2$DateTime, as.numeric(as.character(data2$Global_reactive_power)),type='l', 
     ylab="Global_reactive_power",xlab="datetime" )

