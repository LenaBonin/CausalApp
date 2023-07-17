## Server
observeEvent(input$block_prelim, {
  output$Objectif1 <- renderUI({source("Questions//Objectifs.R", local = T)$value})
})

observeEvent(input$EndObj1, {
  output$Objectif2 <- renderUI({source("Questions//Objectifs2.R", local = T)$value})
})