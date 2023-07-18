## Server

# Display preliminary question
output$page <- render_page(f=Qprelim)

# Display objective question (total effect or mediation)
observeEvent(input$block_prelim, {
  if (input$questionP == "Oui"){
    output$page <- render_page(f=Q1)
  }
})

# If next, display "asking variable name if mediation is selected
observeEvent(input$EndObj1Next, {
  if(input$question2=="Oui") output$page <- render_page(f=Q2)
})

# If previous, display Dag question again
observeEvent(input$EndObj1Prev, {
  output$page <- render_page(f=Qprelim)
})

# If previous on page Q2, display Q1 again
observeEvent(input$EndObj2Prev, {
  output$page <- render_page(f=Q1)
})