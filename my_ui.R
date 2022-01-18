# Aarons tab
aarons_main_content <- mainPanel(
            plotlyOutput("aarons_chart")
)

aarons_sidebar_content <- sidebarPanel(
  selectInput(
    inputId = "map_value",
    label = "Value to show on World Map",
    choices = list(
      "Expenditure per Student" = "expenditure_per_student",
      "Reading Score" = "reading_score",
      "Populations" = "population"
    ),
    selected = "reading_score"
  ),
  selectInput(
    "color",
    label = "Select a Color",
    choices = list(
      "blackbody" = "Blackbody",
      "bluered" = "Bluered",
      "earth" = "Earth",
      "rainbow" = "Rainbow"
    ),
    selected = "Rainbow"
  )
)

aarons_panel <-  tabPanel(
  "PISA Scores",
  h1(
    "PISA Reading Performance Compared to Population and Expenditure per 
    Student of Each Country"
    ),
  sidebarLayout(
    aarons_sidebar_content,
    aarons_main_content
  ),
  h3("Reading Scores"),
  p("This chart shows the average PISA reading test scores for each country 
     between the years 2000 to 2015. By looking at this chart, we can see which 
     countries have the highest and lowest reading performance scores. The map 
     gives us a better idea for which countries have education as a top priority 
     in recent years. The chart makes it obvious that Finland has the highest 
     reading performance scores in the world. The regions of South America and 
     Southeast Asia seem to be struggling the most in reading performance. This 
     is primarily due to those governments having less money to spend on areas 
     such as education which can be shown by choosing the expenditure per 
     student value. Regions such as Australia, United States, and Europe are 
     towards the top of the reading performances which is not a surprise 
     considering the amount of money these countries have for spending. 
     Unfortunately, there are many countries that PISA was not able to get 
     reading score data from. All of Africa, Russia, the Middle East, and Canada 
     did not have any data for reading performance so that is why those 
     countries are filled with white rather than a color from the legend. The 
     choice to make the data from 2000 to 2015 is to show the most recent scores 
     from the data and to also show trends of modern day tests and curriculum. 
     Education has changed so much over the past century that we felt it would 
     not give us accurate observations to calculate an average of more than the 
     most recent 15 years."),
  br(),
  h3("Expenditure Per Student"),
  p("This option on the chart corresponds to the amount of money that each 
    country spends on a single student's education. This value is included to 
    explore the relationship between expenditure per student and a countries
    average reading test scores. The country with the highest average 
    expenditure per student between 2000 and 2015 was Norway, with the United 
    States and Sweden close behind. Surprisingly, Finland does not even have the 
    top 5 highest expenditure per student despite having the world's highest 
    reading scores. It is clear from the chart that having an expenditure per 
    student on the lower end means that the country almost always has low 
    reading scores as well. South America and Southeast Asia have some of the
    lowest reading scores and lowest expenditures per student."),
  br(),
  h3("Population"),
  p("The last value on the map is population. We included population because we
    felt there may be a correlation between population and expenditure per 
    student. The United States clearly has the highest population on the map and 
    they also have one of the highest expenditures per student. But when looking 
    at the rest of the world, it gets more difficult to tell if population has 
    any effect on money for education. Countries like Brazil and Indonesia have 
    some of the highest populations with expenditures per student on the lower
    end of the world. While Finland and Norway have low populations with the 
    highest expenditures per student. Overall, our hypothesis is that population 
    does not have a relationship with expenditure per student or reading scores.
    ")
)

# Amans tab

amans_mod_chart_main_content <- mainPanel(
   plotlyOutput("amans_mod_chart")
)

amans_mod_chart_sidebar_content <- sidebarPanel(
   selectInput(
      "amanschartvar",
      label = "Search for an Entity:",
      choices = literacy_rates$Country,
      selected = "United States"
   ),
   sliderInput(
      "amansyearrange",
      label = "Desired Years:", min = 1900, max = 2015, value = c(1900, 2015)
   )
)

amans_mod_panel <- tabPanel(
   "Literacy Rates",
   fluidPage(
      h1("Global Literacy"),
      p("The purpose of this chart is to display the five countries who have
        improved their literacy rates the most since 1900, as well as the five
        countries which have seen the least improvement, or even some regression
        in their literacy rate since 1900. This chart is meant to help us
        determine any patterns about how different geographical regions' 
        education quality and participation has changed over time. A country's 
        literacy rate can be affected by a number of different factors; however,
        it does give us an idea about the effectiveness or availability of 
        education in these different countries."),
      plotlyOutput("amans_chart"),
      p("The five countries which saw the most improvement since 1900 were
        Panama, Bolivia, Mexico, Peru, and Venezuela. An interesting insight
        gathered from this chart is that the countries which have seen the
        greatest improvement in their literacy rate all happen to be in Central
        or South America. This is indicative of a greater focus and a vast
        improvement in education throughout many countries this region over
        the past century. At the start of the 20th century, these five countries
        all had literacy rates in 20s and by 2015 they had all gotten their
        literacy rates to above 90%. The countries which saw the least
        improvement since 1900 were Lesotho, Madagascar, Kenya, Sudan, and
        Grenada; these countries not only did not increase their literacy rate
        but actually saw it decrease over time. Many of these countries have
        few data points reporting their literacy rates; however, we do still
        see a pattern in that the majority of these countries are in Africa with
        the exception of Grenada, which is in the Caribbean. Most of these
        countries do also follow a similar pattern in that they peaked at the
        start of the 21st century then took a large downturn, but as of recent 
        they do seem to be increasing their literacy levels to what they once
        were.")
   ),
   br(),
   br(),
   titlePanel("Global Literacy Rates"),
   sidebarLayout(
      amans_mod_chart_sidebar_content,
      amans_mod_chart_main_content
   ),
   h3("Independent Exploration"),
   p("The first graph showcases two ends of the global literacy spectrum. This
     graph allows the user to compare the literacy of their home region as well 
     as any regions of interest to the highest and lowest performing countries.
     Allowing the user to explore the data means they will likely find patterns
     and insights that we did not. The default is set to our home region - the 
     United States. Showing our home region lets the user make any assumptions 
     about the authors they feel are necessary."),
   br()
)

# Kennys tab

kennys_main_content <- mainPanel(
  plotlyOutput("Out_of_School_Chart")
)

kennys_year_input <- selectInput("selected_year", label = h3("Select a year"), 
                          choices = 2000:2018, 
                          selected = 2018)

kennys_data_input <- radioButtons("selected_cont", label = h3("Select a region"), 
                            choices = c("North America", "Middle East & North Africa",
                                        "Latin America & Caribbean", "East Asia & Pacific", "South Asia",
                                        "European Union", "Australia", "All Regions"),
                            selected = "All Regions")

kennys_sidebar_content <- sidebarPanel(
  kennys_data_input,
  kennys_year_input
)

kennys_panel <- tabPanel(
  "Primary Out of School Population",
  fluidPage(
    h1("Primary Out of School Population, By Major Region"),
    p("The purpose of this chart is to visualize the differences in primary school
        children not enrolled in school by major region. These regions include 
        North America, Middle East & North Africa, Latin America & Caribbean,
        East Asia & Pacific, South Asia, European Union, Australia, and
        finally a visualization of all regions together for further ease of comparison.
        When each region is selected, it also compares its population with the World 
        out of school population to allow the user an additional perspective when 
        analyzing the data. This chart allows us to identify patterns in which major 
        regions have significant (or relatively insignificant) primary school populations
        that are not enrolled in school. However, it is important to note that educational 
        norms and sources of education vary by region, let alone country. This is not 
        an indicator of a region's overall emphasis on education, although, it is an
        important footnote in understanding the level of equity, equality, and 
        quality of education per region."),
    p("Looking at the data, the two regions that consistently hold the highest
        primary out of school populations are East Asia & Pacific and South Asia, with 
        North America and the European Union (EU) holding the lowest out of school 
        populations. It is also important to note that although populations as a whole
        are rising, primary out of school populations overall are decreasing over time.
        The difference between the years 2000 to 2018 is large (e.g. South Asia and 
        the World cut its primary school population by about half) and is indicative of additional 
        emphasis on educational enrollment. Additional case-specific research 
        will be necessary to understand all the factors affecting this increase in
        enrollment, however, it can be assumed that educational equity is continuously
        coming into larger focus which is a step forward for future generations.")
  ),
  br(),
  titlePanel("Primary Out of School Population Comparison"),
  sidebarLayout(
    kennys_sidebar_content,
    kennys_main_content
  ),
  h3("Implications of the Data"),
  p("Although there are additional major world regions (such as Antarctica and 
      South Africa), they were excluded due to their lack of data in the original
      data set. Their availability in the future will be reliant on its collection from
      survey methods utilized by the UNESCO Institute for Statistics. The data was
      limited to 2000-2018 so that the user would not be overwhelmed by an incredible
      amount of choices and to keep focus in our analysis. Additionally,
      the most recent data collected by all major regions is 2018. The default choice 
      is on All Regions to allow the user to branch off of an overview of all data 
      included."),
  br()
)

# some sort of visual flare is needed
intro <- tabPanel(
   "Introduction",
   h1("Education Across the Globe"),
   imageOutput("myImage"),
   h4("Created By: Nathan Ford, Kenny Pham, Aaron Gitell, and Aman Brar"),
   h5("December 8th, 2021"),
   br(),
   h4("For our final project we wanted to delve into the domain of education and
      analyze factors such as literacy rates and educational investments to 
      uncover glova inequities."),
   h5("We first became interested in this domain because:"),
   p("1. We want to contribute to global equity initiatives using our data 
     analysis skills."),
   p("2. We, ourselves, are students and know through our own experiences
   the impact education can have on people's lives. By doing this we hope to 
   identify opportunities to make the educational experience better for future 
   students all around the world."),
   p("3. Data trends will allow us to discover discrepancies between countries
     around the world in regards to their educational systems."),
   br(),
   p("Education has been a significant part of our lives so far and has shaped
     who we are today. Through our experiences, we have seen disparities we want
     to identify through objective means rather than subjective to provide a 
     basis for initiatives towards global educational equity. The first step in
     this process is to illustrate the extent of past and present educational 
     gaps and barriers."),
   br(),
   h4("In this project we will answer:"),
   p("1. What is the distribution of average reading performances between
     applicable countries worldwide?"),
   p("2. Does primary school enrollment population (access to primary school)
     improve literacy rates and/or average reading scores?"),
   p("3. What 5 countries have seen the most literacy rate improvement over time
     and what 5 have seen the least?"),
   br(),
   br(),
   h4("Project Overview"),
   p("One of the areas of education that we wanted to focus on is literacy. A 
     country's literacy can tell a lot about how much of the government's money 
     is going towards the education of their citizens. By looking at the 
     literacy rates for countries from 1900 to 2015, we were able to see that 
     the country that has improved their literacy rates the most was Panama.
     The country that has improved their literacy rates the least was Lesotho. 
     Also, the countries with the most consistent literacy rates throughout the
     years were Antigua and Barbuda, Congo, Marshall Islands. These statistics 
     give us a better idea of the countries that make education a priority vs.
     countries that put little to no effort towards improving their citizens 
     education. We also looked at the number of children that are not in primary
     school by country from 1900 to 2015. We found that the country with the
     most kids not enrolled in primary school has been China, and the country
     with the most kids enrolled in primary school was India. With this data, 
     we can infer that perhaps population has less to do with a country's 
     education, considering that both China and India are the top ranked in
     population but have completely different numbers of kids currently enrolled
     in primary school."),
   br()
)

# insert your key takeaway here

conclusion <- tabPanel(
   "Summary",
   h1("Key Takeaways"),
   br(),
   h4("In completing this project we found that:"),
   p("1. Literacy rates have been rising the fastest in Central and South 
     America. These countries started with low literacy rates in the 1900s, 
     somtimes as low as 20%, but by 2015, raised their literacy rates to 90% or 
     higher in most places."),
   p("2. Finland has the highest reading performance scores in the world.
     The regions of South America and Southeast Asia seem to be struggling
     the most in reading performance. Regions such as Australia, United States,
     and Europe are towards the top of the reading performances. Expenditure per
     student has a direct correlation to reading scores, while population seems 
     to have no affect on reading scores or expenditure per student."),
   p("3. The two regions that consistently hold the highest
      primary out of school populations are East Asia & Pacific and South Asia, with 
      North America and the European Union (EU) holding the lowest out of school 
      populations. Overall, the out of school population is decreasing, which is a
      step forward for educational equity for future generations."),
   br(),
   h4("Conclusion:"),
   p("Overall, in our investigations we discovered that trends of educational 
     effectivness and participation vary not by country by largely by region. It
     has become apparent through our analysis that regions like South and East 
     Asia are those who do not have enough educational infrastructure in place 
     to yield good results and performance. As well many countries in Africa 
     struggle with their education performance. On the other end of the spectrum,
     North America and Europe have well-performing students with a large 
     investment in educational resources to support them. This variation of 
     educational performance stems from factors largely beyond the scope of this
     investigation. There are numerous geopolitical and socioeconomic factors 
     which dictate how much a country can invest into items like education. This
     investment has proven to be effective, but for some of these regions they 
     are unfortunately not in a position where they can prioritize education.")
)

ui <- navbarPage(
  includeCSS("style.css"),
  title = "Education Across the Globe",
   intro,
   amans_mod_panel,
   aarons_panel,
   kennys_panel,
   conclusion
)
