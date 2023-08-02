### Ce fichier contient les élément de la fonction serveur qui concernent les questions pour estimer un effet total ###

observe_events_TotalEffect <- function (input, output, session, currentPage, values){
# Bouton Prev après les Q sur le message que lon rentre dans les effets totaux
observeEvent(input$Mtot_Prev, {
  currentPage(Q1)
})

# Bouton Next après les Q sur le message que lon rentre dans les effets totaux
observeEvent(input$Mtot_Next, {
  currentPage(VarTot)
})

# Bouton Prev après les Q sur les variables
observeEvent(input$Var_Tot_Prev, {
  currentPage(MTot)
})

# Bouton Next après les Q sur les variables
observeEvent(input$Var_Tot_Next, {
  if(input$TypExpTot == "J'en ai plusieurs" & input$TypOutcomeTot == "J'en ai plusieurs"){
    shinyalert("Exposition et outcome multiples", "Vous ne pouvez avoir qu'une seule exposition et un seul outcome. Considérez faire une analyse par combinaison exposition/outcome")
  }
  else if(input$TypExpTot == "J'en ai plusieurs") shinyalert("Exposition multiple", "Vous ne pouvez avoir qu'une seule exposition. Considérez de faire une analyse par exposition. Ou, si les expositions sont séquentielles, alors vous êtes dans le cas d'une variable intermédiaire. Dans ce cas, retournez au choix de l'objectif et modifiez votre réponse")
  else if (input$TypOutcomeTot == "J'en ai plusieurs") shinyalert("Outcome multiple", "Vous ne pouvez avoir qu'un seul outcome. Considérez de faire une analyse par outcome")
  else {
    values$TypExpTot <- input$TypExpTot
    values$TypOutcomeTot <- input$TypOutcomeTot
    currentPage(ConfusionTot)
  } 
})

# Texte pour faire penser aux facteurs de confusion
output$QconfusionExpOut <- renderText({
  paste("<b> Pensez-bien à tous les facteurs de confusion potentiels entre ", ifelse(input$ExpoTot=="", "l'exposition", input$ExpoTot), "et", ifelse(input$OutTot=="", "l'outcome", input$OutTot),"</b>,
        i.e. toutes les variables qui affectent à la fois", ifelse(input$ExpoTot=="", "l'exposition", input$ExpoTot), "et", ifelse(input$OutTot=="", "l'outcome", input$OutTot),"<br> <br>")}) 


# Bouton Prev après Q sur les facteurs de confusion
observeEvent(input$Confu_Tot_Prev, {
  currentPage(VarTot)
})

# Bouton Next après Q sur les facteurs de confusion
observeEvent(input$Confu_Tot_Next, {
  if(input$ConfuTot == "Non") shinyalert("Facteurs de confusion manquant", "Rajoutez tous les facteurs de confusion sur votre DAG avant de poursuivre")
  else {
    values$ConfuTot <- input$ConfuTot
    values$ConfuNonMesureTot <- input$ConfuNonMesureTot
    currentPage(VerifDagTot)
  }
})


# Texte pour faire penser aux médiateurs
output$QMedExpOut <- renderText({
  paste("<b> Votre graphe contient-il des variables qui sont influencées par ", ifelse(input$ExpoTot=="", "l'exposition", input$ExpoTot), "et influencent elles-mêmes", ifelse(input$OutTot=="", "l'outcome", input$OutTot),"</b>,
        i.e. contient-il des médiateurs")}) 

# Texte pour faire penser aux colliders
output$QCollidExpOut <- renderText({
  paste("<b> Votre graphe contient-il des variables qui sont influencées à la fois par ", ifelse(input$ExpoTot=="", "l'exposition", input$ExpoTot), "et par", ifelse(input$OutTot=="", "l'outcome", input$OutTot),"</b>,
        i.e. contient-il des colliders")})


# Bouton Prev après Q sur les médiateurs et colliders
observeEvent(input$Verif_Tot_Prev, {
  currentPage(ConfusionTot)
})

# Bouton Next après Q sur les médiateurs et colliders
observeEvent(input$Verif_Tot_Next, {
  if (input$MedExpOutTot=="Oui" & input$CollidExpOutTot=="Oui") shinyalert("Supprimez les médiateurs et les colliders", "Les colliders ne doivent pas être inclus dans le DAG. De plus, pour estimer un effet total il n'est pas nécessaire de faire apparaître des médiateurs.\n  Vous ne devez pas inclure ces deux types de variables dans votre analyse car elles biaseraient les résultats.")
  else if(input$MedExpOutTot=="Oui") shinyalert("Supprimez les médiateurs", "Pour un effet total il n'est pas nécessaire de faire apparaître des médiateurs sur votre DAG. Vous ne devez pas les inclure dans votre analyse car ils biaseraient les résultats.")
  else if (input$CollidExpOutTot=="Oui") shinyalert("Supprimez les colliders", "Les colliders ne doivent pas être inclus dans le DAG. Vous ne devez pas les inclure dans votre analyse car ils biaseraient les résultats.")
  else{
    values$MedExpOutTot <- input$MedExpOutTot
    values$CollidExpOutTot <- input$CollidExpOutTot
    currentPage(RepeteTot)
  }
})

# Bouton Prev après Q sur les variables répétées
observeEvent(input$Repet_Tot_Prev, {
  currentPage(VerifDagTot)
})

# Bouton Next après Q sur les variables répétées
observeEvent(input$Repet_Tot_Next, {
  values$ExpRepTot <- input$ExpRepTot
  values$ConfRepTot <- input$ConfRepTot
  values$OutRepTot <- input$OutRepTot
  currentPage(PosiTot)
})

# Bouton Prev après question sur la positivité
observeEvent(input$Posi_Tot_Prev, {
  currentPage(RepeteTot)
})

# Bouton Next après question sur la positivité
observeEvent(input$Posi_Tot_Next, {
  values$QPosiTot <- input$QPosiTot
  currentPage(ResumeTot)
})


# Tableau résumé du type des variables exposition et outcome
output$VariableTypeTot <- renderTable({
    data.frame("Variable" = c("Exposition", "Outcome"),
               "Type" = c(values$TypExpTot, values$TypOutcomeTot))
})

output$ObjectifResumeTot <- renderText({
  paste("Etudier l'effet de", ifelse(input$ExpoTot=="", "l'exposition", input$ExpoTot), "sur", ifelse(input$OutTot=="", "l'outcome", input$OutTot))
})

output$ContraintesTot <- renderTable({
  ExpRepet <- ifelse(input$ExpRepTot=="Oui", "Répétée", "Non répétée")
  OutRepet <- ifelse(input$OutRepTot=="Oui", "Répété", "Non répété")
  data.frame("Critère" = c("Exposition", "Outcome", "Facteurs de confusion non mesurés", "Problème de positivité"),
             "Réponse" = c(ExpRepet, OutRepet, input$ConfuNonMesureTot, input$QPosiTot))
})

# Bouton Prev après le résumé
observeEvent(input$Resume_Tot_Prev, {
  currentPage(PosiTot)
})

}