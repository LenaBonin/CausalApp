observe_events_Recommandations_Tot <- function(input, output, session, currentPage, values){
  
  #Button Prev après les recommandations
  observeEvent(input$Recommandation_Tot_Prev, {
    currentPage(ResumeTot)
  })
  
  
  ###### PArtie Méthode ######
  output$MethodeRecommandee_Tot <- renderUI({
    print(c(input$ExpRepTot, input$OutRepTot))
    if((input$ExpRepTot == "Non" | (input$ExpRepTot=="Oui" & input$ConfRepTot=="Non")) & input$OutRepTot=="Non"){
      Method <- "Regressions"
    }
    else if(input$OutRepTot=="Non"){
      Method <- "G-méthodes"
    }
    else(
      Method <- "Modèles mixtes (Modèles à effets aléatoires) ou G-méthodes"
    )
    
    # Probleme de non positivité évidente
    if(input$QPosiTot=="Oui"){
      Method <- paste(Method,
                      "<br> <br> L'hypothèse de positivité nécéssaire à l'analyse causale est violée, <b> vos résultats seront donc probablement biaisés </b>. <br>
                      Nous recommandons, si vous souhaitez tout de même faire l'analyse de faire de la <b> g-computation </b>, mais vous devrez rester très prudent dans l'interprétation des résultats")
    }
    HTML(Method)
  })
  
}