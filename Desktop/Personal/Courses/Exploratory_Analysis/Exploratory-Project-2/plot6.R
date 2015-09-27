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

#filtering out Emission data corresponding to Baltimore county
baltimore4 = SCCdata[(SCCdata$fips=="24510"), ]
baltimore4 = aggregate(Emissions ~ year, data = baltimore4, FUN = sum)

#filtering out Emission data corresponding to Los Angeles county
losangeles = SCCdata[(SCCdata$fips=="06037"),]
losangeles = aggregate(Emissions ~ year, data = losangeles, FUN = sum)

baltimore4$County <- "Baltimore"
losangeles$County <- "Los Angeles"

emissiondata <- rbind(baltimore4, losangeles)

#plot6
png("plot6.png", width = 480, height = 480)
qplot(year, log(Emissions), data = emissiondata, group = County, 
      color = County, geom = c("point", "line"), ylab = expression("Total Emissions (in log scale) of PM"[2.5]), 
      xlab = "Year", main = "Motor vehicle emission in Baltimore and Los Angeles")
dev.off()