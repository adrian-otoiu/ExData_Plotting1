#importing data

exploratory <- read.table("D:/cursuri/exploratory da/project 1/household_power_consumption.txt",
                          header=TRUE,  sep=";" ,as.is=TRUE, na.strings="NA", dec=".", strip.white=TRUE)
str(exploratory)

#separate columns in data frame
# by ec0n0micus http://stackoverflow.com/questions/22772279/converting-multiple-columns-from-character-to-numeric-format-in-r
cols <- names(exploratory)
# character variables
cols.char <- c("Date","Time")
#numeric variables
cols.num <- cols[!cols %in% cols.char]

#format columns with data as numeric
DF.char <- exploratory[cols.char]
DF.num <- as.data.frame(lapply(exploratory[cols.num],as.numeric))
exploratory <- cbind(DF.char, DF.num)

str(exploratory)

#select 1& 2 february 2007 obs

exp1<-exploratory[grep("^1/2/2007$", exploratory$Date),  ]
exp2<-exploratory[grep("^2/2/2007$", exploratory$Date), ]
exp<- rbind(exp1,exp2)
str(exp)

#format date 
#credit http://www.stat.berkeley.edu/~s133/dates.html

#concatenate and format date and time
exp$Dt<- as.character(paste(exp$Date, exp$Time, sep = ":"))
exp$DateTime<- strptime(exp$Dt,format='%d/%m/%Y:%H:%M:%S')


#graph 4
#credits http://127.0.0.1:15993/library/graphics/html/legend.html

png("D:/cursuri/exploratory da/project 1/plot4.png", width=480, height=480, res=80)
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

plot(exp$DateTime, exp$Global_active_power, type="l",ylab="Global Active Power",xlab="")
plot(exp$DateTime, exp$Voltage, type="l",ylab="Voltage",xlab="datetime")
plot(exp$DateTime, exp$Sub_metering_1, type="n",ylab="Energy sub metering",xlab="")
lines(exp$DateTime, exp$Sub_metering_1, type="l") 
lines(exp$DateTime, exp$Sub_metering_2, type="l", col="red")
lines(exp$DateTime, exp$Sub_metering_3, type="l", col="blue")
legend("topright", bty="n", pch ="___", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(exp$DateTime, exp$Global_reactive_power, type="l",ylab="Global_reactive_power",xlab="datetime")

dev.off()


#Other credits http://www.cookbook-r.com/Graphs/Output_to_a_file/ QuickR
