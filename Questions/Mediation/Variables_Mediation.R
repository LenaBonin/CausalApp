function(values){
  
  div(class = 'container',
      radioButtons("TypExpMed", paste("Quelle est la nature de votre variable d'exposition", values$Expo, "? "), 
                   choices = c("J'en ai plusieurs", "Quantitative", "Binaire", "Ordinale", "Nominale"), 
                   selected = values$TypExpMed),
      
      
      br(), 
      radioButtons("TypOutcomeMed", paste("Quelle est la nature de votre outcome", values$Outcome, "?"), 
                   choices = c("J'en ai plusieurs", "Quantitative", "Binaire", "Ordinal", "Nominal", "Survie / Time-to-event"),
                   selected = values$TypOutcomeMed),
      
      br(),
      radioButtons("EffetTotVerif", "Avez-vous déjà tester l'effet total de l'exposition sur l'outcome ?", 
                   choices = c("Oui avec mes données", "Non mais cela a été fait dans la littérature", "Non"), 
                   selected = values$EffetTotVerif),
      
      br(),
      radioButtons("TypMediateurMed", paste("Quelle est la nature de votre facteur intermédiaire", values$Mediateur, "? "), 
                   choices = c("J'en ai plusieurs", "Quantitatif", "Binaire", "Ordinal", "Nominal"), 
                   selected = values$TypMediateurMed),

      br(),
      actionButton("Var_Med_Prev", "< Previous"),
      actionButton("Var_Med_Next", "Next >"),
      br()
  )
  
}