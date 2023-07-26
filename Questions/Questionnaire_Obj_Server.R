## Server
observe_events_Objectifs <- function(input, output, session, currentPage, values){

# Display objective question (total effect or mediation)
observeEvent(input$block_prelim, {
  if (input$questionP == "Oui"){
    currentPage(Q1)
  }
  else{ # If no DAG, display pop up 
    shinyalert("No DAG", "This app assumed that you have already drown a DAG. If you need help with this step you can read ...", type = "error")
  }
})

# If next, display "asking variable name if mediation is selected
observeEvent(input$EndObj1Next, {
  if(input$question1=="Non" & input$question2=="Non")  shinyalert("Objectif non défini", "Il semble que votre question de recherche ne corresponde pas au cadre d'application de cette application", type = "error")
  # update slected values
  values$question1 <- input$question1
  values$question2 <- input$question2
  # Next page
  if(input$question2=="Oui") {
    currentPage(Q2)
  }
  else if(input$question1=="Oui" & input$question2=="Non"){
    currentPage(MTot)
  } 
  
})

# If previous, display Dag question again
observeEvent(input$EndObj1Prev, {
  currentPage("Qprelim")
})

# If previous on page Q2, display Q1 again
observeEvent(input$EndObj2Prev, {
  currentPage(Q1)
})

# Button Next à la fin de Q2
observeEvent(input$EndObj2Next, {
  values$Expo <- input$Expo
  values$Mediateur <- input$Mediateur
  values$Outcome <- input$Outcome
  currentPage(MedA)
})

# Button Prev after mediation A questions
observeEvent(input$MedA_Prev, {
  currentPage(Q2)
})

# Button Next after mediation A questions
observeEvent(input$MedA_Next, {
  values$ObjMedA1 <- input$ObjMedA1
  values$ObjMedA2 <- input$ObjMedA2
  values$ObjMedA3 <- input$ObjMedA3
  currentPage(MedB)
})

# Button Prev after mediation B questions
observeEvent(input$MedB_Prev, {
  currentPage(MedA)
})

# Button Next after mediation B questions
observeEvent(input$MedB_Next, {
  values$ObjMedB1 <- input$ObjMedB1
  values$ObjMedB2 <- input$ObjMedB2
  values$ObjMedB3 <- input$ObjMedB3
  values$ObjMedB4 <- input$ObjMedB4
  currentPage(TypVarMed)
})

# Expo <- reactive({ifelse(input$Expo=="", "l'exposition", input$Expo)})
# Mediateur <- reactive({ifelse(input$Mediateur=="", "le facteur intermédiaire", input$Mediateur)})
# Outcome <- reactive({ifelse(input$Outcome=="", "l'outcome", input$Outcome)})

# Texte questions médiation A
output$QMedA1 <- renderText({
  paste("<b> Quel est l’effet de",  ifelse(input$Expo=="", "l'exposition", input$Expo),
        "sur", ifelse(input$Outcome=="", "l'outcome", input$Outcome),
        "après la mise en place d’une intervention/politique qui affecte",
        ifelse(input$Mediateur=="", "le facteur intermédiaire", input$Mediateur), "? </b")
})

output$QMedA2 <- renderText({
  paste("<b> Quel serait l’effet de ",  ifelse(input$Expo=="", "l'exposition", input$Expo),
        "sur", ifelse(input$Outcome=="", "l'outcome", input$Outcome),
        "si on supprimait complètement",
        ifelse(input$Mediateur=="", "le facteur intermédiaire", input$Mediateur), "? </b")
})

output$QMedA3 <- renderText({
  paste("<b> Quel est la part de l’effet de  ",  ifelse(input$Expo=="", "l'exposition", input$Expo),
        "sur", ifelse(input$Outcome=="", "l'outcome", input$Outcome),
        "qui pourrait être éliminée en supprimant",
        ifelse(input$Mediateur=="", "le facteur intermédiaire", input$Mediateur),
        "pour tous les individus ? </b")
})

# Texte questions mediation B
output$QMedB1 <- renderText({
  paste("<b> Quel est l’effet de ",  ifelse(input$Expo=="", "l'exposition", input$Expo),
        "qui passe par ", ifelse(input$Mediateur=="", "le facteur intermédiaire", input$Mediateur),
        "sur", ifelse(input$Outcome=="", "l'outcome", input$Outcome), "? </b")
})

output$QMedB2 <- renderText({
  paste("<b> Quel est l’effet de ",  ifelse(input$Expo=="", "l'exposition", input$Expo),
        "qui ne passe pas par ", ifelse(input$Mediateur=="", "le facteur intermédiaire", input$Mediateur),
        "sur", ifelse(input$Outcome=="", "l'outcome", input$Outcome), "? </b")
})

output$QMedB3 <- renderText({
  paste("<b> Quel serait l’effet de ",  ifelse(input$Expo=="", "l'exposition", input$Expo),
        "sur", ifelse(input$Outcome=="", "l'outcome", input$Outcome),
        "si tous les individus avaient" ,ifelse(input$Mediateur=="", "le facteur intermédiaire", input$Mediateur),
        "d'une catégorie de ", ifelse(input$Expo=="", "l'exposition", input$Expo), "fixée ? </b")
})

output$QMedB4 <- renderText({
  paste("<b> Quel part de l’effet de  ",  ifelse(input$Expo=="", "l'exposition", input$Expo),
        "sur", ifelse(input$Outcome=="", "l'outcome", input$Outcome),
        "est due à l'effet de ", ifelse(input$Expo=="", "l'exposition", input$Expo), "sur",
        ifelse(input$Mediateur=="", "le facteur intermédiaire", input$Mediateur), "? </b")
})



}