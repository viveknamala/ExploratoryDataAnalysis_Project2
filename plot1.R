## Check if file exists and read using readRDS()
if(!exists("NEI")){
    NEI <- readRDS("../data/summarySCC_PM25.rds")
}

if(!exists("SCC")){
    SCC <- readRDS("../data/Source_Classification_Code.rds")
}

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

aggregatedTotalByYear <- aggregate(Emissions ~ year, NEI, sum)

## Define png
png("plot1.png",width=480,height=480,units="px",bg="transparent")

## use batplot function
barplot(
    (aggregatedTotalByYear$Emissions)/10^6,
    names.arg=aggregatedTotalByYear$year,
    xlab="Year",
    ylab="PM2.5 Emissions (10^6 Tons)",
    main="Total PM2.5 Emissions From All US Sources"
)

##Close
dev.off()