## Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
## Use the base plotting system to make a plot answering this question.

## Check if file exists and read using readRDS()
if(!exists("NEI")){
    NEI <- readRDS("../data/summarySCC_PM25.rds")
}

if(!exists("SCC")){
    SCC <- readRDS("../data/Source_Classification_Code.rds")
}

# Get the subset data from NEI data for Baltimore's fip.
dataNEIBaltimore <- NEI[NEI$fips=="24510",]

aggregatedTotalByYear <- aggregate(Emissions ~ year, dataNEIBaltimore, sum)

## Define png
png("plot2.png",width=480,height=480,units="px",bg="transparent")

## use batplot function
barplot(
    (aggregatedTotalByYear$Emissions)/10^6,
    names.arg=aggregatedTotalByYear$year,
    xlab="Year",
    ylab="PM2.5 Emissions (Tons)",
    main="Total PM2.5 Emissions From all Baltimore City"
)

##Close
dev.off()
