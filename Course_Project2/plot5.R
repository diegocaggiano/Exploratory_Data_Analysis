# This program makes a plot to see, how emissions 
# from motor vehicle sources have changed from 1999-2008 in Baltimore City

# setting general options
# no scientific notation
options(scipen = 50)

# assuming both files are in the working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# merging both datasets
merged_data<- merge(NEI, SCC, by = "SCC")

# subsetting the new dataset to obtain only motor vehicle-related records for BALTIMORE
v_boolean<- grepl("[Mm]obile", merged_data$EI.Sector) & (merged_data$fips == "24510")
NEI_mobile<- merged_data[v_boolean,]

# obtaining total PM25 emissions per year
emissions_year<- tapply(NEI_mobile$Emissions, NEI_mobile$year, FUN = sum)

# Create PNG file in the current directory
png(filename="plot5.png", width = 480, height = 480 )

# plotting using barplot
barplot(emissions_year, col='red',  xlab='Year', ylab= "PM25 Emissions (tons)", main = "Baltimore motor vehicle-related emissions 1999-2008")

# Close file
dev.off()