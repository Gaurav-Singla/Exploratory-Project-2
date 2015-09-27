# import libraries
library(ggplot2)
library(dplyr)
library(plyr)
library(data.table)

# import data tables
NEIdata = readRDS("Source_Classification_Code.rds")
SCCdata = readRDS("summarySCC_PM25.rds")

NEIdata = as.data.table(NEIdata)
SCCdata = as.data.table(SCCdata)

#filtering out a vector of SCC corresponding to Mobile Vehicles
motor1 = NEIdata[grep("[Mm]obile|[Vv]ehicles", EI.Sector), SCC]

#Summation of emissions from Mobile Vehicles
motor2 = SCCdata[SCC %in% motor1, sum(Emissions), by = c("year", "fips")][fips == "24510"]

setnames(motor2, c("year", "fips", "Emissions"))

#plot5
png("plot5.png", width = 480, height = 480)
g = ggplot(motor2, aes(year, Emissions))
g + geom_point(color = "black") + geom_line(color = "red") + labs(x = "Year") + 
  labs(y = expression("Total Emissions of PM"[2.5])) + 
  labs(title = "Total Emissions from Motor Vehicle Sources in Baltimore City")
dev.off()