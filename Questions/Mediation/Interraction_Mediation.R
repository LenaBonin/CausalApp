function(values){ 
  div(class = 'container',
      h3("Interraction entre l'exposition et le médiateur"),
      htmlOutput("QInterractionExpMed"),
      radioButtons("InterractionExpMed","",
                   choices = c("Oui", "Non"),
                   selected = values$InterractionExpMed),
      
      br(),
      conditionalPanel(
        condition = "input.InterractionExpMed == 'Non'",
        div(
          class = "additional-question",
          radioButtons("InterractionDirIndir", "Si cette interraction existe, souhaitez-vous qu'elle soit prise en compte dans l'effet ",
                       choices = c("Direct", "Indirect"),
                       selected = values$InterractionDirIndir)
        )
      ),
      
      
      actionButton("Interraction_Med_Prev", "< Previous"),
      actionButton("Interraction_Med_Next", "Next >"),
      br()
  )
}