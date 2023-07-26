function(values){
  div(class = 'container',
      h3("Votre objectif est-il du type:"),
      radioButtons("questionMedB1", HTML(paste("<strong>Intervenir sur la variable intermédiaire </strong>", values$Mediateur, "pour mitiger/renforcer l'effet de l'exposition", values$Expo,
                                               "sur l'outcome", values$Outcome)),
                   choices = c("Oui", "Non"),
                   selected = values$ObjMedB1),
      br(),
      htmlOutput("QMedB1"),
      radioButtons("ObjMedB1", "",
                   choices = c("Oui", "Non"),
                   selected = values$ObjMedB1),
      br(),
      htmlOutput("QMedB2"),
      radioButtons("ObjMedB2", "",
                   choices = c("Oui", "Non"),
                   selected = values$ObjMedB2),
      
      br(),
      htmlOutput("QMedB3"),
      radioButtons("ObjMedB3", "",
                   choices = c("Oui", "Non"),
                   selected = values$ObjMedB3),
      
      br(),
      htmlOutput("QMedB4"),
      radioButtons("ObjMedB4", "",
                   choices = c("Oui", "Non"),
                   selected = values$ObjMedB4),
      
      
      actionButton("MedB_Prev", "< Previous"),
      actionButton("MedB_Next", "Next >")
      
  )
}