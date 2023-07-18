# Avez-vous un DAG
Qprelim <- function(...) {
  args <- list(...)
  div(class = 'container',
      p("Question préliminaire"),
      radioButtons("questionP", "Avez-vous réalisé un DAG ", choices = c("Oui", "Non")),
      actionButton("block_prelim", "Next >"),
      br()
  )
}

# Total effect or mediation
Q1 <- function(...) {
  renderUI({ source("Questions\\Objectifs\\Objectifs.R", local = TRUE)$value })
}

# If mediation, name of variables
Q2 <- function(...) {
  renderUI({source("Questions\\Objectifs\\Objectifs2.R", local = T)$value})
}


# Function for displaying pages
render_page <- function(...,f, title = "test_app") {
  page <- f(...)
  renderUI({
    fluidPage(page, title = title)
  })
}