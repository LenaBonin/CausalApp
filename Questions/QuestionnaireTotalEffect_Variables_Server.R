observeEvent(input$Mtot_Prev, {
  output$page <- render_page(f=Q1)
})

observeEvent(input$Mtot_Next, {
  output$page <- render_page(f=VarTot)
})

observeEvent(input$Var_Tot_Prev, {
  output$page <- render_page(f=MTot)
})

observeEvent(input$Var_Tot_Next, {
  if(input$TypExpTot == "J'en ai plusieurs" & input$TypOutcomeTot == "J'en ai plusieurs"){
    shinyalert("Exposition et outcome multiples", "Vous ne pouvez avoir qu'une seule exposition et un seul outcome. Considérez faire une analyse par combinaison exposition/outcome")
  }
  else if(input$TypExpTot == "J'en ai plusieurs") shinyalert("Exposition multiple", "Vous ne pouvez avoir qu'une seule exposition. Considérez de faire une analyse par exposition. Ou, si les expositions sont séquentielles, alors vous êtes dans le cas d'une variable intermédiaire. Dans ce cas, retournez au choix de l'objectif et modifiez votre réponse")
  else if (input$TypOutcomeTot == "J'en ai plusieurs") shinyalert("Outcome multiple", "Vous ne pouvez avoir qu'un seul outcome. Considérez de faire une analyse par outcome")
  else output$page <- render_page(f=ConfusionTot)
})

# Texte pour faire penser aux facteurs de confusion
output$QconfusionExpOut <- renderText({
  paste("<b> Pensez-bien à tous les facteurs de confusion potentiels entre ", input$ExpoTot, "et", input$OutTot,"</b>,
        i.e. toutes les variables qui affectent à la fois", input$ExpoTot, "et", input$OutTot,"<br> <br>")}) 
