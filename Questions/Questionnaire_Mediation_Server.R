observe_events_Mediation <- function(input, output, session, currentPage, values){
  
  # Button Prev variable type mediation
  observeEvent(input$Var_Med_Prev, {
    currentPage(MedB)
  })
  
  # Button Next variable type mediation
  observeEvent(input$Var_Med_Next, {
    if(input$TypExpMed == "J'en ai plusieurs" & input$TypOutcomeMed == "J'en ai plusieurs"){
      shinyalert("Exposition et outcome multiples", "Vous ne pouvez avoir qu'une seule exposition et un seul outcome. Considérez faire une analyse par combinaison exposition/outcome")
    }
    else if(input$TypExpMed == "J'en ai plusieurs") shinyalert("Exposition multiple", "Vous ne pouvez avoir qu'une seule exposition. Considérez de faire une analyse par exposition. Ou, si les expositions sont séquentielles, alors vous êtes dans le cas d'une variable intermédiaire. Dans ce cas, retournez au choix de l'objectif et modifiez votre réponse")
    else if (input$TypOutcomeMed == "J'en ai plusieurs") shinyalert("Outcome multiple", "Vous ne pouvez avoir qu'un seul outcome. Considérez de faire une analyse par outcome")
    else if (input$EffetTotVerif=="Non") shinyalert("Effet total non vérifié", "Avant de commencer une analyse de médiation, vérifier dans un premier temps qu'il y a bien un effet total.
                                                    \n Retournez en arrière à la question de la définition de votre objectif et sélectionnez uniquement l'effet de la classe sociale sur la mortalité.")
    else if (input$TypMediateurMed == "J'en ai plusieurs") shinyalert("Plusieurs médiateurs", "Pour le moment le cas de plusieurs médiateurs n'est pas géré par cette application") # A enlever quand on pourra le gérer
    else {
      values$TypExpMed <- input$TypExpMed
      values$TypMediateurMed <- input$TypMediateurMed
      values$TypOutcomeMed <- input$TypOutcomeMed
      currentPage(RepeteMed)
    } 
  })
  
  #Button Prev après questions sur la répétition
  observeEvent(input$Repet_Med_Prev, {
    currentPage(TypVarMed)
  })
  
  #Button Next après questions sur la répétition
  observeEvent(input$Repet_Med_Next, {
    values$ExpRepMed <- input$ExpRepMed
    values$MediateurRepMed <- input$ConfRepMed
    values$OutRepMed <- input$OutRepMed
    currentPage(ConfuMed)
  })
  
  #Button Prev après questions sur la confusion
  observeEvent(input$Confu_Med_Prev, {
    currentPage(RepeteMed)
  })
  
  
  # observeEvent(input$question1_response, {
  #   values$ConfuInfluence<- input$ConfuInfluence
  #   
  #   # Vérifier si la réponse est "Oui"
  #   if (input$ConfuInfluence == "Oui") {
  #     # Afficher la question supplémentaire en utilisant renderUI
  #     output$QcondTemporalite <- renderUI({
  #       # Code HTML pour la question supplémentaire
  #       p(paste("Le temps entre l'observation de l'exposition et celle du médiateur est-il très court?"))
  #       radioButtons("additional_question_response", "",
  #                    choices = c("Oui", "Non"))
  #     })
  #   } else {
  #     # Masquer la question supplémentaire si la réponse n'est pas "Oui"
  #     output$QcondTemporalite <- renderUI(NULL)
  #   }
  # })
  
  #Button Next après questions sur la confusion
  observeEvent(input$Confu_Med_Next, {
    if(input$ConfuExpOutMed=="Non" | input$ConfuExpMedMed=="Non" | input$ConfuMedOutMed=="Non"){
      shinyalert("Facteurs de confusion manquant", "Vous devez faire apparaître tous les facteurs de confusion des trois relations
                 exposition/outcome, exposition/médiateur, médiateur/outcome sur votre DAG. \n
                 Rajoutez-les avant de poursuivre.")
    }
    else{
      values$ConfuExpOutMed = input$ConfuExpOutMed
      values$ConfuExpMedMed = input$ConfuExpMedMed
      values$ConfuMedOutMed = input$ConfuMedOutMed
      values$ConfuNonMesureMed= input$ConfuNonMesureMed
      values$ConfuInfluence = input$ConfuInfluence
      values$ShortTime = input$ShortTime
      values$values$add_hyp_cond = input$add_hyp_cond
      currentPage(CollidMed)
    }
  })
  
  #Button Prev après questions sur les colliders
  observeEvent(input$Verif_Collid_Med_Prev, {
    currentPage(ConfuMed)
  })
  
  #Button Next après questions sur les colliders
  observeEvent(input$Verif_Collid_Med_Next, {
    if(input$CollidExpOutMediation=="Oui" | input$CollidMedOut=="Oui"){
      shinyalert("Supprimez les colliders", "Les colliders ne doivent pas être inclus dans le DAG. Vous ne devez pas les inclure dans votre analyse car ils biaseraient les résultats.")
    }
    else{
      values$CollidExpOutMediation = input$CollidExpOutMediation
      values$CollidMedOut = input$CollidMedOut
      currentPage(InterractionMed)
    }
  })
  
  #Button Prev après questions sur l'interraction
  observeEvent(input$Interraction_Med_Prev, {
    currentPage(CollidMed)
  })
  
  
  ### Texte questions confusion ###

  output$QconfusionExpOutMed <- renderText({
    paste("<b> Pensez-bien à tous les facteurs de confusion potentiels entre ", ifelse(input$Expo=="", "l'exposition", input$Expo), "et", ifelse(input$Outcome=="", "l'outcome", input$Outcome),"</b>,
        i.e. toutes les variables qui affectent à la fois", ifelse(input$Expo=="", "l'exposition", input$Expo), "et", ifelse(input$Outcome=="", "l'outcome", input$Outcome),"<br>")}) 
  
  output$QconfusionExpMedMed <- renderText({
    paste("<b> Pensez-bien à tous les facteurs de confusion potentiels entre ", ifelse(input$Expo=="", "l'exposition", input$Expo), "et", ifelse(input$Mediateur=="", "le médiateur", input$Mediateur),"</b>,
        i.e. toutes les variables qui affectent à la fois", ifelse(input$Expo=="", "l'exposition", input$Expo), "et", ifelse(input$Mediateur=="", "le facteur intermédiaire", input$Mediateur),"<br>")}) 
  
  output$QconfusionMedOutMed <- renderText({
    paste("<b> Pensez-bien à tous les facteurs de confusion potentiels entre
    ", ifelse(input$Mediateur=="", "le médiateur", input$Mediateur), "et", ifelse(input$Outcome=="", "l'outcome", input$Outcome),"</b>,
        i.e. toutes les variables qui affectent à la fois", ifelse(input$Mediateur=="", "le facteur intermédiaire", input$Mediateur), "et", ifelse(input$Outcome=="", "l'outcome", input$Outcome),"<br>")}) 
  
  output$ConfuInfluence <- renderText({
    paste("<b> Au moins un des facteurs de confusion entre ", ifelse(input$Mediateur=="", "le médiateur", input$Mediateur), "et", ifelse(input$Outcome=="", "l'outcome", input$Outcome),
    "est-il influencé par", ifelse(input$Expo=="", "l'exposition", input$Expo),"</b>")}) 
  
  ### Texte pour faire penser aux colliders ###
  output$QCollidExpOutMediation <- renderText({
    paste("<b> Votre graphe contient-il des variables qui sont influencées à la fois par ", ifelse(input$Expo=="", "l'exposition", input$Expo), "et par", ifelse(input$Outcome=="", "l'outcome", input$Outcome),"</b>,
        i.e. contient-il des colliders entre l'exposition et l'outcome")})
  
  output$QCollidMedOut <- renderText({
    paste("<b> Votre graphe contient-il des variables qui sont influencées à la fois par ", ifelse(input$Mediateur=="", "le facteur intermédiaire", input$Mediateur), "et par", ifelse(input$Outcome=="", "l'outcome", input$Outcome),"</b>,
        i.e. contient-il des colliders entre le médiateur et l'outcome")})
  
  ### Texte pour le terme d'interraction ###
  output$QInterractionExpMed <- renderText({
    paste("<b> Souhaitez-vous isoler l'éventuelle interraction entre ", ifelse(input$Expo=="", "l'exposition", input$Expo), "et par", ifelse(input$Mediateur=="", "le facteur intermédiaire", input$Mediateur),"</b>,
        i.e. s'il y a une interraction entre l'exposition et le médiateur, souhaitez-vous la faire ressortir dans un terme à part ?")})
  
}