# import libraries
library(ggplot2)
library(dplyr)
library(plyr)
library(data.table)

# import data tables
NEI = readRDS("Source_Classification_Code.rds")
SCC = readRDS("summarySCC_PM25.rds")

# select required columns and aggregate data 
SCC1 = SCC %>% select(year, Emissions)
SCC2 = aggregate(Emissions ~ year, SCC1, sum)

# plot1 - Total emissions have decreased as evident from the plot
png("plot1.png", width = 480, height = 480)
plot(SCC2, type = "b", pch = 25, col = "blue", ylab = "Emissions", xlab = "Year", main = "Annual Emissions")
dev.off()