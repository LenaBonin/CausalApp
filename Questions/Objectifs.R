isolate(if(input$questionP=="Oui"){

div(class = 'container',
        p("Votre objectif est-il du type:"),
        radioButtons("question1", "Quelle est l'effet de la classe sociale sur la mortalité ? ", choices = c("Oui", "Non")),
        br(),
    
    
    radioButtons("question2", "Quel est le rôle du tabac comme variable intermédiaire entre la classe sociale et la mortalité ?", 
                 choices = c("Oui", "Non")),
    actionButton("EndObj1", "Next"),
    br()
    )
}
)
