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


#second graph
# with help from discussion forum credit to Thomas Tegtmeyer
png("D:/cursuri/exploratory da/project 1/plot2.png", width=480, height=480, res=80)
plot(exp$DateTime, exp$Global_active_power, type="l",ylab="Global Active Power (killowats)",xlab="")
dev.off()