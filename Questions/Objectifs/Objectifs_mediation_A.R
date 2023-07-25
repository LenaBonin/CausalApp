function(values){
  div(class = 'container',
      p("Votre objectif est-il du type:"),
      radioButtons("questionMedA1", HTML(paste("<strong>Intervenir sur la variable intermédiaire </strong>", values$Mediateur, "pour mitiger/renforcer l'effet de l'exposition", values$Expo,
                                          "sur l'outcome", values$Outcome)),
                   choices = c("Oui", "Non"),
                   selected = values$question1),
      br(),
      
      actionButton("MedA_Prev", "< Previous"),
      actionButton("MedA_Next", "Next >"),
      br()
  )
}