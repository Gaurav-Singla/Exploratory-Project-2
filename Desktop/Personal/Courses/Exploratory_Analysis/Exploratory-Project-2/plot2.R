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

# select required columns and aggregate data 
baltimore1 = baltimore %>% select(year, Emissions)
baltimore2 = aggregate(Emissions ~ year, baltimore1, sum)

# plot2 - Total Baltimore emissions have decreased as evident from the plot
png("plot2.png", width = 480, height = 480)
plot(baltimore2, type = "b", pch = 25, col = "blue", ylab = "Emissions", xlab = "Year", main = "Baltimore Emissions")
dev.off()