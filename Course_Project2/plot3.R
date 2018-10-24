# This program makes a plot to see, of the four types of sources (point, nonpoint, onroad, nonroad),
# which of them have seen decreases or increases in emissions from 1999-2008
# for Baltimore City

# adding libraries
library(ggplot2)

# setting general options
# no scientific notation
options(scipen = 50)

# assuming both files are in the working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subsetting NEI to obtain only Baltimore records
NEI_Baltimore<- subset(NEI, fips=="24510")

# obtaining total PM25 emissions per year and type
emissions_year<- aggregate(NEI_Baltimore$Emissions, list(NEI_Baltimore$year, NEI_Baltimore$type), sum)

# set field names
names(emissions_year)<- c("Year", "Type", "PM25.Emissions")

# make Year a factor value
emissions_year$Year<- as.factor((emissions_year$Year))

# Create PNG file in the current directory
png(filename="plot3.png", width = 480, height = 480 )

# plotting using ggplot2
g<- ggplot(data=emissions_year, aes(x=Year, y=PM25.Emissions)) + geom_col() + facet_wrap(.~Type, ncol=2) + ggtitle("Baltimore PM25 emissions by Type 1999-2008") + labs(x="Year", y="PM25 Emissions (tons)") + theme(plot.title = element_text(hjust = 0.5))
print(g)

#Close file
dev.off()