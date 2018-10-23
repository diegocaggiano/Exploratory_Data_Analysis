# assuming both files are in the working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# obtaining total PM25 emissions per year
emissions_year<- tapply(NEI$Emissions, NEI$year, FUN = sum)

# plotting using barplot
barplot(emissions_year, col='red')