# Beginning of the total effect section
MTot <- function(...) {
  args <- list(...)
  div(class = 'container',
      p("Your goal is to estimate a total effect"),
      br(),
      p("You will now be asked questions about your variables"),
      actionButton("Mtot_Prev", "Prev <"),
      actionButton("Mtot_Next", "Next >"),
      br()
  )
}

VarTot <- function(...) {
  renderUI({ source("Questions\\Variables\\Variables_TotalEffect.R", local = TRUE)$value })
}