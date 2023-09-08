function(values){
  
  div(class = 'container',
      h3("Type des variables"),
      radioButtons("TypExpMed", paste("Quelle est la nature de votre variable d'exposition", values$Expo, "? "), 
                   choices = c("Quantitative", "Binaire", "Ordinale", "Nominale", "J'en ai plusieurs"), 
                   selected = values$TypExpMed),
      
      
      br(), 
      radioButtons("TypOutcomeMed", paste("Quelle est la nature de votre outcome", values$Outcome, "?"), 
                   choices = c("Quantitatif", "Binaire", "Ordinal", "Nominal", "Survie / Time-to-event", "J'en ai plusieurs"),
                   selected = values$TypOutcomeMed),
      
      br(),
      conditionalPanel(
        condition = "input.TypOutcomeMed == 'Binaire' | input.TypOutcomeMed=='Survie / Time-to-event'",
        div(
          class = "additional-question",
          radioButtons("RareOutcome","Votre outcome est-il rare (moins de 10%) ?",
                       choices = c("Oui", "Non"),
                       selected = values$RareOutcome)
        )
      ),
      
      br(),
      radioButtons("EffetTotVerif", "Avez-vous déjà tester l'effet total de l'exposition sur l'outcome ?", 
                   choices = c("Oui avec mes données", "Non mais cela a été fait dans la littérature", "Non"), 
                   selected = values$EffetTotVerif),
      
      br(),
      radioButtons("TypMediateurMed", paste("Quelle est la nature de votre facteur intermédiaire", values$Mediateur, "? "), 
                   choices = c("Quantitatif", "Binaire", "Ordinal", "Nominal", "J'en ai plusieurs"), 
                   selected = values$TypMediateurMed),

      br(),
      actionButton("Var_Med_Prev", "< Previous"),
      actionButton("Var_Med_Next", "Next >"),
      br()
  )
  
}