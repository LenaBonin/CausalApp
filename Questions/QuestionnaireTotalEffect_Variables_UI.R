# Beginning of the total effect section

MTotal <- function(...) {
  renderUI({ source("Questions\\TotalEffect\\Variables.R", local = TRUE)$value })
}