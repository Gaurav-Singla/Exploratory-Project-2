# import libraries
library(ggplot2)
library(dplyr)
library(plyr)
library(data.table)

# import data tables
NEI = readRDS("Source_Classification_Code.rds")
SCC = readRDS("summarySCC_PM25.rds")

# subset SCC dataset to filter Baltimore city data
baltimore = subset(SCC, fips == 24510)

# aggregate data over type and year
baltimore3 <- ddply(baltimore, .(type, year), summarize, Emissions = sum(Emissions))
baltimore$type = as.factor(baltimore$type)


png("plot3.png", width = 480, height = 480)
qplot(year, Emissions, data = baltimore3, group = type, 
      color = type, geom = c("point", "line"), ylab = expression("Total Emissions of PM"[2.5]), 
      xlab = "Year", main = "Total Emissions in U.S. by Type of Pollutant")
dev.off()
