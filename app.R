# https://github.com/daattali/advanced-shiny/tree/master/multiple-pages

library(shiny)
library(shinyjs)
library(shinyalert)

source("Questions\\QuestionnaireQP_Obj_UI.R")
source("Questions\\QuestionnaireTotalEffect_Variables_UI.R")


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  useShinyalert(), #Set up shinyalert (for pop ups)
  
  shinyUI(
    navbarPage( "Causal app",
                # Setting for the nav bar (colors)
                tags$style(HTML(" 
                .navbar-default .navbar-brand {color: white;}
                .navbar-default .navbar-brand:hover {color: white;}
                .navbar { background-color: #7c1444 ;}
                .navbar-default .navbar-nav > li > a {color:white;}
                .navbar-default .navbar-nav > .active > a,
                .navbar-default .navbar-nav > .active > a:focus,
                .navbar-default .navbar-nav > .active > a:hover {color: white;background-color: #9c456c;}
                .navbar-default .navbar-nav > li > a:hover {color: white ;background-color:#bc7c94; text-decoration:underline;}
                  ")), # Ou active color #923860
                
                # Tabs
                tabPanel("Accueil",
                         source("Accueil.R")$value),
                tabPanel("Questionnaire",
                         htmlOutput("page")),
                tabPanel("Ressources", source('Ressources.R')$value),
                selected = "Accueil"
    )
  )
)




# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  ## Display first block of objectif questions
  source("Questions\\QuestionnaireQP_Obj_Server.R", local = T)$value 
  source("Questions\\QuestionnaireTotalEffect_Variables_Server.R", local = T)$value 
  
}

# Run the application 
shinyApp(ui = ui, server = server)
