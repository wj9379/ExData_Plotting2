#4.Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
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
#Answer: Emissions from coal combustion related soureces have decreased arond 1/3 during the decade
