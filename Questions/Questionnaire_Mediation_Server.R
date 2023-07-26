observe_events_Mediation <- function(input, output, session, currentPage, values){
  
  # Button Prev variable type mediation
  observeEvent(input$Var_Med_Prev, {
    currentPage(MedB)
  })
  

  
}