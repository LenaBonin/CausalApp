div(class = 'container',
        p("Votre objectif est-il du type:"),
        radioButtons("question1", "Quelle est l'effet du revenu sur la mortalité? ", choices = c("Oui", "Non")),
        br(),
    
    radioButtons("question2", "Please select a number: ", choices = c(10,20,30)),
    actionButton("block_two", "Next"),
    br()
    )
