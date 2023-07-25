
library(shiny)
library(shinyjs)
library(shinyalert)

source("Questions\\QuestionnaireQP_Obj_UI.R")
source("Questions\\QuestionnaireTotalEffect_Variables_UI.R")




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
                         uiOutput("page")),
                tabPanel("Ressources", source('Ressources.R')$value),
                selected = "Accueil"
    )
  )
)




# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  currentPage <- reactiveVal("Qprelim")
  
  values <- reactiveValues(question1 = NULL, question2 = NULL,
                           TypExpTot = NULL, TypOutcomeTot = NULL,
                           ConfuTot = NULL, ConfuNonMesureTot = NULL,
                           MedExpOutTot = NULL, CollidExpOutTot = NULL,
                           ExpRepTot = NULL, ConfRepTot = NULL,
                           QPosiTot = NULL)
  
  output$page <- renderUI({
    current_page <- currentPage()
    if (current_page == "Qprelim") {
      Qprelim()
    } else {
      render_page(paste0(current_page, ".R"), values = values)
    }
  })
  
  ## Display first block of objectif questions
  source("Questions\\QuestionnaireQP_Obj_Server.R", local = T)
  observe_events_Objectifs(input, output, session, currentPage, values)
  source("Questions\\QuestionnaireTotalEffect_Variables_Server.R", local = T)$value 
  observe_events_Variables_TotalEffect(input, output, session, currentPage, values)
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)

