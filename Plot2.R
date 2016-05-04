setwd("~/Especializacion Data Science/Carpeta Datos/Energy")
library(dplyr)

par(mfrow = c(1, 1))
par(mar=c(4,4,4,1))
arch<-"household_power_consumption.txt"
date1<-strptime("01/02/2007","%d/%m/%Y")
date2<-strptime("28/02/2007","%d/%m/%Y")
energy<-read.csv(arch,header=TRUE,sep=";",dec=".")
energy.feb<-filter(energy, strptime(Date,"%d/%m/%Y")>=date1 & strptime(Date,"%d/%m/%Y")<=date2)


energy.feb$Global_active_power<-as.numeric(energy.feb$Global_active_power)
date3<-strptime("03/02/2007","%d/%m/%Y")
energy.sem<-filter(energy.feb, strptime(Date,"%d/%m/%Y")>=date1 & strptime(Date,"%d/%m/%Y")<=date3)
energy.sem$new_time<-as.POSIXct(paste(energy.sem$Date,energy.sem$Time),format = "%d/%m/%Y %T")

##Second plot
with(energy.sem,plot(new_time,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))
dev.copy(png,file="plot2.png")
dev.off()

