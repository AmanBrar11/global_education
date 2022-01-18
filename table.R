# Aggregate Table

reading_vs_spending <- read.csv("https://raw.githubusercontent.com/AmanBrar11/global_education/main/data/average-reading-performance-in-pisa-and-average-spending-per-student.csv")
library(dplyr)

# Change column names to something more understandable
colnames(reading_vs_spending) <- c("Entity", 
                                "Code", 
                                "Year", 
                                "Mean_Reading_Performance",
                                "Expenditure_Per_Student", 
                                "Population", 
                                "Continent")

aggregate_table <- reading_vs_spending %>%
#   filter(Year == 2015) %>% 
   group_by(Entity) %>% 
   summarize(
      mean_reading_performance = mean(Mean_Reading_Performance, na.rm = TRUE),
      mean_expenditure = mean(Expenditure_Per_Student, na.rm = TRUE),
      Efficiency = round(mean_reading_performance / mean_expenditure, 2)
   ) %>%
   arrange(desc(Efficiency))

Table <- aggregate_table %>% # does it need to be fewer rows?
   select(Entity, Efficiency)



