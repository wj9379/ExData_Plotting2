#2.Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510"\color{red}{\verb|fips == "24510"|}fips=="24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.
Baltimore=filter(emi,fips=='24510')
total_baltimore=tapply(Baltimore$Emissions,Baltimore$year,sum)
barplot(total_baltimore, xlab = "Year", ylab = "Total PM2.5 Emissions (Tons)", main = "Yearly Emissions (tons) in Baltimore City, Maryland")
dev.copy(png,'plot2.png',width=480,height=480)
dev.off()
# Answer:Yes. Overall, the emissions have decreased.
