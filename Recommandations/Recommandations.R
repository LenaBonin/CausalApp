function(values){
  fluidRow(
    h3("Recommandations"),
    br(),
    p("D'après les réponses que vous avez fournies"),
    column(12,
           wellPanel(
             h4("Estimands"),
             tableOutput("Estimands")
           )),
    
    column(12,
           wellPanel(
             h4("Décomposition"),
             htmlOutput("DecompEffet")
           )),
    
    column(12,
           wellPanel(
             h4("Méthode d'estimation"),
             htmlOutput("MethodeRecommandee")
           )),
    
    actionButton("Recommandation_Prev", "< Previous")
  )
}