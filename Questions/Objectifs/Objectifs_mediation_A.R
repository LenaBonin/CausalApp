function(values){
  div(class = 'container',
      h3("Plus précisément, votre objectif est-il du type:"),
      radioButtons("questionMedA1", HTML(paste("<strong>Intervenir sur la variable intermédiaire </strong>", values$Mediateur, "pour mitiger/renforcer l'effet de l'exposition", values$Expo,
                                          "sur l'outcome", values$Outcome)),
                   choices = c("Oui", "Non"),
                   selected = values$ObjMedA1),
      br(),
      htmlOutput("QMedA1"),
      radioButtons("ObjMedA1", "",
                   choices = c("Oui", "Non"),
                   selected = values$ObjMedA1),
      br(),
      htmlOutput("QMedA2"),
      radioButtons("ObjMedA2", "",
      choices = c("Oui", "Non"),
      selected = values$ObjMedA2),
      
      br(),
      htmlOutput("QMedA3"),
      radioButtons("ObjMedA3", "",
                   choices = c("Oui", "Non"),
                   selected = values$ObjMedA3),
      
      
      actionButton("MedA_Prev", "< Previous"),
      actionButton("MedA_Next", "Next >")
      
  )
}