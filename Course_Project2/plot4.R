# This program makes a plot to see, across the United States, 
# how the emissions from coal combustion-related sources have changed from 1999-2008

# setting general options
# no scientific notation
options(scipen = 50)

# assuming both files are in the working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# merging both datasets
merged_data<- merge(NEI, SCC, by = "SCC")

# subsetting the new dataset to obtain only coal combustion-related records
v_boolean<- grepl("[Cc]oal", merged_data$EI.Sector)
NEI_Coal<- merged_data[v_boolean,]

# obtaining total PM25 emissions per year
emissions_year<- tapply(NEI_Coal$Emissions, NEI_Coal$year, FUN = sum)

# Create PNG file in the current directory
png(filename="plot4.png", width = 480, height = 480 )

# plotting using barplot
barplot(emissions_year, col='red',  xlab='Year', ylab= "PM25 Emissions (tons)", main = "US coal combustion-related emissions 1999-2008")

#Close file
dev.off()