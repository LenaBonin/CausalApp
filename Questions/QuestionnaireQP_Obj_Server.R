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

}