div(class = 'container',
    htmlOutput("QMedExpOut"),
    radioButtons("MedExpOutTot","",
                 choices = c("Oui", "Non")),
    
    br(),
    htmlOutput("QCollidExpOut"),
    radioButtons("CollidExpOutTot","",
                 choices = c("Oui", "Non")),
      
      actionButton("Verif_Tot_Prev", "< Previous"),
      actionButton("Verif_Tot_Next", "Next >"),
      br()
  )
  
