# Exploratory Analysis

# Load the tidyverse, dplyr, ggplot 2, scales, and maps packages
library(tidyverse)
library(dplyr)
library(ggplot2)
library(scales)
library(maps)
library(plotly)

# Load children out of primary school worldwide data into variable
# named 'out_school'
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

# Slice to find the highest unenrolled primary students for each country
# and their respective year
top_out_school <- out_school%>%
  slice_max(n=1, Out_Of_School)%>%
  arrange(Out_Of_School)

# Limit list to top 10 variables (countries)
high_out_school <- tail(top_out_school, n=10)

# Visualize bar graph of country and year of the 10 highest primary unenrollment
# figures from 1900-2010 with their countries and respective years
kennys_plot <- plot_ly(data = high_out_school, x = ~Year, y = ~Out_Of_School, color = ~Country, 
        type = "bar") %>%
  layout(title = 'Country and Year of the 10 Highest Primary Unenrolled Totals', xaxis = list(title = 'Year'), 
         yaxis = list(title = '# of Primary-Aged Children Unenrolled'))

# Ensure values have a sensible number of significant figures
options(digits=2)

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
# print(most_out_school)

# Returns data of the country with the lowest total out of school
# primary population from 1900-2010 with their average yearly change
# India, Total = -25417752, Avg = -2118146
# NOTE: NEGATIVE values means positive enrollment
least_out_school <- avg_out_school%>%
  filter(total_out_school_change == min(total_out_school_change))
# print(least_out_school)

# Ensure tables are descriptive and understandable
colnames(avg_out_school) <- c("Country", "1900-2010 Total Primary Out of School Change",
           "1900-2010 Average Primary Out of School Change (Annually)")

# Transfer final table into enrollment_aggregate_table
enrollment_aggregate_table <- avg_out_school
# enrollment_aggregate_table
