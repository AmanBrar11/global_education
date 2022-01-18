# Kennys plot

library(plotly)
library(dplyr)

# Load CSV data into 'out_school_pop_raw'
out_school_pop_raw <- read.csv("https://raw.githubusercontent.com/AmanBrar11/global_education/main/data/out-of-school-children-of-primary-school-age-by-world-region.csv")

# Change the column names for 'out_school_pop_raw' to more logical labels.               
colnames(out_school_pop_raw) <- c("Continent", "Code", "Year", "Children_Out_Of_Primary_School")

# Remove NA values and focus on modern data (1980 and above)
out_school_pop <- out_school_pop_raw %>%
  filter(Year >= 2000)

out_school_pop_cont <- filter(
  out_school_pop, Continent == "Middle East & North Africa" |
    Continent == "North America" |
    Continent == "Latin America & Caribbean" |
    Continent == "East Asia & Pacific" |
    Continent == "South Asia" |
    Continent == "European Union" |
    Continent == "Australia" |
    Continent == "World"
)
