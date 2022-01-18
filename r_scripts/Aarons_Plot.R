#Exploratory Analysis

# Load plotly and dplyr packages
library(plotly)
library(dplyr)

# load data int0 govtExpenditures variable
govtExpenditures <- read.csv("https://raw.githubusercontent.com/info-201a-au21/final-project-notachevy/main/data/average-reading-performance-in-pisa-and-average-spending-per-student.csv?token=AT6RNREDCEWVW3PEY2SX5OTBYQP2K")

# Change column names to something more understandable
colnames(govtExpenditures) <- c("Entity", 
                               "Code", 
                               "Year", 
                               "Mean_Reading_Performance",
                               "Expenditure_Per_Student", 
                               "Population", 
                               "Country")

# Testing for most recent year in data that has values
most_recent_year <- max(govtExpenditures$Year)
recent_year_data <- govtExpenditures %>%
  filter(Year >1800)

# filter to years greater than 2000. Group by Entity, mean of countries with 
# with data between 2000 and 2015
performance_by_entity <- govtExpenditures %>%
  group_by(Code) %>%
  filter(Year > 2000) %>%
  na.omit(Mean_Reading_Performance) %>%
  summarize(Entity, Mean_expenditure = mean(Expenditure_Per_Student), 
            Mean_By_Entity = mean(Mean_Reading_Performance),
            population = mean(Population))

# Plot a choropleth map by reading performances by country
aarons_plot <- plot_ly(performance_by_entity, 
        type = 'choropleth', 
        locations = ~Code,
        z = ~Mean_By_Entity,
        text = ~Entity,
        autocolorscale = "purples"
        ) %>%
  colorbar(title = "Avg. Reading Performance") %>%
  layout(title = 'Average Reading Performance by Country from 2000 - 2015')




