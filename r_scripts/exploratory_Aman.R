# Gets literacy rates data and stores 'NA' in empty cells.
literacy_rates <- read.csv("https://raw.githubusercontent.com/info-201a-au21/final-project-notachevy/main/data/cross-country-literacy-rates.csv?token=AT6RNRD7OEFAZQLUU673UPTBYQR7C",
                           na.strings=c("","NA"))

# Changes the column names for 'literacy_rates' to more logical labels.                        
colnames(literacy_rates) <- c("Country", "Code", "Year", "Literacy_Rate")
# View(literacy_rates)

# Loads in dplyr, tidyverse, and plotly libraries.
library(dplyr)
library(plotly)
library(tidyverse)

# Finds data on how each country's literacy rate has changed from the previous 
# entry. Stores the total amount and change as well as the average change.
value_data <- literacy_rates%>%
  drop_na()%>%
  filter(Year >= 1900)%>%
  group_by(Country)%>%
  mutate(Literacy_Change = Literacy_Rate - lag(Literacy_Rate,  default = NA))%>%
  summarize(Total_Change = sum(Literacy_Change, na.rm = T),
            Average_Change = abs(mean(Literacy_Change, na.rm = T)))
# View(value_data)

# Finds top 5 countries with the greatest change in literacy.
top_5_change <- value_data%>%
  arrange(desc(Total_Change))%>%
  slice(1:5)
# View(top_5_change)

# Finds bottom 5 countries with the worst change in literacy.
bottom_5_change <- value_data%>%
  arrange(Total_Change)%>%
  slice(1:5)
# View(bottom_5_change)

# Binds the top and the bottom 5 literacy rates together.
top_and_bottom <- rbind(top_5_change, bottom_5_change)
# View(top_and_bottom)

# Gets the literacy rate data for the top and bottom 5 countries.
chart_data <- literacy_rates%>%
  drop_na()%>%
  inner_join(top_and_bottom , by = "Country")%>%
  filter(Year >= 1900)
# View(chart_data)

# Creates line graph with each line being a country's literacy rate from 1900 to
# 2015.
amans_plot <- plot_ly(data = chart_data, x = ~Year, y = ~Literacy_Rate, color = ~Country, 
                      type = "scatter", mode = "lines")%>%
  layout(title = "<b>Top 5 & Bottom 5 Countries for Most Improved Literacy</b>",
         titlefont=list(size=12), 
         yaxis = list(title = "Literacy Rate"),
         legend = list(title = list(text = "<b>Countries</b>")))

# Finds the country which has had the most improvement in their literacy rate 
# from 1900 - 2015.
most_improved_literacy <- value_data%>%
  filter(Total_Change == max(Total_Change))%>%
  pull(Country)

# Finds the country which has had the least improvement in their literacy rate 
# from 1900 - 2015.
least_improved_literacy <- value_data%>%
  filter(Total_Change == min(Total_Change))%>%
  pull(Country)

# Finds the country or countries that have seen the smallest amount of change in 
# literacy rate from 1900 - 2015.
most_consistent_literacy <- value_data%>%
  filter(Average_Change == min(Average_Change, na.rm = T))%>%
  pull(Country)
