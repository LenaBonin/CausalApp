## Server

output$page <- render_page(f=Qprelim)
observeEvent(input$block_prelim, {
  output$page <- render_page(f=Q1)
})

observeEvent(input$EndObj1, {
  output$page <- render_page(f=Q2)
})