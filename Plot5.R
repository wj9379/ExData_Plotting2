#5.How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

vehicles1 <- unique(grep("Vehicles", scc$EI.Sector, ignore.case = TRUE, value = TRUE))
vehicles <- scc[scc$EI.Sector %in% vehicles1, ]["SCC"]
vehiclesBaltimore <- emi[emi$SCC %in% vehicles$SCC & emi$fips == "24510",]

vehiclesBaltimoreyear <- ddply(vehiclesBaltimore, .(year), function(x) sum(x$Emissions))

colnames(vehiclesBaltimoreyear)[2] <- "emissions"

qplot(year, emissions, data = vehiclesBaltimoreyear, geom = "line", color = emissions) + ggtitle("Emissions by Motor Vehicles in Baltimore City") + xlab("Year") +
        ylab("Emissions in Tons")
dev.copy(png,'plot5.png',width=480,height=480)
dev.off()
#Answer: Yes, Emissions from motor vehicle sources have dropped during this time frame
