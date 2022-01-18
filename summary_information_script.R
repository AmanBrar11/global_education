# SUMMARY INFORMAION SCRIPT

# Load the tidyverse, dplyr, ggplot 2, scales, and maps packages
library(tidyverse)
library(dplyr)
library(ggplot2)
library(scales)
library(maps)
library(plotly)

# VARIABLES 1-3
# 1. most_improved_literacy - Finds the country which has had the most improvement in their literacy rate from 1900 - 2015 (With Average and Total Change)
# 2. least_improved_literacy - Finds the country which has had the least improvement in their literacy rate from 1900 - 2015 (With Average and Total Change)
# 3. most_consistent_literacy - Finds the country or countries that have seen the smallest amount of change in literacy rate from 1900 - 2015 (With Average and Total Change)

# Gets literacy rates data and stores 'NA' in empty cells.
literacy_rates <- read.csv("https://raw.githubusercontent.com/AmanBrar11/global_education/main/data/cross-country-literacy-rates.csv",
                           na.strings=c("","NA"))

# Changes the column names for 'literacy_rates' to more logical labels.                        
colnames(literacy_rates) <- c("Country", "Code", "Year", "Literacy_Rate")

# Finds data after the year 1900 and drops rows with any 'NA' values.
chart_data <- literacy_rates%>%
  drop_na()%>%
  filter(Year >= 1900)

# Finds data on how each country's literacy rate has changed from the previous 
# entry. Stores the total amount and change as well as the average change.
value_data <- literacy_rates%>%
  drop_na()%>%
  filter(Year >= 1900)%>%
  group_by(Country)%>%
  mutate(Literacy_Change = Literacy_Rate - lag(Literacy_Rate,  default = NA))%>%
  summarize(Total_Change = sum(Literacy_Change, na.rm = T),
            Average_Change = abs(mean(Literacy_Change, na.rm = T)))

# Finds the country which has had the most improvement in their literacy rate 
# from 1900 - 2015.
most_improved_literacy <- value_data%>%
  filter(Total_Change == max(Total_Change))

# Finds the country which has had the least improvement in their literacy rate 
# from 1900 - 2015.
least_improved_literacy <- value_data%>%
  filter(Total_Change == min(Total_Change))

# Finds the country or countries that have seen the smallest amount of change in 
# literacy rate from 1900 - 2015.
most_consistent_literacy <- value_data%>%
  filter(Average_Change == min(Average_Change, na.rm = T))

list(most_improved_literacy, least_improved_literacy, most_consistent_literacy)

# VARIABLES 4-5
# 4. most_out_school - Returns data of the country with the highest total out of school primary population from 1900 - 2010 (With Annual Average and Total Change)
# 5. least_out_school - Returns data of the country with the lowest total out of school primary population from 1900 - 2010 (With Annual Average and Total Change)

# Load children out of primary school worldwide data into variable
# named 'out_school_raw'
out_school_raw <- read.csv(file = "https://raw.githubusercontent.com/AmanBrar11/global_education/main/data/out-of-school-children-of-primary-school-age-by-world-region.csv")

# Change the column names for 'out_school' to more logical labels.                        
colnames(out_school_raw) <- c("Country", "Code", "Year", "Out_Of_School")

# Remove all non-country, cumulative values in the data
# (focusing on countries as our line of query), NA
# values, and filters to relevant years 1900 and above
out_school <- out_school_raw%>%
  filter(!grepl('World', Country))%>%
  filter(!grepl('IDA', Country))%>%
  filter(!grepl('IBRD only', Country))%>%
  filter(!grepl('Early', Country))%>%
  filter(!grepl('Sub-Saharan Africa', Country))%>%
  filter(!grepl('North America', Country))%>%
  filter(!grepl('South America', Country))%>%
  filter(!grepl('South Asia', Country))%>%
  filter(!grepl('Latin', Country))%>%
  filter(!grepl('Europe', Country))%>%
  filter(!grepl('East Asia', Country))%>%
  filter(!grepl('Least', Country))%>%
  filter(!grepl('Pre-', Country))%>%
  filter(!grepl('Heavily', Country))%>%
  filter(!grepl('Upper', Country))%>%
  filter(!grepl('Fragile', Country))%>%
  filter(!grepl('Low', Country))%>%
  filter(!grepl('Middle', Country))%>%
  filter(!grepl('Small', Country))%>%
  filter(!grepl('Late', Country))%>%
  filter(!grepl('High', Country))%>%
  filter(!grepl('OECD', Country))%>%
  filter(!grepl('Post', Country))%>%
  drop_na()%>%
  filter(Year >= 1900)%>%
  group_by(Country)

# Returns data on how each country's enrollment has changed from the previous 
# entry (years). Stores the total amount and change as well as the average change.
avg_out_school <- out_school%>%
  drop_na()%>%
  group_by(Country)%>%
  mutate(out_school_change = Out_Of_School - lag(Out_Of_School,  default = NA))%>%
  summarize(total_out_school_change = sum(out_school_change, na.rm = T),
            avg_out_school_change = mean(out_school_change, na.rm = T))

# Returns data of the country with the highest total out of school
# primary population from 1900-2010 with their average yearly change
# China, Total = 6267947, Avg = 626795
most_out_school <- avg_out_school%>%
  filter(total_out_school_change == max(total_out_school_change))

# Returns data of the country with the lowest total out of school
# primary population from 1900-2010 with their average yearly change
# India, Total = -25417752, Avg = -2118146
# NOTE: NEGATIVE values means positive enrollment
least_out_school <- avg_out_school%>%
  filter(total_out_school_change == min(total_out_school_change))

# summary_information results
# Variable 1 - most_improved_literacy: [Country] Panama, [Total Change] 78.0, [Average Change] 3.72
# Variable 2 - least_improved_literacy: [Country] Lesotho, [Total Change] -6.89, [Average Change] 3.45
# Variable 3 - most_consistent_literacy: [Country] Antigua and Barbuda; Congo; Marshall Islands, [Total Change] 0; 0; 0, [Average Change] 0; 0; 0
# Variable 4 - most_out_school: [Country] China, [Total Change] 6267947, [Average Change] 626795
# Variable 5 - least_out_school: [Country] India, [Total Change] -25417752, [Average Change] -2118146
summary_information <- list(most_improved_literacy, least_improved_literacy, most_consistent_literacy, most_out_school, least_out_school)
# summary_information
