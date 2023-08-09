function(values){ 
  div(class = 'container',
      h3("Colliders"),
      htmlOutput("QCollidExpOutMediation"),
      radioButtons("CollidExpOutMediation","",
                   choices = c("Oui", "Non"),
                   selected = values$CollidExpOutMediation),
      
      br(),
      htmlOutput("QCollidMedOut"),
      radioButtons("CollidMedOut","",
                   choices = c("Oui", "Non"),
                   selected = values$CollidMedOut),
      
      actionButton("Verif_Collid_Med_Prev", "< Previous"),
      actionButton("Verif_Collid_Med_Next", "Next >"),
      br()
  )
}