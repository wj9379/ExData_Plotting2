#6.Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"\color{red}{\verb|fips == "06037"|}fips=="06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

vehiclesLosAngelesCounty <- emi[emi$SCC %in% vehicles$SCC & emi$fips == "06037",]

vehiclesCompare <- rbind(vehiclesBaltimore, vehiclesLosAngelesCounty)

vehiclesCompareyear <- aggregate(Emissions ~ fips * year, data = vehiclesCompare, FUN = sum )

vehiclesCompareyear$country <- ifelse(vehiclesCompareyear$fips == "06037", "Los Angeles", "Baltimore")

ggplot(vehiclesCompareyear,aes(x=factor(year),y=Emissions, fill=country))+geom_bar(aes(fill=year),stat="identity") +
        facet_grid(scales="free", space="free", .~country) +
        guides(fill=FALSE) + theme_bw() +
        labs(x="year", y=expression("Emission (Kilo-Tons)")) + 
        labs(title=expression("Motor Vehicle Source Emissions in Baltimore & LA"))
dev.copy(png,'plot6.png',width=480,height=480)
dev.off()
#Answer: LA has seen the greater change than that in Baltimore
