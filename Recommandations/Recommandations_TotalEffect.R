function(values){
  fluidRow(
    h3("Recommandations"),
    br(),
    p("D'après les réponses que vous avez fournies"),
    column(12,
           wellPanel(
             h4("Estimands"),
             p("Effet total")
           )),
    
    
    column(12,
           wellPanel(
             h4("Méthode d'estimation"),
             htmlOutput("MethodeRecommandee_Tot")
           )),
    
    actionButton("Recommandation_Tot_Prev", "< Previous")
  )
}