# Avez-vous un DAG
Qprelim <- function() {
  div(class = 'container',
      p("Question préliminaire"),
      radioButtons("questionP", "Avez-vous réalisé un DAG ", choices = c("Oui", "Non"), selected = "Oui"),
      actionButton("block_prelim", "Next >"),
      br()
  )
}

# # Total effect or mediation
 Q1 <- "Questions\\Objectifs\\Objectifs"
 
#
# # If mediation, name of variables
 Q2 <- "Questions\\Objectifs\\Objectifs2"
 


# Function for displaying pages
 render_page <- function(page_file, title = "test_app", values) {
   page_content <- source(page_file, local = TRUE)
   fluidPage(page_content$value(values))
 }
 