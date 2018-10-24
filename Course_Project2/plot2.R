# This program makes a plot to see if total emissions from PM2.5 
# decreased in the Baltimore City, Maryland from 1999 to 2008

# setting general options
# no scientific notation
options(scipen = 50)

# assuming both files are in the working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subsetting NEI to obtain only Maryland records
NEI_Baltimore<- subset(NEI, fips=="24510")

# obtaining total PM25 emissions per year
emissions_year<- tapply(NEI_Baltimore$Emissions, NEI_Baltimore$year, FUN = sum)

# Create PNG file in the current directory
png(filename="plot2.png", width = 480, height = 480 )

# plotting using barplot
barplot(emissions_year, col='red',  xlab='Year', ylab= "PM25 Emissions (tons)", main = "Baltimore Total PM25 Emissions 1999-2008")

# Close file
dev.off()