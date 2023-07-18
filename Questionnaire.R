htmlOutput("page")

Qprelim <- function(...) {
  args <- list(...)
  div(class = 'container',
      p("Question préliminaire"),
      radioButtons("questionP", "Avez-vous réalisé un DAG ", choices = c("Oui", "Non")),
      br()
  )
}


Q1 <- function(...) {
  renderUI({ source("Questions//Objectifs.R", local = TRUE)$value })
}

Q2 <- function(...) {
  renderUI({source("Questions//Objectifs2.R", local = T)$value})
}

render_page <- function(...,f, title = "test_app") {
  page <- f(...)
  renderUI({
    fluidPage(page, title = title)
  })
}