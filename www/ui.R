#
# NHL Analytics - Shiny App to Create and Review Advanced Analytics for NHL Data
#

library(shiny); library(DT); library(shinythemes); library(shinyWidgets)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("slate"),
  
  # Application title
  titlePanel(title = div(img(src = "NHLSlate.gif", height = 60, width = 90)," NHL Analytics")),

  # Sidebar with a slider input for number of bins 
  column(width = 3,
       tags$b("Show Statistics For:"),
       br(),
         actionButton("NHLButton",label = div(img(src = "NHLSlate.gif", height = 20, width = 30),br(),"Whole League")),
       br(),br(),

       shinyWidgets::pickerInput(inputId = "TeamPick",
                                 label = "Team",
                                 choices = TeamList$Code,
                                 choicesOpt = list(content = TeamList$img),
                                 selected = "CGY"),

       # tags$b("Specific Team:"),
       # br(),
       #   lapply(1:31, function(i){
       #      actionButton(paste0(TeamList$Code[i],"Button"),label = div(img(src=paste0(TeamList$Code[i],"2.png"), height = 30, width = 30),br(),tags$h6(TeamList$Code[i])))
       #   }),
       br(),br(),
       selectizeInput(inputId = "PlayerText", label = "Specific Player:", choices = sort(unique(AllPlays$player.fullName1)), selected = "Sean Monahan",width = '80%' ),
       actionButton(inputId = "GoPlayer", label = "Go"),
       br(),br(),
       
       shinyWidgets::sliderTextInput(inputId = "Stat.To.Plot",label = "Show Charts for:", choices = c("Shots","Goals","Shooting Percentage"), selected = "Goals")
    ),
    
    # Show a plot of the generated distribution
  column(width = 9,
       tabsetPanel(
          tabPanel("Statistics",
                   DT::DTOutput('PlayerStatsTable')
                   ),
          tabPanel("Shooting Heatmap",
                   tabsetPanel(
                      tabPanel("Full Ice",
                               fluidRow(shiny::plotOutput(outputId = "TwoSideHeatmap"))
                               ),
                      tabPanel("One Side",
                               fluidRow(shiny::plotOutput(outputId = "OneSideHeatmap"))
                               )
                   )
                   ),
          tabPanel("Shooting Zones",
                   fluidRow(shiny::plotOutput(outputId = "OneSideZonemap"))
                   ),
          tabPanel("Zone Comparisons",
                   tabsetPanel(
                      tabPanel("Compare to League",
                               fluidRow(shiny::plotOutput(outputId = "ZoneCompareLeague"))),
                      tabPanel("Compare to Position",
                               fluidRow(shiny::plotOutput(outputId = "ZoneComparePosition"))
                               )
                   )
                   ),
          tabPanel("Side-by-Side",
                   fluidRow(
                      column(6,
                             shiny::selectizeInput("SbSPlayer1", label = "Player 1", choices = sort(unique(AllPlays$player.fullName1)), selected = "Sean Monahan")),
                      column(6,
                             shiny::selectizeInput("SbSPlayer2", label = "Player 2", choices = sort(unique(AllPlays$player.fullName1)), selected = "Connor McDavid"),
                             actionButton("SideBySideGo", "Go"))
                      ),
                   fluidRow(
                      column(6,
                             shiny::plotOutput("SbSPlot1")),
                      column(6, 
                             shiny::plotOutput("SbSPlot2"))
                   )
                   ),
          tabPanel("Help",
                   "How do I read this thing?"
                   )
       )
    )
  )
)
