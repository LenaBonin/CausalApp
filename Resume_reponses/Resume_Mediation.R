function(values){
  fluidRow(
    h3("Veuillez vérifier que les informations fournies sont exactes"),
    column(12,
           wellPanel(
             h4("Objectif"),
             htmlOutput("ObjectifResumeMed")
           )),
    
    column(12,
           wellPanel(
             h4("Variables"),
             tableOutput("VariableTypeMed")
           )),
    
    column(12,
           wellPanel(
             h4("Contraintes"),
             h5("Variables"),
             tableOutput("ContraintesMed"),
             br(),
             h5("Facteurs de confusion"),
             tableOutput("ContraintesMed2")
           )),
    
    column(12,
           wellPanel(
             h4("Interaction entre l'exposition et le médiateur"),
             tableOutput("InteractionMed")
           )),
    
    actionButton("Resume_Med_Prev", "< Previous"),
    actionButton("Valider_Med", "Valider")
  )
}