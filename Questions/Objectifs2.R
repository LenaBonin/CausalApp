#if(input$question2=="Oui"){
  div(class = 'container',
      textAreaInput(
        inputId = "Expo",
        label = "Par quelle variable souhaitez-vous remplacer 'la classe sociale', i.e, quelle est votre variable d'exposition ?",
        value = "",
        width = '100%',
        height = '1000%',
        placeholder = "Le niveau d'éducation"
      ),
      
      textAreaInput(
        inputId = "Mediateur",
        label = "Par quelle variable souhaitez-vous remplacer 'le tabac', i.e, quelle est votre variable intermédiaire ?",
        value = "",
        width = '100%',
        height = '1000%',
        placeholder = "Le revenu"
      ),
      
      textAreaInput(
        inputId = "Outcome",
        label = "Par quelle variable souhaitez-vous remplacer 'la mortalité', i.e, quelle est votre variable d'intérêt/ outcome ?",
        value = "",
        width = '100%',
        height = '1000%',
        placeholder = "Le risque de cancer"
      ),
      br(),
      actionButton("EndObj2Prev", "< Previous"),
      actionButton("EndObj2Next", "Next >"),
      br()
  )
      
#}