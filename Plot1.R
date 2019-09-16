1.Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
total_emi=tapply(emi$Emissions,emi$year,sum)
par(mfrow=c(1,1))
barplot(total_emi,xlab = "Year", ylab = "Total PM2.5 Emissions in Tons", main = "Total PM 2.5 Emissions (tons) in USA")
dev.copy(png,'plot1.png',width=480,height=480)
dev.off()
#Answer Yes
