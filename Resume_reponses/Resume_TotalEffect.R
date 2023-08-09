function(values){
fluidRow(
  h3("Veuillez vérifier que les informations fournies sont exactes"),
  column(12,
         wellPanel(
           h4("Objectif"),
           textOutput("ObjectifResumeTot")
         )),
  
  column(12,
         wellPanel(
           h4("Variables"),
           tableOutput("VariableTypeTot")
         )),
  
  column(12,
         wellPanel(
           h4("Contraintes"),
           tableOutput("ContraintesTot")
         )),
  
  actionButton("Resume_Tot_Prev", "< Previous"),
  actionButton("Valider_Tot", "Valider")
)
}

