function(values){div(class = 'container',
                     h3("Facteurs de confusion"),
                     htmlOutput("QconfusionExpOutMed"),
                     radioButtons("ConfuExpOutMed","Apparraissent-ils tous sur votre DAG ?",
                                  choices = c("Oui", "Non"),
                                  selected = values$ConfuExpOutMed),
                     
                     br(),
                     
                     
                     htmlOutput("QconfusionMedOutMed"),
                     radioButtons("ConfuMedOutMed","Apparraissent-ils tous sur votre DAG ?",
                                  choices = c("Oui", "Non"),
                                  selected = values$ConfuMedOutMed),
                     
                     br(),
                     
                     radioButtons("ConfuNonMesureMed","Certains de ces facteurs sont-ils non mesurés dans vos données ?",
                                  choices = c("Oui", "Non"),
                                  selected = values$ConfuNonMesureMed),
                     
                     
                     
                     br(),
                     actionButton("Confu_Med_Prev", "< Previous"),
                     actionButton("Confu_Med_CDE_Next", "Next >"),
                     br()
)
}