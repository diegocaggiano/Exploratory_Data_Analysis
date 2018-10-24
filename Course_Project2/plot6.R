# This program makes a plot to compare, how emissions 
# from motor vehicle sources have changed in Baltimore and Los Angeles
# from 1999-2008

# adding required libraries
library(ggplot2)

# setting general options
# no scientific notation
options(scipen = 50)

# assuming both files are in the working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# merging both datasets
merged_data<- merge(NEI, SCC, by = "SCC")

# BALTIMORE: subsetting the new dataset to obtain only motor vehicle-related records
v_boolean<- grepl("[Mm]obile", merged_data$EI.Sector) & (merged_data$fips == "24510")
NEI_Baltimore<- merged_data[v_boolean,c("fips", "year", "Emissions")]
# adding column with city description insted of fips
NEI_Baltimore <- cbind(NEI_Baltimore, rep("Baltimore", times=nrow(NEI_Baltimore)))
# setting colum names
names(NEI_Baltimore)<- c("fips", "year", "Emissions", "Location")

# LOS ANGELES: subsetting the new dataset to obtain only motor vehicle-related records
v_boolean<- grepl("[Mm]obile", merged_data$EI.Sector) & (merged_data$fips == "06037")
NEI_LA<- merged_data[v_boolean,c("fips", "year", "Emissions")]
# adding column with city description insted of fips
NEI_LA <- cbind(NEI_LA, rep("Los Angeles", times=nrow(NEI_LA)))
# setting colum names
names(NEI_LA)<- c("fips", "year", "Emissions", "Location")

# merging the two datasets
NEI_Baltimore_LA<- rbind(NEI_Baltimore, NEI_LA)

# obtaining total PM25 emissions per year and Location
emissions_year<- aggregate(NEI_Baltimore_LA$Emissions, list(NEI_Baltimore_LA$year, NEI_Baltimore_LA$Location), sum)

# setting field names
names(emissions_year)<- c("Year", "Location", "PM25.Emissions")

# making Year a factor value
emissions_year$Year<- as.factor((emissions_year$Year))

# Create PNG file in the current directory
png(filename="plot6.png", width = 480, height = 480 )

# plotting using ggplot2
g<- ggplot(data=emissions_year, aes(x=Year, y=PM25.Emissions)) + geom_col() + facet_wrap(.~Location, ncol=2) + ggtitle("Baltimore vs Los Angeles PM25 emissions 1999-2008") + labs(x="Year", y="PM25 Emissions (tons)") + theme(plot.title = element_text(hjust = 0.5))
print(g)

# Close file
dev.off()