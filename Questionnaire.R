fluidPage(
  tags$head(tags$style(HTML("
    .shiny-text-output {
      background-color:#fff;
    }
  "))),
  
  fluidRow(column(6, offset = 3,
                  h3("Question preliminaire"),
                  radioButtons("questionP", "Avez-vous réalisé un graphe acyclique dirigé (DAG): ", 
                               choices = c("Yes", "No")),
                  actionButton("block_two", "Valider"),
                  br()
                  )
           ),
  
  br(),
  
  fluidRow(
    
    column(12,
           wellPanel(
             h3("Objectif"),
             source("Questions//Objectifs.R")
           )),
    
    column(12,
           wellPanel(
             h3("Variables")
           )),
    
    column(12,
           wellPanel(
             h3("Contraintes")
           ))
  )
)