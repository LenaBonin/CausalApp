fluidPage(
  tags$head(tags$style(HTML("
    .shiny-text-output {
      background-color:#fff;
    }
  "))),
  
  fluidRow(column(6, offset = 3,
                  h3("Question preliminaire"),
                  radioButtons("questionP", "Avez-vous réalisé un graphe acyclique dirigé (DAG): ", 
                               choices = c("Oui", "Non")),
                  actionButton("block_prelim", "Valider"),
                  br()
                  )
           ),
  
  br(),
  
  fluidRow(
    
    column(12,
           wellPanel(
             h3("Objectif"),
             #source("Questions//Objectifs.R")$value
             uiOutput("Objectif1"),
             uiOutput("Objectif2")
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

