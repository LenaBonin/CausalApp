observe_events_Recommandations <- function(input, output, session, currentPage, values){
  
  #Button Prev après les recommandations
  observeEvent(input$Recommandation_Prev, {
    currentPage(ResumeMed)
  })
  
  # Quantités à estimer
  Estimands <- reactive({
    TotalEffect <- !is.null(values$question1) & values$question1=="Oui"
    
    CDE <- !is.null(input$question2) & (!is.null(input$ObjMedA1) | !is.null(input$ObjMedA2))&
      values$question2=="Oui" & (values$ObjMedA1 == "Oui" | values$ObjMedA2=="Oui")
    
    PropEliminated <- !is.null(values$question2) & !is.null(values$ObjMedA3) & values$question2=="Oui" & values$ObjMedA3=="Oui"
    
    NDE <- !is.null(values$question2) & (!is.null(values$ObjMedB1) | !is.null(values$ObjMedB3))&
      values$question2=="Oui" & (values$ObjMedB1 == "Oui" | values$ObjMedB3=="Oui")
    
    NIE <- !is.null(values$question2) & !is.null(values$ObjMedB2) & values$question2=="Oui" & values$ObjMedB2=="Oui"
    
    PropMediated <- !is.null(values$question2) & !is.null(values$ObjMedB4) & values$question2=="Oui" & values$ObjMedB4=="Oui"
    
    if(input$InterractionExpMed=="Oui" & (NDE==T | NIE==T)){
      if(NDE==T){
        PNDE <- T
        TNDE <- F
      }
      else {
        PNDE <- F
        TNDE <- F
      }
      if(NIE==T){
        PNIE <- T
        TNIE <- F
      }
      else {
        PNIE <- F
        TNIE <- F
      }
    }
    else if(input$InterractionExpMed=="Non" & (NDE==T | NIE==T)){
      if(input$InterractionDirIndir=="Direct"){
        if(NDE==T){
          TNDE <- T
          PNDE <- F
        }
        else{TNDE <- PNDE <- F}
        if(NIE==T){
          PNIE <- T
          TNIE <- F
        }
        else{PNIE <- TNIE <- F}
      }
      else{ # input$InterractionDirIndir ="Indirect"
        if(NDE==T){
          PNDE <- T
          TNDE <- F
        }
        else{TNDE <- PNDE <- F}
        if(NIE==T){
          TNIE <- T
          PNIE <- F
        }
        else{PNIE <- TNIE <- F}
      }
    }
    else{PNDE <- TNDE <- PNIE <- TNIE <- F}
    
    
    Estimands <- data.frame(
      Effet = c("Effet total", "Effet direct controlé", "Proportion éliminée", "Effet naturel direct pur", "Effet naturel direct total",
                "Effet naturel indirect pur", "Effet naturel indirect total", "Proportion médiée"),
      Abbreviation = c("TE", "CDE", "PropEliminated", "PNDE", "TNDE", "PNIE", "TNIE", "PropMediated"),
      Estimation = c(TotalEffect, CDE, PropEliminated, PNDE, TNDE, PNIE, TNIE, PropMediated)
    ) 
    
  })
  
  output$Estimands <- renderTable({
    
    Estimands()%>% 
      dplyr::filter(Estimation==T) %>% 
      dplyr::select((-Estimation))
 })
  
  ###### PArtie Décomposition #######
  output$DecompEffet <- renderUI({
    Estimands <- Estimands() %>% 
      dplyr::filter(Estimation==T)
    
    AEstimer <- as.vector(Estimands$Abbreviation)
    print(AEstimer)
    
    if("TNIE" %in% AEstimer | "TNDE" %in% AEstimer)
      Decomp <- HTML("2-way decomposition")
    else if("PNDE"%in%AEstimer & "PNIE"%in%AEstimer) Decomp <- HTML("3-way decomposition")
  })
  
  ###### PArtie Méthode ######
  output$MethodeRecommandee <- renderUI({
    if(input$ExpRepMed == F & input$MediateurRepMed==F & input$OutRepMed==F){
      Method <- "Regressions"
    }
    else if(input$OutRepMed==F){
      Method <- "G-méthodes"
    }
    else(
      Method <- "Mixed models (Modèles à effets aléatoires) ou G-méthodes"
    )
    
    # Probleme de non positivité évidente
    if(input$PosiExpMed=="Oui" | input$PosiMedMed=="Oui"){
      Method <- paste(Method,
                      "<br> <br> L'hypothèse de positivité nécéssaire à l'analyse de médiation est violée, <b> vos résultats seront donc probablement biaisés </b>. <br>
                      Nous recommandons, si vous souhaitez tout de même faire l'analyse de faire de la <b> g-computation </b>, mais vous devrez rester très prudent dans l'interprétation des résultats")
    }
    HTML(Method)
  })
  
}
