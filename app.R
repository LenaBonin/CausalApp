#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  shinyUI(
    navbarPage( "Causal app",
                tags$style(HTML(" 
        .navbar-default .navbar-brand {color: white;}
        .navbar-default .navbar-brand:hover {color: white;}
        .navbar { background-color: #399DFC ;}
        .navbar-default .navbar-nav > li > a {color:black;}
        .navbar-default .navbar-nav > .active > a,
        .navbar-default .navbar-nav > .active > a:focus,
        .navbar-default .navbar-nav > .active > a:hover {color: white;background-color: #0184DE;}
        .navbar-default .navbar-nav > li > a:hover {color: black;background-color:#33AEFE; text-decoration:underline;}
                  ")),
                
                tabPanel("Accueil",
                         source("Accueil.R")$value),
                tabPanel("Questionnaire",
                         source("Questionnaire.R")$value),
                tabPanel("Ressources", source('Ressources.R')$value),
                selected = "Accueil"
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    
}

# Run the application 
shinyApp(ui = ui, server = server)
