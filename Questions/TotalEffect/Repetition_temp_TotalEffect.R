div(class = 'container',
    radioButtons("ExpRepTot","Votre exposition est-elle répétée dans le temps ?",
                 choices = c("Oui", "Non")),
    
    br(),
    radioButtons("ConfRepTot","Au moins un de vos facteurs de confusion est-il répéé dans le temps ?",
                 choices = c("Oui", "Non")),
    
    actionButton("Repet_Tot_Prev", "< Previous"),
    actionButton("Repet_Tot_Next", "Next >"),
    br()
)
