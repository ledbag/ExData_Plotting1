setwd("~/Especializacion Data Science/Carpeta Datos/Energy")
library(dplyr)

par(mfrow = c(1, 1))
par(mar=c(4,4,4,1))
arch<-"household_power_consumption.txt"
date1<-strptime("01/02/2007","%d/%m/%Y")
date2<-strptime("28/02/2007","%d/%m/%Y")
energy<-read.csv(arch,header=TRUE,sep=";",dec=".")
energy.feb<-filter(energy, strptime(Date,"%d/%m/%Y")>=date1 & strptime(Date,"%d/%m/%Y")<=date2)

transmute(energy.feb,Global_active_power=(as.numeric(Global_active_power))/1000)
transmute(energy.feb,Global_reactive_power=(as.numeric(Global_reactive_power))/1000)
transmute(energy.feb,Voltage=(as.numeric(Voltage))/1000)
transmute(energy.feb,Global_intensity=(as.numeric(Global_intensity))/1000)
transmute(energy.feb,Sub_metering_1=(as.numeric(Sub_metering_1))/1000)
transmute(energy.feb,Sub_metering_2=(as.numeric(Sub_metering_2))/1000)
transmute(energy.feb,Sub_metering_3=(as.numeric(Sub_metering_3))/1000)

energy.feb$Global_active_power<-as.numeric(energy.feb$Global_active_power)
date3<-strptime("03/02/2007","%d/%m/%Y")
energy.sem<-filter(energy.feb, strptime(Date,"%d/%m/%Y")>=date1 & strptime(Date,"%d/%m/%Y")<=date3)
energy.sem$new_time<-as.POSIXct(paste(energy.sem$Date,energy.sem$Time),format = "%d/%m/%Y %T")
##Third plot
with(energy.sem,{
  plot(new_time,Sub_metering_1,type="l",xlab="",ylab="Energy Submetering")
  lines(new_time,Sub_metering_2,col="blue")
  lines(new_time,Sub_metering_3,col="red")
  legend("topright", col = c("black", "red", "blue"), cex = 0.8, lty = 1,
         legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
})
dev.copy(png,file="plot3.png")
dev.off()

