## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
##which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
## Which have seen increases in emissions from 1999-2008? 
## Use the ggplot2 plotting system to make a plot answer this question

## Install ggplot2 package ifnot exists
## install.packages("ggplot2")

##  Call ggplot2 library
library(ggplot2)

## Check if file exists and read using readRDS()
if(!exists("NEI")){
    NEI <- readRDS("../data/summarySCC_PM25.rds")
}

if(!exists("SCC")){
    SCC <- readRDS("../data/Source_Classification_Code.rds")
}

# Get the subset data from NEI data for Baltimore's fip.
dataNEIBaltimore <- NEI[NEI$fips=="24510",]

aggregatedTotalByYearType <- aggregate(Emissions ~ year + type, dataNEIBaltimore, sum)

## Define png
png("plot3.png",width=480,height=480,units="px",bg="transparent")

g <- ggplot(aggregatedTotalByYearType, aes(year, Emissions, color = type))
g <- g + geom_line() +
    xlab("year") +
    ylab(expression('Total PM'[2.5]*" Emissions")) +
    ggtitle('Total Emissions in Baltimore City, Maryland (fips == "24510") from 1999-2008')
print(g)

##Close
dev.off()