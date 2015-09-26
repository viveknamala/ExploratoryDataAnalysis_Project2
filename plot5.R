## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
## Check if file exists and read using readRDS()
if(!exists("NEI")){
    NEI <- readRDS("../data/summarySCC_PM25.rds")
}

if(!exists("SCC")){
    SCC <- readRDS("../data/Source_Classification_Code.rds")
}

## Gather the subset of the NEI data which corresponds to vehicles
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

## Subset the vehicles NEI data to Baltimore's fip
vehiclesNEIBaltimore <- vehiclesNEI[vehiclesNEI$fips=="24510",]

png("plot5.png",width=480,height=480,units="px",bg="transparent")

##  Call ggplot2 library
library(ggplot2)

g <- ggplot(vehiclesNEIBaltimore,aes(factor(year),Emissions)) +
    geom_bar(stat="identity",fill="grey",width=0.75) +
    theme_bw() +  guides(fill=FALSE) +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
    labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

print(g)

dev.off()