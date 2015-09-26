## Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
## Check if file exists and read using readRDS()
if(!exists("NEI")){
    NEI <- readRDS("../data/summarySCC_PM25.rds")
}

if(!exists("SCC")){
    SCC <- readRDS("../data/Source_Classification_Code.rds")
}

##  Call ggplot2 library
library(ggplot2)

combustionRelated <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRelated <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustionRelated & coalRelated)
combustionSCC <- SCC[coalCombustion,]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]

## Define png
png("plot4.png",width=480,height=480,units="px",bg="transparent")

g <- ggplot(combustionNEI, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
    xlab("year") +
    ylab(expression('Total PM'[2.5]*" Emissions")) +
    ggtitle('Total Emissions from coal sources from 1999-2008')

print(g)

##Close
dev.off()