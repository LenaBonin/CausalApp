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
    
    if(PropMediated==T) NIE <- TotalEffect <- T  # On a besoin de ces mesures pour calculer PropMediated
    if(PropEliminated==T) CDE <- TotalEffect <- T # On a besoin de ces mesures pour calculer PropEliminated
    
    if(input$InterractionExpMed=="Oui" & (NDE==T | NIE==T)){
      # On isole le terme d'interaction
      MIE = T
      
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
      # On n'isole pas le terme d'interaction
      MIE = F
      
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
    else{PNDE <- TNDE <- PNIE <- TNIE <- MIE <- F}
    
    
    Estimands <- data.frame(
      Effet = c("Effet total", "Effet direct controlé", "Proportion éliminée", "Effet naturel direct pur", "Effet naturel direct total",
                "Effet naturel indirect pur", "Effet naturel indirect total", "Proportion médiée", "Mediated interactive effect"),
      Abbreviation = c("TE", "CDE", "PropEliminated", "PNDE", "TNDE", "PNIE", "TNIE", "PropMediated", "MIE"),
      Estimation = c(TotalEffect, CDE, PropEliminated, PNDE, TNDE, PNIE, TNIE, PropMediated, MIE)
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

    if("TNIE" %in% AEstimer | "TNDE" %in% AEstimer)
      Decomp <- "<b>2-way decomposition :</b>"
    else if("PNDE"%in%AEstimer & "PNIE"%in%AEstimer) Decomp <- "<b>3-way decomposition :</b>"

    if("TNIE" %in% AEstimer){
      Decomp <- paste(Decomp, "$$TE = TNIE + PNDE$$")
    }
    else if("TNDE" %in% AEstimer) Decomp <- paste(Decomp, "$$TE = TNDE + PNIE$$")
    else if(Decomp=="<b>3-way decomposition :</b>") Decomp <- paste(Decomp, "$$TE = PNDE + PNIE + MIE$$")

    if("PropEliminated" %in% AEstimer){
      Decomp <- paste(Decomp, "<br> <b>Proportion éliminée :</b> <br> <span style='margin-left: 50px;'> Echelle additive : </span> $$\\frac{TE - CDE}{TE}$$
                       <br> <span style='margin-left: 50px;'> Echelle risque relatif : </span> $$\\frac{OR^{TE} - OR^{CDE}}{OR^{TE}-1}$$")
    }
    if("PropMediated" %in% AEstimer){
      # Le choix de l'effet direct (PNDE ou TNDE) et indirect dépendent des réponses
      if("TNIE" %in% AEstimer){
        Decomp <- paste(Decomp, "<br> <b>Proportion médiée :</b> <br> <span style='margin-left: 50px;'> Echelle additive : </span> $$\\frac{TNIE}{TE}$$
                        <br> <span style='margin-left: 50px;'> Echelle risque relatif : </span> $$\\frac{OR^{PNDE}(OR^{TNIE}-1)}{OR^{PNDE}OR^{TNIE}-1}$$")
      }
      
      else{ #PNIE
          Decomp <- paste(Decomp, "<br> <b>Proportion médiée :</b> <br> <span style='margin-left: 50px;'> Echelle additive : </span> $$\\frac{PNIE}{TE}$$")
          #Then we must differentiate PNDE and TNDE
          if("PNDE"%in% AEstimer){
            Decomp <- paste(Decomp, "<br>  <span style='margin-left: 50px;'> Echelle risque relatif : </span> $$\\frac{OR^{PNDE}(OR^{PNIE}-1)}{OR^{PNDE}OR^{PNIE}-1}$$")
          }
          else{ #TNDE
              Decomp <- paste(Decomp, "<br>  <span style='margin-left: 50px;'> Echelle risque relatif : </span> $$\\frac{OR^{TNDE}(OR^{PNIE}-1)}{OR^{TNDE}OR^{PNIE}-1}$$")
          }
      }
      
    }
    

    withMathJax(HTML(Decomp))
    #HTML(Decomp)
  })
  
  # output$DecompEffet <- renderUI({
  #   Estimands <- Estimands() %>%
  #     dplyr::filter(Estimation==T)
  # 
  #   AEstimer <- as.vector(Estimands$Abbreviation)
  # 
  #   if("TNIE" %in% AEstimer | "TNDE" %in% AEstimer)
  #     Decomp <- "<br> 2-way decomposition :"
  #   else if("PNDE"%in%AEstimer & "PNIE"%in%AEstimer) Decomp <- "<br> 3-way decomposition :"
  # 
  #   if("TNIE" %in% AEstimer){
  #     Decomp <- paste(Decomp, "<br> <math> TE = TNIE + PNDE </math>")
  #   }
  #   else if("TNDE" %in% AEstimer) Decomp <- paste(Decomp, "<br> <math> TE = TNDE + PNIE </math>")
  #   else if(Decomp=="3-way decomposition :") Decomp <- paste(Decomp, "<br> <math> TE = PNDE + PNIE + MIE </math>")
  # 
  #   if("PropEliminated" %in% AEstimer){
  #     Decomp <- paste(Decomp, "<br> Proportion éliminée : <br> Echelle additive : $$(TE - CDE)/TE$$
  #                     <br> Echelle risque relatif : <math display='block'> <mfrac> <mn> <var>OR <sup> TE</sup></var> - <var>OR<sup>CDE</sup></var></mn> <mn><var>OR<sup>TE</sup></var></mn> </mfrac></math>")
  #   }
  # 
  #   HTML(Decomp)
  # })
  
  ###### PArtie Méthode ######
  Methode <- reactive({
    if(input$ExpRepMed == "Non" & input$MediateurRepMed=="Non" & input$OutRepMed=="Non"){
      Method <- "Regressions"
    }
    else if(input$OutRepMed=="Non"){
      Method <- "G-méthodes"
    }
    else(
      Method <- "Modèles mixtes (Modèles à effets aléatoires) ou G-méthodes"
    )
    Method
  })
  
  output$MethodeRecommandee <- renderUI({
    Method <- Methode()
    
    # Probleme de non positivité évidente
    if(input$PosiExpMed=="Oui" | input$PosiMedMed=="Oui"){
      Method <- paste(Method,
                      "<br> <br> L'hypothèse de positivité nécéssaire à l'analyse de médiation est violée, <b> vos résultats seront donc probablement biaisés </b>. <br>
                      Nous recommandons, si vous souhaitez tout de même faire l'analyse de faire de la <b> g-computation </b>, mais vous devrez rester très prudent dans l'interprétation des résultats")
    }
    HTML(Method)
  })

  
}

