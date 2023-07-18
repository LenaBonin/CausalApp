isolate(
  
  div(class = 'container',
      radioButtons("TypExpTot", "Quelle est la nature de votre variable d'exposition ? ", 
                   choices = c("Quantitative", "Binaire", "Ordinale", "Nominale")),
      br(),
      textAreaInput(
        inputId = "ExpoTot",
        label = "Quel est le nom de cette variable ?",
        value = "",
        width = '100%',
        height = '1000%',
        placeholder = "La classe sociale"
      ),
      
      br(), 
      radioButtons("TypOutcomeTot", "Quelle est la nature de votre outcome ?", 
                   choices = c("Quantitative", "Binaire", "Ordinale", "Nominale", "Survie / Time-to-event")),
      br(),
      textAreaInput(
        inputId = "ExpoTot",
        label = "Quel est le nom de cette variable ?",
        value = "",
        width = '100%',
        height = '1000%',
        placeholder = "La mortalité"
      ),
      br(),
      actionButton("Var_Tot_Prev", "< Previous"),
      actionButton("Var_Tot_Next", "Next >"),
      br()
  )
  
)