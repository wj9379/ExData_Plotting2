#3.Of the four types of sources indicated by the type\color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? 
#Use the ggplot2 plotting system to make a plot answer this question.
Baltimore=filter(emi,fips=='24510')
type_baltimore=ddply(Baltimore,.(year,type),function(x) emissons=sum(x$Emissions))
names(type_baltimore)[3]='emissions'
qplot(year,emissions,data=type_baltimore,color=type,geom='line')+labs(x='year',y='Total PM2.5 Emissions in tons',title='Emission by Type and Year in Baltimore City')
dev.copy(png,'plot3.png',width=480,height=480)
dev.off()
#Answer: Non-road, nonpoint and on-road have decreased overall in Baltimore
