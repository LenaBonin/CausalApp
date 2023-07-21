div(class = 'container',
    htmlOutput("QconfusionExpOut"),
    radioButtons("ConfuTot","Apparraissent-ils tous sur votre DAG ?",
                 choices = c("Oui", "Non")),

    br(),
    radioButtons("ConfuNonMesureTot","Certains de ces facteurs sont-ils non mesurés dans vos données ?",
                 choices = c("Oui", "Non")),
    
    br(),
    actionButton("Var_Tot_Prev", "< Previous"),
    actionButton("Var_Tot_Next", "Next >"),
    br()
)
