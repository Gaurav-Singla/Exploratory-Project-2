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

#filtering out a vector of SCC corresponding to Coal
coal1 = NEIdata[grep("Coal", SCC.Level.Three), SCC]

#Summation of emissions from Coal Combustion
coal2 = SCCdata[SCC %in% coal1, sum(Emissions), by = "year"]

setnames(coal2, c("year", "Emissions"))

#plot4
png("plot4.png", width = 480, height = 480)
g = ggplot(coal2, aes(year, Emissions))
g + geom_point(color = "black") + geom_line(color = "blue") + labs(x = "Year") + 
  labs(y = expression("Total Emissions of PM"[2.5])) + labs(title = "Emissions from Coal Combustion for the US")
dev.off()