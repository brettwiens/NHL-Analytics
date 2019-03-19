#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
   PlotCaller(input = input, output = output)

   
   observeEvent(input$SideBySideGo,{
      output$SbSPlot1 <- shiny::renderPlot(ShootingZonePlot(PlaysetNoun = "Player", Identifier = input$SbSPlayer1, 
                                                            input$Stat.To.Plot), width = 700, height = 600)
      output$SbSPlot2 <- shiny::renderPlot(ShootingZonePlot(PlaysetNoun = "Player", Identifier = input$SbSPlayer2, 
                                                            input$Stat.To.Plot), width = 700, height = 600)
   })
   
   observeEvent(input$TeamPick,{
      Identifier <<- input$TeamPick; 
      PlaysetNoun <<- "Team"; 
      PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)
      })
   
   #### Team Buttons #####   
   # observeEvent(input$ANAButton,{
   #    Identifier <<- "ANA"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)})
   # observeEvent(input$ARIButton,{
   #    Identifier <<- "ARI"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)})
   # observeEvent(input$BOSButton,{
   #    Identifier <<- "BOS"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)})
   # observeEvent(input$BUFButton,{
   #    Identifier <<- "BUF"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)})
   # observeEvent(input$CARButton,{
   #    Identifier <<- "CAR"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)})
   # observeEvent(input$CBJButton,{
   #    Identifier <<- "CBJ"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)})
   # observeEvent(input$CGYButton,{
   #    Identifier <<- "CGY"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)})
   # observeEvent(input$CHIButton,{
   #    Identifier <<- "CHI"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)})
   # observeEvent(input$COLButton,{
   #    Identifier <<- "COL"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)})
   # observeEvent(input$DALButton,{
   #    Identifier <<- "DAL"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)   })
   # observeEvent(input$DETButton,{
   #    Identifier <<- "DET"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)   })
   # observeEvent(input$EDMButton,{
   #    Identifier <<- "EDM"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)   })
   # observeEvent(input$FLAButton,{
   #    Identifier <<- "FLA"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)   })
   # observeEvent(input$LAKButton,{
   #    Identifier <<- "LAK"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)   })
   # observeEvent(input$MINButton,{
   #    Identifier <<- "MIN"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)   })
   # observeEvent(input$MTLButton,{
   #    Identifier <<- "MTL"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)   })
   # observeEvent(input$NJDButton,{
   #    Identifier <<- "NJD"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)   })
   # observeEvent(input$NSHButton,{
   #    Identifier <<- "NSH"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)   })
   # observeEvent(input$NYIButton,{
   #    Identifier <<- "NYI"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)   })
   # observeEvent(input$NYRButton,{
   #    Identifier <<- "NYR"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)   })
   # observeEvent(input$OTTButton,{
   #    Identifier <<- "OTT"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)   })
   # observeEvent(input$PHIButton,{
   #    Identifier <<- "PHI"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)   })
   # observeEvent(input$PITButton,{
   #    Identifier <<- "PIT"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)   })
   # observeEvent(input$SJSButton,{
   #    Identifier <<- "SJS"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)   })
   # observeEvent(input$STLButton,{
   #    Identifier <<- "STL"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)   })
   # observeEvent(input$TBLButton,{
   #    Identifier <<- "TBL"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)   })
   # observeEvent(input$TORButton,{
   #    Identifier <<- "TOR"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)   })
   # observeEvent(input$VANButton,{
   #    Identifier <<- "VAN"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)   })
   # observeEvent(input$VGKButton,{
   #    Identifier <<- "VGK"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)   })
   # observeEvent(input$WPGButton,{
   #    Identifier <<- "WPG"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)   })
   # observeEvent(input$WSHButton,{
   #    Identifier <<- "WSH"; PlaysetNoun <<- "Team"; PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)   })
#####
  
   #### Stat Selection #####
   observeEvent(input$Stat.To.Plot,{
      PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)
   })
   #####
   
   #### Player Selection #####
   observeEvent(input$GoPlayer,{
      PlaysetNoun <<- "Player"; Identifier <<- input$PlayerText
      PlotCaller(PlaysetNoun, Identifier, Statistic.To.Plot = input$Stat.To.Plot, input, output)
   })
   
   
   
})
