# Load libraries
library(dplyr)
library(ggplot2)
library(grid)
library(VIM)
library(plyr)


# Load data
emi=readRDS("summarySCC_PM25.rds")
scc=readRDS("Source_Classification_Code.rds")

#Data overview
str(emi)
str(scc)

#1.Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
total_emi=tapply(emi$Emissions,emi$year,sum)
par(mfrow=c(1,1))
barplot(total_emi,xlab = "Year", ylab = "Total PM2.5 Emissions in Tons", main = "Total PM 2.5 Emissions (tons) in USA")
dev.copy(png,'plot1.png',width=480,height=480)
dev.off()
#Answer Yes

#2.Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510"\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.
Baltimore=filter(emi,fips=='24510')
total_baltimore=tapply(Baltimore$Emissions,Baltimore$year,sum)
barplot(total_baltimore, xlab = "Year", ylab = "Total PM2.5 Emissions (Tons)", main = "Yearly Emissions (tons) in Baltimore City, Maryland")
dev.copy(png,'plot2.png',width=480,height=480)
dev.off()
# Answer:No

#3.Of the four types of sources indicated by the type\color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? 
#Use the ggplot2 plotting system to make a plot answer this question.
Baltimore=filter(emi,fips=='24510')
type_baltimore=ddply(Baltimore,.(year,type),function(x) emissons=sum(x$Emissions))
names(type_baltimore)[3]='emissions'
qplot(year,emissions,data=type_baltimore,color=type,geom='line')+labs(x='year',y='Total PM2.5 Emissions in tons',title='Emission by Type and Year in Baltimore City')
dev.copy(png,'plot3.png',width=480,height=480)
dev.off()
#Answer: Point


#4.Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
#emi2=emi[emi$SCC %in% scc[grep('Coal',scc$EI.Sector),1],]
coal <- grep("coal", scc$Short.Name, ignore.case = TRUE)
coal <- scc[coal, ]
coal_emi=emi[emi$SCC %in%coal$SCC, ]
total_coal=data.frame(tapply(coal_emi$Emissions,coal_emi$year,sum))
colnames(total_coal)='Emissions'
total_coal$year=row.names(total_coal)

ggplot(total_coal,aes(x=year,y=Emissions))+ geom_point(size=5,shape=10) + labs(x='year',y='Emissons',title="PM2.5 Emission by Coal Combustion in USA")+
        theme(plot.title = element_text(hjust = 0.5))
dev.copy(png,'plot4.png',width=480,height=480)
dev.off()


#5.How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
# Filter with regular expression names containing "Vehicles" or "vehicles"
vehicles1 <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))
vehicles <- SCC[SCC$EI.Sector %in% vehicles1, ]["SCC"]

# Select observations relating to Baltimore MD
vehiclesBaltimore <- NEI[NEI$SCC %in% vehicles$SCC & NEI$fips == "24510",]

# Compute yearly totals
vehiclesBaltimoreYearly <- ddply(vehiclesBaltimore, .(year), function(x) sum(x$Emissions))

# Rename columns meaningfully
colnames(vehiclesBaltimoreYearly)[2] <- "emissions"

# Plot to screen
# png("plot5.png", width = 480, height = 480)
qplot(year, emissions, data = vehiclesBaltimoreYearly, geom = "line", color = emissions, size = 1) + ggtitle("PM2.5 Emissions by Motor Vehicles in Baltimore City") + xlab("Year") +
        ylab("PM2.5 Emissions in Tons")





#6.Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"\color{red}{\verb|fips == "06037"|}fips=="06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?
# Filter with regular expression names containing "Vehicles" or "vehicles"
vehicles1 <- unique(grep("Vehicles", SCC$EI.Sector, ignore.case = TRUE, value = TRUE))
vehicles <- SCC[SCC$EI.Sector %in% vehicles1, ]["SCC"]

# Select observations relating to Baltimore MD
vehiclesBaltimore <- NEI[NEI$SCC %in% vehicles$SCC & NEI$fips == "24510",]

# Select observations relating to Los Angeles County CA
vehiclesLosAngelesCounty <- NEI[NEI$SCC %in% vehicles$SCC & NEI$fips == "06037",]

# Merge observations of Baltimore and Los Angeles County
vehiclesCompare <- rbind(vehiclesBaltimore, vehiclesLosAngelesCounty)

# Compute yearly totals
vehiclesCompareYearly <- aggregate(Emissions ~ fips * year, data = vehiclesCompare, FUN = sum )

# Assign location names to variable
vehiclesCompareYearly$county <- ifelse(vehiclesCompareYearly$fips == "06037", "Los Angeles", "Baltimore")

# Plot to screen
# png("plot6.png", width = 800, height = 480)
qplot(year, Emissions, data = vehiclesCompareYearly, geom = "line", color = county, size = Emissions) + ggtitle("PM2.5 Emissions by Motor Vehicles in Baltimore City, MD, Vs Los Angeles County, CA") + xlab("Year") + 
        ylab("PM2.5 Emissions in Tons")        
