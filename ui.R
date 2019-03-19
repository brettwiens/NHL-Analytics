#
# NHL Analytics - Shiny App to Create and Review Advanced Analytics for NHL Data
#

library(shiny); library(DT); library(shinythemes); library(shinyWidgets)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("slate"),
  
   # Application title
   titlePanel(title = div(img(src = "NHLSlate2.gif", height = 60, width = 60)," NHL Analytics")),
   fluidRow(
      column(6,
            shinyWidgets::radioGroupButtons(inputId = "Stat.To.Plot",label = "Statistic:", 
                                          choices = c("Shots","Goals","Shooting Percentage"), selected = "Goals", 
                                          status = "danger")
            ),
      column(2),
      column(4,
             shinyWidgets::radioGroupButtons(inputId = "Playset.To.Show", label = "Group:", 
                                           choices = c("League","Team","Skater","Goalie"), selected = "Team", 
                                           status = "danger")
             )
   ),
   fluidRow(
      column(1,
             img(src = "ANA3.png", height = 45, width = 45),
             img(src = "ARI3.png", height = 45, width = 45),
             img(src = "BOS3.png", height = 45, width = 45),
             img(src = "BUF3.png", height = 45, width = 45),
             img(src = "CAR3.png", height = 45, width = 45),
             img(src = "CBJ3.png", height = 45, width = 45),
             img(src = "CGY3.png", height = 45, width = 45),
             img(src = "CHI3.png", height = 45, width = 45),
             img(src = "COL3.png", height = 45, width = 45),
             img(src = "DAL3.png", height = 45, width = 45),
             img(src = "DET3.png", height = 45, width = 45),
             img(src = "EDM3.png", height = 45, width = 45),
             img(src = "FLA3.png", height = 45, width = 45),
             img(src = "LAK3.png", height = 45, width = 45),
             img(src = "MIN3.png", height = 45, width = 45),
             img(src = "MTL3.png", height = 45, width = 45),
             img(src = "NJD3.png", height = 45, width = 45),
             img(src = "NSH3.png", height = 45, width = 45),
             img(src = "NYI3.png", height = 45, width = 45),
             img(src = "NYR3.png", height = 45, width = 45),
             img(src = "OTT3.png", height = 45, width = 45),
             img(src = "PHI3.png", height = 45, width = 45),
             img(src = "PIT3.png", height = 45, width = 45),
             img(src = "SJS3.png", height = 45, width = 45),
             img(src = "STL3.png", height = 45, width = 45),
             img(src = "TBL3.png", height = 45, width = 45),
             img(src = "TOR3.png", height = 45, width = 45),
             img(src = "VAN3.png", height = 45, width = 45),
             img(src = "VGK3.png", height = 45, width = 45),
             img(src = "WPG3.png", height = 45, width = 45),
             img(src = "WSH3.png", height = 45, width = 45)
             ),
      column(11,
             tabsetPanel(
                tabPanel("Basic Stats",
                  DT::DTOutput('PlayerStatsTable')
                  ),
                tabPanel("Zone Analytics",
                         uiOutput("ZoneAnalytics")),
                tabPanel("Comparative Analytics",
                         uiOutput("ComparativeAnalytics")),
                # tabPanel("Heatmaps",
                #          uiOutput("Heatmaps")),
                tabPanel("Help",
                         "What am I looking at?")
                )
             )
      )
   )
)