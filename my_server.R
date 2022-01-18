source("table.R")
source("summary_information_script.R")
source("r_scripts/Aarons_Plot.R")
source("r_scripts/Kennys_Plot.R")
source("r_scripts/exploratory_kenny.R")
source("r_scripts/exploratory_Aman.R")


server <- function(input, output) {
   output$amans_chart <- renderPlotly({
      return(amans_plot)
   })
   
   output$amans_mod_chart <- renderPlotly({
      if(input$amanschartvar == "") {
         chart_mod_data <- literacy_rates%>%
            filter(Country == "United States")
      } else {
         chart_mod_data <- literacy_rates%>%
            filter(Country == input$amanschartvar)
      }
      
      g <- ggplot(chart_mod_data) +
         geom_point(mapping = aes_string(x = "Year", y = "Literacy_Rate", color = "Country")) +
         labs(x = "Year", y = "Literacy Percentage", title = "Global Literacy Rates") +
         xlim(input$amansyearrange[1], input$amansyearrange[2]) +
         ylim(0, 100) +
         geom_line(mapping = aes_string(x = "Year", y = "Literacy_Rate", color = "Country"))

      return(ggplotly(g))
   })
   
   # Aarons plot
   output$aarons_chart <- renderPlotly({
     if (input$map_value == "expenditure_per_student") {
       p2 <- plot_ly(performance_by_entity, 
                     type = 'choropleth', 
                     locations = ~Code,
                     z = ~Mean_expenditure,
                     text = ~Entity,
                     colorscale = input$color
       ) %>%
         colorbar(title = "Avg. Expenditure per Student") %>%
         layout(
           title = 'Average Expenditure per Student by Country from 2000 - 2015'
           )
       
       p2
     } else if (input$map_value == "population") {
       p3 <- plot_ly(performance_by_entity, 
                     type = 'choropleth', 
                     locations = ~Code,
                     z = ~population,
                     text = ~Entity,
                     colorscale = input$color
       ) %>%
         colorbar(title = "Population") %>%
         layout(
           title = 'Population by Country in 2015'
         )
       
       p3
     } else {
       p1 <- plot_ly(performance_by_entity, 
                     type = 'choropleth', 
                     locations = ~Code,
                     z = ~Mean_By_Entity,
                     text = ~Entity,
                     colorscale = input$color
       ) %>%
         colorbar(title = "Avg. Reading Performance") %>%
         layout(
           title = 'Average Reading Performance by Country from 2000 - 2015'
           )
       p1
     }
   })
   
# Kennys Plot
   
# Makes adjustable & interactive plot of out of school population.
     
     output$Out_of_School_Chart <- renderPlotly({
       # Selects data for a continent and the world based on user's input
       if(input$selected_cont == "North America") {
         selected.data <- out_school_pop_cont %>% filter(Continent == "North America" | Continent == "World") %>%
           select(Continent, Year, Children_Out_Of_Primary_School)
       } else if (input$selected_cont == "Latin America & Caribbean") {
         selected.data <- out_school_pop_cont %>% filter(Continent == "Latin America & Caribbean" | Continent == "World") %>%
           select(Continent, Year, Children_Out_Of_Primary_School)
       }  else if (input$selected_cont == "European Union") {
         selected.data <- out_school_pop_cont %>% filter(Continent == "European Union" | Continent == "World") %>%
           select(Continent, Year, Children_Out_Of_Primary_School)
       }  else if (input$selected_cont == "Middle East & North Africa") {
         selected.data <- out_school_pop_cont %>% filter(Continent == "Middle East & North Africa" | Continent == "World") %>%
           select(Continent, Year, Children_Out_Of_Primary_School)
       }  else if (input$selected_cont == "East Asia & Pacific") {
         selected.data <- out_school_pop_cont %>% filter(Continent == "East Asia & Pacific" | Continent == "World") %>%
           select(Continent, Year, Children_Out_Of_Primary_School)
       }  else if (input$selected_cont == "South Asia") {
         selected.data <- out_school_pop_cont %>% filter(Continent == "South Asia" | Continent == "World") %>%
           select(Continent, Year, Children_Out_Of_Primary_School)
       }  else if (input$selected_cont == "Australia") {
         selected.data <- out_school_pop_cont %>% filter(Continent == "Australia" | Continent == "World") %>%
           select(Continent, Year, Children_Out_Of_Primary_School)
       }  else if (input$selected_cont == "All Regions") {
         selected.data <- out_school_pop_cont %>% filter(Continent == "Middle East & North Africa" |
                                                           Continent == "South Africa" |
                                                           Continent == "North America" |
                                                           Continent == "Latin America & Caribbean" |
                                                           Continent == "East Asia & Pacific" |
                                                           Continent == "South Asia" |
                                                           Continent == "European Union" |
                                                           Continent == "Australia") %>%
           select(Continent, Year, Children_Out_Of_Primary_School)
       }  else {
         selected.data <- out_school_pop_cont %>% select(Continent, Year, Children_Out_Of_Primary_School)
       }
       
       # Selects data for a specific year based on the user's input selection
       selected.data <- selected.data %>% filter(Year == input$selected_year)
       # Selects data for a specific year based on the user's input selection
       selected.data <- selected.data %>%
         filter(Year == input$selected_year) %>%
         arrange(desc(Continent))
       
       kennys_chart <- plot_ly(data = selected.data,
                        x = ~Year,
                        y = ~Children_Out_Of_Primary_School,
                        color = ~Continent, 
                        type = 'bar')
       
       kennys_chart <- kennys_chart %>%
         layout(title = "Primary Population Out of School, Major Region vs. the World",
                xaxis = list(
                  title = "Year"),
                range = c(kennys_year_input), type='category',
                yaxis = 
                  list(title = "Population Out of School, Primary"),
                barmode = 'group')
       
       return(kennys_chart)
     })
     
# Addded image of scholarly globe.
     output$myImage <- renderImage({
       list(src = "image/dumbstupidplanetwithnohoes.jpg",
            contentType = "image/png",
            align="center")
     })
# Addded image of scholarly fellow.
     output$myKyle <- renderImage({
       list(src = "image/cutehandsomeguy.jpg",
            contentType = "image/png",
            height=350, width=600, align="center")
     })
}
