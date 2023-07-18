observeEvent(input$Mtot_Prev, {
  output$page <- render_page(f=Q1)
})

observeEvent(input$Mtot_Next, {
  output$page <- render_page(f=VarTot)
})

observeEvent(input$Var_Tot_Prev, {
  output$page <- render_page(f=MTot)
})