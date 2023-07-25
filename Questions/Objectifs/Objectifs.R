function(values){
div(class = 'container',
        p("Votre objectif est-il du type:"),
        radioButtons("question1", "Quelle est l'effet de la classe sociale sur la mortalité ? ",
                     choices = c("Oui", "Non"),
                     selected = values$question1),
        br(),
    
    
    radioButtons("question2", "Quel est le rôle du tabac comme variable intermédiaire entre la classe sociale et la mortalité ?", 
                 choices = c("Oui", "Non"), 
                 selected = values$question2),
    br(),
    actionButton("EndObj1Prev", "< Previous"),
    actionButton("EndObj1Next", "Next >"),
    br()
    )
}

