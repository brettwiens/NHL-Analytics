library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
   ## Create the default plots (default teams and players)
   PlotCaller(input = input, output = output)
   output$ZoneAnalytics <- renderUI({
      if(input$Playset.To.Show == "Team"){
         div(fluidRow(
                    shinyWidgets::pickerInput(inputId = "TeamPick", label = "Team", choices = TeamList$Code,
                                              choicesOpt = list(content = TeamList$img),selected = "CGY")),
             fluidRow(
             column(6,
                    fluidRow(shiny::plotOutput(outputId = "OneSideZonemap"))
            ),
             column(6,
                   fluidRow(shiny::plotOutput(outputId = "ZoneCompareLeague"))
          )))
      } else if(input$Playset.To.Show == "Player"){
         div(fluidRow(
                    shinyWidgets::pickerInput(inputId = "PlayerPick", label = "Player", 
                                              choices = sort(unique(AllPlays$player.fullName1)), selected = "Sean Monahan")),
             fluidRow(
                column(6,
                       fluidRow(shiny::plotOutput(outputId = "OneSideZonemap"))
                       ),
                column(6,
                       fluidRow(shiny::plotOutput(outputId = "OneSideHeatMap"))
                       )
                )
             )
      }
   })
   output$ComparativeAnalytics <- renderUI({
      PlotCaller(input = input, output = output)
      if(input$Playset.To.Show == "Player"){
         div(
            fluidRow(
               column(6,
                      shiny::selectizeInput("SbSPlayer1", label = "Player 1", choices = sort(unique(AllPlays$player.fullName1)),
                                            selected = "Sean Monahan")
               ),
               column(6, 
                      shiny::selectizeInput("SbSPlayer2", label = "Player 2", choices = sort(unique(AllPlays$player.fullName1)),
                                            selected = "Connor McDavid")
               )),
            fluidRow(
               column(6,
                      shiny::plotOutput("SbSPlot1")
               ),
               column(6,
                      shiny::plotOutput("SbSPlot2")
               )
            )
         )
      } else if(input$Playset.To.Show == "Team"){
         div(
            fluidRow(
               column(6,
                      shiny::selectizeInput("SbSTeam1", label = "Team 1", choices = TeamList$Code,
                                     choicesOpt = list(content = TeamList$img),selected = "CGY")
               ),
               column(6, 
                      shiny::selectizeInput("SbSTeam2", label = "Team 2", choices = TeamList$Code,
                                            choicesOpt = list(content = TeamList$img),selected = "EDM")
               )),
               fluidRow(
                  column(6,
                         shiny::plotOutput("SbSPlot1")
                         ),
                  column(6,
                         shiny::plotOutput("SbSPlot2")
                         )
                  )
            )
      }
   })
   
   
   ## User selects if they want to show graphics about the league, teams, or players
   observeEvent(input$Playset.To.Show,{
      PlaysetNoun <<- input$Playset.To.Show
      PlotCaller(PlaysetNoun, Identifier,ID2, Statistic.To.Plot, input, output)
      if(input$Playset.To.Show == "League"){
         output$ZoneAnalytics <- renderUI({
            div(fluidRow(shiny::plotOutput(outputId = "OneSideZonemap")))
         })
         output$ComparativeAnalytics <- renderUI({
            "No Comparative Analytics Available"
         })
      } else if(input$Playset.To.Show == "Team"){
         output$ZoneAnalytics <- renderUI({
            div(fluidRow(
                       shinyWidgets::pickerInput(inputId = "TeamPick", label = "Team", choices = TeamList$Code,
                                                 choicesOpt = list(content = TeamList$img),selected = "CGY")),
                fluidRow(
                column(6,
                       fluidRow(shiny::plotOutput(outputId = "OneSideZonemap"))
                ),
                column(6,
                       fluidRow(shiny::plotOutput(outputId = "ZoneCompareLeague"))
                ))
            )
         })

         output$ComparativeAnalytics <- renderUI({
            div(column(6,
                       fluidRow(
                          shinyWidgets::pickerInput(inputId = "SBSTeamPick1", label = "Team 1", choices = TeamList$Code,
                                                    choicesOpt = list(content = TeamList$img),selected = "CGY")),
                       fluidRow(
                          shiny::plotOutput(outputId = "SbSPlot1")
                       )),
                column(6,
                       fluidRow(
                          shinyWidgets::pickerInput(inputId = "SBSTeamPick2", label = "Team 2", choices = TeamList$Code,
                                                    choicesOpt = list(content = TeamList$img),selected = "EDM")),
                       fluidRow(
                          shiny::plotOutput(outputId = "SbSPlot2")
                       ))
                )
         })
      } else if(input$Playset.To.Show == "Skater"){
         output$ZoneAnalytics <- renderUI({
            div(fluidRow(
               shiny::selectizeInput(inputId = "PlayerPick", label = "Player", choices = sort(unique(AllPlays$player.fullName1)), selected = "Taylor Hall")),
                fluidRow(
                   column(6,
                          shiny::plotOutput(outputId = "OneSideZonemap")
                          ),
                   column(6,
                          shiny::plotOutput(outputId = "OneSideHeatMap")
                          )
                   )
            )
         })
         output$ComparativeAnalytics <- renderUI({
            div(column(6,
                       fluidRow(
                          shiny::selectizeInput(inputId = "SBSPlayerPick1", label = "Player 1",
                                                    choices = sort(unique(AllPlays$player.fullName1)),
                                                    selected = "Alex Ovechkin")),
                       fluidRow(
                          shiny::plotOutput(outputId = "SbSPlot1")
                          )
                       ),
            column(6,
                   fluidRow(
                      shiny::selectizeInput(inputId = "SBSPlayerPick2", label = "Player 2",
                                                choices = sort(unique(AllPlays$player.fullName1)),
                                                selected = "Connor McDavid")),
                   fluidRow(
                      shiny::plotOutput(outputId = "SbSPlot2")
                      )
                   )
            )
         })
      } else if(input$Playset.To.Show == "Goalie"){
         output$ZoneAnalytics <- renderUI({
            div(fluidRow(
               shiny::selectizeInput(inputId = "GoaliePick", label = "Goalie", choices = sort(unique(GoalieData$Goalie)), selected = "Pekka Rinne")),
               fluidRow(
                  column(6,
                         shiny::plotOutput(outputId = "OneSideZonemap")
                  ),
                  column(6,
                         shiny::plotOutput(outputId = "OneSideHeatMap")
                  ))
            )
         })
         output$ComparativeAnalytics <- renderUI({
            div(column(6,
                       fluidRow(
                          shiny::selectizeInput(inputId = "SBSGoaliePick1", label = "Goalie 1",
                                                    choices = sort(unique(GoalieData$Goalie)),
                                                    selected = "Pekka Rinne")),
                       fluidRow(
                          shiny::plotOutput(outputId = "SbSPlot1")
                       )
            ),
            column(6,
                   fluidRow(
                      shiny::selectizeInput(inputId = "SBSGoaliePick2", label = "Goalie 2",
                                                choices = sort(unique(GoalieData$Goalie)),
                                                selected = "Sergei Bobrovsky")),
                   fluidRow(
                      shiny::plotOutput(outputId = "SbSPlot2")
                   )
            )
            )
         })
      }
   })

   ## User selects the two teams they would like to compare and contrast
   observeEvent(input$SBSTeamPick1,{
      Identifier <<- input$SBSTeamPick1
      PlotCaller(input = input, output = output, Statistic.To.Plot = Statistic.To.Plot, Identifier = Identifier, ID2 = ID2, PlaysetNoun = PlaysetNoun)
   })
   observeEvent(input$SBSTeamPick2,{
      ID2 <<- input$SBSTeamPick2
      PlotCaller(Statistic.To.Plot = Statistic.To.Plot, Identifier = Identifier, ID2 = ID2, PlaysetNoun = PlaysetNoun,input = input, output = output)
   })
   
   ## User selects the two players they would like to compare and contrast
   observeEvent(input$SBSPlayerPick1,{
      Identifier <<- input$SBSPlayerPick1
      PlotCaller(input = input, output = output, Statistic.To.Plot = Statistic.To.Plot, Identifier = Identifier, ID2 = ID2, PlaysetNoun = PlaysetNoun)
   })
   observeEvent(input$SBSPlayerPick2,{
      ID2 <<- input$SBSPlayerPick2
      PlotCaller(Statistic.To.Plot = Statistic.To.Plot, Identifier = Identifier, ID2 = ID2, PlaysetNoun = PlaysetNoun,input = input, output = output)
   })
   
   ## User selects the two goalies they would like to compare and contrast
   observeEvent(input$SBSGoaliePick1,{
      Identifier <<- input$SBSGoaliePick1
      PlotCaller(input = input, output = output, Statistic.To.Plot = Statistic.To.Plot, Identifier = Identifier, ID2 = ID2, PlaysetNoun = PlaysetNoun)
   })
   observeEvent(input$SBSGoaliePick2,{
      ID2 <<- input$SBSGoaliePick2
      PlotCaller(Statistic.To.Plot = Statistic.To.Plot, Identifier = Identifier, ID2 = ID2, PlaysetNoun = PlaysetNoun,input = input, output = output)
   })
   
   ## User selects the team they want to view
   observeEvent(input$TeamPick,{
      Identifier <<- input$TeamPick; 
      PlaysetNoun <<- "Team"; 
      PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input = input, output = output)
      })
   
   ## User Selects the player they want to view
   observeEvent(input$PlayerPick,{
      Identifier <<- input$PlayerPick;
      PlaysetNoun <<- "Skater";
      PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input = input, output = output)
   })
   
   observeEvent(input$GoaliePick,{
      Identifier <<- input$GoaliePick;
      PlaysetNoun <<- "Goalie";
      PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input = input, output = output)
   })
   
   ## User selects the statistic they would like to plot
   observeEvent(input$Stat.To.Plot,{
      Statistic.To.Plot <<- input$Stat.To.Plot
      PlotCaller(PlaysetNoun, Identifier, ID2, Statistic.To.Plot = Statistic.To.Plot, input = input, output = output)
   })

})
