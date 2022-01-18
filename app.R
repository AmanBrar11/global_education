library(shiny)
library(plotly)
library(lintr)
library(styler)

source("my_server.R")
source("my_ui.R")

shinyApp(ui = ui, server = server)
