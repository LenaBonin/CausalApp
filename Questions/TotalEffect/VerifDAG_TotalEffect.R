function(values){ 
  div(class = 'container',
    htmlOutput("QMedExpOut"),
    radioButtons("MedExpOutTot","",
                 choices = c("Oui", "Non"),
                 selected = values$MedExpOutTot),
    
    br(),
    htmlOutput("QCollidExpOut"),
    radioButtons("CollidExpOutTot","",
                 choices = c("Oui", "Non"),
                 selected = values$CollidExpOutTot),
      
      actionButton("Verif_Tot_Prev", "< Previous"),
      actionButton("Verif_Tot_Next", "Next >"),
      br()
  )
}
  
