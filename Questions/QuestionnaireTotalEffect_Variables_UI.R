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
  renderUI({ source("Questions\\TotalEffect\\Variables_TotalEffect.R", local = TRUE)$value })
}

ConfusionTot <- function(...) {
  renderUI({ source("Questions\\TotalEffect\\Confusion_TotalEffect.R", local = TRUE)$value })
}

VerifDagTot <- function(...) {
  renderUI({ source("Questions\\TotalEffect\\VerifDAG_TotalEffect.R", local = TRUE)$value })
}

RepeteTot <- function(...) {
  renderUI({ source("Questions\\TotalEffect\\Repetition_temp_TotalEffect.R", local = TRUE)$value })
}