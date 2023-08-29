function(values){
  div(class = 'container',
      h3("Facteurs de confusion"),
      htmlOutput("QconfusionExpOut"),
      radioButtons("ConfuTot","Apparraissent-ils tous sur votre DAG ?",
                  choices = c("Oui", "Non"),
                  selected = values$ConfuTot),

      br(),
      radioButtons("ConfuNonMesureTot","Certains de ces facteurs sont-ils non mesurés dans vos données ?",
                  choices = c("Oui", "Non"),
                  selected = values$ConfuNonMesureTot),
    
      br(),
      actionButton("Confu_Tot_Prev", "< Previous"),
      actionButton("Confu_Tot_Next", "Next >"),
      br()
  )
}