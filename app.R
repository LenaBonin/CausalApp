# https://github.com/daattali/advanced-shiny/tree/master/multiple-pages

library(shiny)
library(shinyjs)


# Define UI for application that draws a histogram
ui <- fluidPage(
  
  shinyUI(
    navbarPage( "Causal app",
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
                
                tabPanel("Accueil",
                         source("Accueil.R")$value),
                tabPanel("Questionnaire",
                         htmlOutput("page")),
                tabPanel("Ressources", source('Ressources.R')$value),
                selected = "Accueil"
    )
  )
)

Qprelim <- function(...) {
  args <- list(...)
  div(class = 'container',
      p("Question préliminaire"),
      radioButtons("questionP", "Avez-vous réalisé un DAG ", choices = c("Oui", "Non")),
      actionButton("block_prelim", "Next >"),
      br()
  )
}

Q1 <- function(...) {
  renderUI({ source("Questions\\Objectifs.R", local = TRUE)$value })
}

Q2 <- function(...) {
  renderUI({source("Questions\\Objectifs2.R", local = T)$value})
}


render_page <- function(...,f, title = "test_app") {
  page <- f(...)
  renderUI({
    fluidPage(page, title = title)
  })
}


# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
  ## Display first block of objectif questions
  #source("Questions\\QuestionnaireServer.R", local = T)$value 
  
  # Display preliminary question
  output$page <- render_page(f=Qprelim)
  
  # Display objective question (total effect or mediation)
  observeEvent(input$block_prelim, {
    if (input$questionP == "Oui"){
    output$page <- render_page(f=Q1)
    }
  })

  observeEvent(input$EndObj1Next, {
    if(input$question2=="Oui") output$page <- render_page(f=Q2)
  })

  observeEvent(input$EndObj1Prev, {
    output$page <- render_page(f=Qprelim)
  })
  
  observeEvent(input$EndObj2Prev, {
    output$page <- render_page(f=Q1)
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
