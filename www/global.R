require(jsonlite); library(dplyr); library(ggplot2); library(ggforce); library(shinythemes); library(plyr); library(grid); library(png); library(data.table); library(DT)


# source('GatherData.R')  ## Collects all the plays for the 2017-18 season - commented because it takes a long time (90 minutes)

AllPlays <- readRDS('FullPlay.RDS')
## If not re-gathering all plays, then just load the existing file.

PlayerStats <- readRDS('PlayerStats.RDS')
#saveRDS(PlayerStats, "PlayerStats.RDS")

## Averages for each position have been pre-calculated by NHLAnalytics.RMD
CAverages <- readRDS('CAverages.RDS')
RWAverages <- readRDS('RWAverages.RDS')
DAverages <- readRDS('DAverages.RDS')
LWAverages <- readRDS('LWAverages.RDS')
LeagueAverages <- readRDS('LeagueAverages.RDS')

PlayerDetails <- readRDS('PlayerDetails.RDS')

source('AllPlaysCleanup.R')  ## Clean up the plays (Data Types)
source('ZoneDefinition.R')   ## Define the zones for analytical comparison
source('ArenaDrawing.R')     ## Draw the full arena in ggplot and the one-sided arena
source('PlayerInfo.R')       ## Collect supplemental information about each player
source('GoalGenerators.R')   ## Identify Shots that Generate Goals

SGGs <- ShotGeneratingGoals(AllPlays)
for(i in 1:nrow(SGGs)){
   SGGs$ZoneName[i] = ZoneDefinition(SGGs$OneSidex[i], SGGs$OneSidey[i])
}
# saveRDS(AllPlays, 'FullPlay.RDS')

# Create Team List #####
TeamList <- data.frame(Team = unique(AllPlays$name), Code = unique(AllPlays$triCode))
TeamList <- TeamList[!is.na(TeamList$Team),]
TeamList <- TeamList[order(TeamList$Code),]
TeamList$Logo <- paste0(TeamList$Code,".png")
TeamList$DarkLogo <- paste0(TeamList$Code,"2.png")
for(i in 1:nrow(TeamList)){
   TeamList$img[i] <- sprintf("<img src = '%s' width = 30px style='border: #FFFFFF 1px'> - %s</img>", TeamList$DarkLogo[i], TeamList$Team[i])
}
# <img class="asset asset-image at-xid-6a00e009942b4c8833015432d8eb7d970c" style="border: #000000 6px outset; width: 400px; display: block; margin-left: auto; margin-right: auto;" title="Grand-tetons" src="https://help.typepad.com/.a/6a00e009942b4c8833015432d8eb7d970c-400wi" alt="Grand-tetons" />
   
   
currentTeamLogo <- rasterGrob(readPNG("www/NHL.png"), interpolate = TRUE)

## Uncomment this section to get information about teams, players, and general statistics #####
# GatherData()
# GatherData <- function(){
# 
#    api <- "https://statsapi.web.nhl.com/"
# 
#    teamData <- as.data.frame(jsonlite::fromJSON(paste(api, "api/v1/teams")))  ## Read the team data
#    teamData <<- teamData[,-1]
# 
#    playerList <- data.frame()
#    players <- data.frame(Link = unique(AllPlays$player.link1))
#    players$ID <- as.numeric(substr(players$Link,16,23))
#    playerInfo <- data.frame(unique(cbind(AllPlays$player.fullName1, AllPlays$player.id1)), stringsAsFactors = F)
#    names(playerInfo) <- c("Name", "ID")
#    playerInfo$ID <- as.numeric(playerInfo$ID)
#    players <- merge(players, playerInfo, by = "ID")
#    rm(playerInfo)
#    players <- players[!is.na(players$ID),]
#    
#    for(i in 1:nrow(players)){
#       print(paste0(i,'/',nrow(players)))
#       # currentPlayer <- data.frame()
#       currentPlayer <- as.data.frame(t(as.data.frame(unlist(jsonlite::fromJSON(paste0(api, players$Link[i],"/stats/?stats=statsSingleSeason&season=20172018"))), stringsAsFactors = F)), stringsAsFactors = F)
#          currentPlayer$ID <- players$ID[i]
#          currentPlayer$Name <- players$Name[i]
#          try(playerList  <- rbind(playerList, currentPlayer))
#          # playerList[i] <- currentPlayer
#    }
#    playerList <- playerList[,c(32,31,3,4,5,6,7,8,9,10,11,12,15,16,17,18,19,20,21,23,24,25,26)]
#    names(playerList) <- c("Name","ID","Season","TOI","A","G","PIM","Shots","GP","Hits","PPG","PPP","PIM2","FOPercent","ShotPercent","GWG","OTG","SHG","SHP","Blocks","P-M","Pts","Shifts")
#    rownames(playerList) <- c()
#    playerList$A <- as.numeric(as.character(playerList$A))
#    playerList$G <- as.numeric(as.character(playerList$G))
#    playerList$PIM <- as.numeric(as.character(playerList$PIM))
#    playerList$Shots <- as.numeric(as.character(playerList$Shots))
#    playerList$GP <- as.numeric(as.character(playerList$GP))
#    playerList$Hits <- as.numeric(as.character(playerList$Hits))
#    playerList$PPG <- as.numeric(as.character(playerList$PPG))
#    playerList$PPP <- as.numeric(as.character(playerList$PPP))
#    playerList$PIM2 <- as.numeric(as.character(playerList$PIM2))
#    playerList$FOPercent <- as.numeric(as.character(playerList$FOPercent))
#    playerList$ShotPercent <- as.numeric(as.character(playerList$ShotPercent))
#    playerList$GWG <- as.numeric(as.character(playerList$GWG))
#    playerList$OTG <- as.numeric(as.character(playerList$OTG))
#    playerList$SHG <- as.numeric(as.character(playerList$SHG))
#    playerList$SHP <- as.numeric(as.character(playerList$SHP))
#    playerList$Blocks <- as.numeric(as.character(playerList$Blocks))
#    playerList$`P-M` <- as.numeric(as.character(playerList$`P-M`))
#    playerList$Pts <- as.numeric(as.character(playerList$Pts))
#    playerList$Shifts <- as.numeric(as.character(playerList$Shifts))
# 
# 
#    playerList <- playerList[order(-playerList$Pts),]
#    rownames(playerList) <- seq.int(nrow(playerList))
#
# playerList <- playerList[,c(1,9,6,5,22,7,11,12,18,19,16,17,21,10,20,14,15,4,23,8)]
# names(playerList) <- c("Name","GP","G","A","Pts","PIM","PPG","PPP","SHG","SHP","GWG","OTG","PM","Hits","Blks","FOP","ShP","TOI","Shifts","S")
# 
#    saveRDS(playerList, "PlayerStats.RDS")
# 
#    }
##### 

Zone_Summary <- function(PlaysetNoun = "All", Identifier, Statistic.To.Plot = "None", Logo, StatCompareTo = "None"){
   if(PlaysetNoun == "All" | is.null(PlaysetNoun)){
      Playset <- AllPlays
   } else if(PlaysetNoun == "Team"){
      Playset <- AllPlays[AllPlays$triCode == Identifier,]
   } else if(PlaysetNoun == "Player"){
      Playset <- AllPlays[AllPlays$player.fullName1 == Identifier,]
   } else if(PlaysetNoun == "Position"){
      Playset <- AllPlays[AllPlays$people.primaryPosition.code == Identifier,]
   }
   
   Shots <- Playset[grepl("Shot",Playset$event),]
   Goals <- Playset[Playset$event == 'Goal',]
   
   ShotZoneSummary <- as.data.frame(table(Shots$ZoneName))
   GoalZoneSummary <- as.data.frame(table(Goals$ZoneName))
   
   names(ShotZoneSummary) <- c("Zone","Shots")
   names(GoalZoneSummary) <- c("Zone","Goals")
   
   ZoneSummary <- merge(ShotZoneSummary,GoalZoneSummary, by = "Zone")
   names(ZoneSummary) <- c("Zone","Shots","Goals")
   
   ZoneSummary$`Shooting Percentage` <- ZoneSummary$Goals/ZoneSummary$Shots*100
   ZoneSummary$Label <- paste0(ZoneSummary$Goals, "/", ZoneSummary$Shots)
   
   zoneShooting <- join(zone, ZoneSummary, by = "Zone")
   zoneShootingLabels <- join(ZoneLabels, ZoneSummary, by = "Zone")
   
   # if(PlaysetNoun == "All"){
   #     LeagueAverages <- zoneShooting
   # } 
   # else if(PlaysetNoun == "Position" & Identifier == "R"){
   #    RWAverages <<- zoneShooting
   # } else if(PlaysetNoun == "Position" & Identifier == "L"){
   #    LWAverages <<- zoneShooting
   # } else if(PlaysetNoun == "Position" & Identifier == "C"){
   #    CAverages <<- zoneShooting
   # } else if(PlaysetNoun == "Position" & Identifier == "D"){
   #    DAverages <<- zoneShooting
   # }
   
   if(Statistic.To.Plot != "None"){
      if(StatCompareTo == "None"){
         ShootingStatisticsPlots(zoneShooting,zoneShootingLabels, Statistic.To.Plot, Logo)
      } else if(StatCompareTo == "League"){
         LeagueZoneComparisonPlot(zoneShooting, Statistic.To.Plot, Logo)
      } else if(StatCompareTo == "Position"){
         PositionZoneComparisonPlot(zoneShooting, Identifier, Statistic.To.Plot, Logo)
      }
   }
}

LeagueZoneComparisonPlot <- function(zoneShooting, Statistic.To.Plot, Logo){
   if(Statistic.To.Plot == "Shots"){      
      zoneShooting$Comparison.to.League <- zoneShooting$Shots / (LeagueAverages$Shots/31)
   } else if(Statistic.To.Plot == "Goals"){
      zoneShooting$Comparison.to.League <- zoneShooting$Goals / (LeagueAverages$Goals/31)
   } else if(Statistic.To.Plot == "Shooting Percentage"){
      zoneShooting$Comparison.to.League <- zoneShooting$`Shooting Percentage` - LeagueAverages$`Shooting Percentage`
   }
   
   ggplot(data = zoneShooting, aes(x = x, y = y)) +
      annotation_custom(Logo, xmin=-12, xmax=12, ymin=-12, ymax = 12) +
      geom_polygon(aes(fill = Comparison.to.League, group = Zone), colour = "black", alpha = 0.8) +
      One.Side.Arena$layers +
      # scale_fill_distiller(limits = c(-1,1), type = "div", palette = 7, direction = 1) +
      scale_fill_gradient2(midpoint = 1, low = "#FF0000", mid = "#FFFFFF", high = "#00FF00") +
      theme_bw() + theme(axis.text.x = element_blank(), axis.text.y = element_blank(),axis.title = element_blank(), 
                         axis.ticks = element_blank(), panel.border = element_blank(), panel.grid.major = element_blank(),
                         panel.grid.minor = element_blank())
}       
        
PositionZoneComparisonPlot <- function(zoneShooting, Identifier, Statistic.To.Plot, Logo){
   if(Identifier == "L"){
      if(Statistic.To.Plot == "Shots"){
         zoneShooting$Comparison.to.Position <- zoneShooting$Shots / LWAverages$Shots
      } else if(Statistic.To.Plot == "Goals"){
         zoneShooting$Comparison.to.Position <- zoneShooting$Goals / LWAverages$Goals
      } else if(Statistic.To.Plot == "Shooting Percentage"){
         zoneShooting$Comparison.to.Position <- zoneShooting$`Shooting Percentage` / LWAverages$`Shooting Percentage`
      }
   } else if(Identifier == "R"){
      if(Statistic.To.Plot == "Shots"){
         zoneShooting$Comparison.to.Position <- zoneShooting$Shots / RWAverages$Shots
      } else if(Statistic.To.Plot == "Goals"){
         zoneShooting$Comparison.to.Position <- zoneShooting$Goals / RWAverages$Goals
      } else if(Statistic.To.Plot == "Shooting Percentage"){
         zoneShooting$Comparison.to.Position <- zoneShooting$`Shooting Percentage` / RWAverages$`Shooting Percentage`
      }
   } else if(Identifier == "C"){
      if(Statistic.To.Plot == "Shots"){
         zoneShooting$Comparison.to.Position <- zoneShooting$Shots / CAverages$Shots
      } else if(Statistic.To.Plot == "Goals"){
         zoneShooting$Comparison.to.Position <- zoneShooting$Goals / CAverages$Goals
      } else if(Statistic.To.Plot == "Shooting Percentage"){
         zoneShooting$Comparison.to.Position <- zoneShooting$`Shooting Percentage` / CAverages$`Shooting Percentage`
      }
   } else if(Identifier == "D"){
      if(Statistic.To.Plot == "Shots"){
         zoneShooting$Comparison.to.Position <- zoneShooting$Shots / DAverages$Shots
      } else if(Statistic.To.Plot == "Goals"){
         zoneShooting$Comparison.to.Position <- zoneShooting$Goals / DAverages$Goals
      } else if(Statistic.To.Plot == "Shooting Percentage"){
         zoneShooting$Comparison.to.Position <- zoneShooting$`Shooting Percentage` / DAverages$`Shooting Percentage`
      }
   }
   
   ggplot(data = zoneShooting, aes(x = x, y = y)) +
      annotation_custom(Logo, xmin=-12, xmax=12, ymin=-12, ymax = 12) +
      geom_polygon(aes(fill = Comparison.to.Position, group = Zone), colour = "black", alpha = 0.8) +
      One.Side.Arena$layers +
      scale_fill_gradient2(midpoint = 1, low = "#FF0000", mid = "#FFFFFF", high = "#00FF00") +
      theme_bw() + theme(axis.text.x = element_blank(), axis.text.y = element_blank(),axis.title = element_blank(), 
                         axis.ticks = element_blank(), panel.border = element_blank(), panel.grid.major = element_blank(),
                         panel.grid.minor = element_blank())

}

ShootingStatisticsPlots <- function(zoneShooting,zoneShootingLabels,Statistic.To.Plot,Logo){
   
   if(Statistic.To.Plot == "Shooting Percentage"){
      #print("Shooting Percentage")
      SSPlot <- ggplot(zoneShooting, aes(x = x, y = y)) +
         annotation_custom(Logo, xmin=-12, xmax=12, ymin=-12, ymax = 12) +
         geom_polygon(aes(fill = `Shooting Percentage`, group = Zone), colour = "black", alpha = 0.8) +
         One.Side.Arena$layers +
         geom_label(data = zoneShootingLabels, aes(label = zoneShootingLabels$Label, x = X, y = Y, fill = `Shooting Percentage`), size = 2, colour = "black") +
         scale_fill_distiller(type = "div", palette = 7, direction = 1) +
         theme_bw() + theme(axis.text.x = element_blank(), axis.text.y = element_blank(),
                            axis.title = element_blank(), axis.ticks = element_blank(), panel.border = element_blank(), panel.grid.major = element_blank(),
                            panel.grid.minor = element_blank())
   }
   if(Statistic.To.Plot == "Shots"){
      #print("Shots")
      SSPlot <- ggplot(zoneShooting, aes(x = x, y = y)) +
         annotation_custom(Logo, xmin=-12, xmax=12, ymin=-12, ymax = 12) +
         geom_polygon(aes(fill = zoneShooting$Shots, group = Zone), colour = "black", alpha = 0.8) +
         One.Side.Arena$layers +
         geom_label(data = zoneShootingLabels, aes(label = zoneShootingLabels$Shots, x = X, y = Y, 
                                                   fill = zoneShootingLabels$Shots), size = 2, colour = "black") +
         scale_fill_distiller(type = "seq", palette = 10, direction = 1) +
         theme_bw() + theme(axis.text.x = element_blank(), axis.text.y = element_blank(),
                            axis.title = element_blank(), axis.ticks = element_blank(), 
                            panel.border = element_blank(), panel.grid.major = element_blank(),
                            panel.grid.minor = element_blank())
   }
   if(Statistic.To.Plot == "Goals"){
      #print("Goals")
      SSPlot <- ggplot(zoneShooting, aes(x = x, y = y)) +
         annotation_custom(Logo, xmin=-12, xmax=12, ymin=-12, ymax = 12) +
         geom_polygon(aes(fill = zoneShooting$Goals, group = Zone), colour = "black", alpha = 0.8) +
         One.Side.Arena$layers +
         geom_label(data = zoneShootingLabels, aes(label = zoneShootingLabels$Goals, x = X, y = Y, 
                                                   fill = zoneShootingLabels$Goals), size = 2, colour = "black") +
         scale_fill_distiller(type = "seq", palette = 10, direction = 1) +
         theme_bw() + theme(axis.text.x = element_blank(), axis.text.y = element_blank(),
                            axis.title = element_blank(), axis.ticks = element_blank(), 
                            panel.border = element_blank(), panel.grid.major = element_blank(),
                            panel.grid.minor = element_blank())
   }   
   
   return(SSPlot)
}

DensityRinkPlot <- function(PlotData, Logo){
   RPlot <- ggplot2::ggplot(data = PlotData, mapping = aes(x=x, y=y)) +
      stat_density_2d(aes(fill = ..density.., alpha = ..density..), geom = 'tile', contour = F) +
      annotation_custom(Logo, xmin=-12, xmax=12, ymin=-12, ymax = 12) + 
      scale_fill_gradient(low = "#FFFFFF", high = "#CC0000") +
      stat_density2d(colour = 'black', alpha = 0.6, bins = 12) +
      geom_point(alpha = 0.9, pch = 4, size = 1.2) +
      Full.Arena$layers  + 
      
      theme_bw() + theme(legend.position = 'none', axis.text.x = element_blank(), axis.text.y = element_blank(),
                         axis.title = element_blank(), axis.ticks = element_blank(), panel.border = element_blank(), panel.grid.major = element_blank(),
                         panel.grid.minor = element_blank())
      #geom_point(aes(x = 0, y = 0), size = 25, colour = "blue", shape = 1) ## Centre Ice (Not Regulated)
   
   return(RPlot)
}

OneSideDensityRinkPlot <- function(PlotData, Logo){
   
   
   OSDPlot <- ggplot2::ggplot(data = PlotData, mapping = aes(x=OneSidex, y=OneSidey)) +
      stat_density_2d(aes(fill = ..density.., alpha = ..density..), geom = 'tile', contour = F) +
      annotation_custom(Logo, xmin=-12, xmax=12, ymin=-12, ymax = 12) +
      scale_fill_gradient(low = "#FFFFFF", high = "#CC0000") +
      stat_density2d(colour = 'black', alpha = 0.6, bins = 12) +
      geom_point(alpha = 0.9, pch = 4, size = 1.2) +
      One.Side.Arena$layers  + 
      theme_bw() + theme(legend.position = 'none', axis.text.x = element_blank(), axis.text.y = element_blank(),
                         axis.title = element_blank(), axis.ticks = element_blank(), panel.border = element_blank(), panel.grid.major = element_blank(),
                         panel.grid.minor = element_blank())
      #geom_point(aes(x = 0, y = 0), size = 25, colour = "blue", shape = 1) ## Centre Ice (Not Regulated)
   
   return(OSDPlot)
}

HeatMapPlot <- function(PlaysetNoun, Identifier, Statistic.To.Plot, Sides){
   
   if(PlaysetNoun == "Team"){
      Plays <<- AllPlays[AllPlays$triCode == Identifier,]
      currentTeamLogo <- rasterGrob(readPNG(paste0("www/",Identifier,".png")), interpolate = TRUE)
   }
   if(PlaysetNoun == "All") {
      Plays <<- AllPlays
      currentTeamLogo <- rasterGrob(readPNG("www/NHL.png"), interpolate = TRUE)
   }
   if(PlaysetNoun == "Player"){
      Plays <<- AllPlays[AllPlays$player.fullName1 == Identifier,]
      currentTeamLogo <- rasterGrob(readPNG(paste0("www/",unique(Plays$triCode),".png")), interpolate = TRUE)
   }
   
   if(Statistic.To.Plot == "Goals") Events <- Plays[Plays$event == "Goal",]
   if(Statistic.To.Plot == "Shots") Events <- Plays[Plays$event == "Shot",]

   if(Sides == "Two") ttPlot <- DensityRinkPlot(Events, currentTeamLogo)
   if(Sides == "One") ttPlot <- OneSideDensityRinkPlot(Events, currentTeamLogo)
   
   return(ttPlot)
}

ShootingZonePlot <- function(PlaysetNoun, Identifier, Statistic.To.Plot, StatCompareTo = "None"){
   if(PlaysetNoun == "Team"){
      currentTeamLogo <- rasterGrob(readPNG(paste0("www/",Identifier,".png")), interpolate = TRUE)
   }
   if(PlaysetNoun == "All") {
      currentTeamLogo <- rasterGrob(readPNG("www/NHL.png"), interpolate = TRUE)
   }
   if(PlaysetNoun == "Player"){
      Plays <- AllPlays[AllPlays$player.fullName1 == Identifier,]
      currentTeamLogo <- rasterGrob(readPNG(paste0("www/",unique(Plays$triCode),".png")), interpolate = TRUE)
   }
   Zone_Summary(PlaysetNoun= PlaysetNoun, Identifier = Identifier, Statistic.To.Plot = Statistic.To.Plot, 
                Logo = currentTeamLogo, StatCompareTo)
}

PlotCaller <- function(PlaysetNoun = "Team", Identifier = "CGY", Statistic.To.Plot = "Goals", input, output){
## The PlotCaller function is the master caller for all the plots.  Generally, when any variable is changed (Player, Team, Statistic, etc.) every plot needs to be redrawn.  Rather than including in the ui.R file a call to every different plot function which would make it pretty hard to read, instead they pass the arguments directly into the PlotCaller which then passes them on to the necessary plotting functions.
   
   if(Statistic.To.Plot == "Shooting Percentage"){
      DensityStatistic <- "Goals"
   } else {DensityStatistic <- Statistic.To.Plot}
   ## It isn't possible to plot a heatmap of shooting percentage, if the statistic to plot is shooting percentage, then this
   ## needs to be converted into Goals, which is a more meaningful visual representation.
   
   output$PlayerStatsTable <- DT::renderDataTable(PlayerStats, style = "bootstrap")
   ## The most vanilla output, and the one most people are familiar with is just a simple table showing goals, assists, points,
   ## penalties, etc.  Basic simple stats. Not the most impressive, but still useful and accessible.
   
   if(!(PlaysetNoun == "Team" & DensityStatistic == "Shots") & PlaysetNoun != "League"){
      output$TwoSideHeatmap <- shiny::renderPlot(HeatMapPlot(PlaysetNoun = PlaysetNoun, Identifier = Identifier, 
                                                             DensityStatistic, Sides = "Two"), width = 1400, height = 600)
      output$OneSideHeatmap <- shiny::renderPlot(HeatMapPlot(PlaysetNoun = PlaysetNoun, Identifier = Identifier, 
                                                             DensityStatistic, Sides = "One"), width = 700, height = 600)
   }
   
   output$OneSideZonemap <- shiny::renderPlot(ShootingZonePlot(PlaysetNoun = PlaysetNoun, Identifier = Identifier, Statistic.To.Plot), width = 700, height = 600)
   output$ZoneCompareLeague <- shiny::renderPlot(ShootingZonePlot(PlaysetNoun = PlaysetNoun, Identifier = Identifier, Statistic.To.Plot = Statistic.To.Plot, StatCompareTo = "League"), width = 700, height = 600)
   output$ZoneComparePosition <- shiny::renderPlot(ShootingZonePlot(PlaysetNoun = PlaysetNoun, Identifier = Identifier, Statistic.To.Plot = Statistic.To.Plot, StatCompareTo = "Position"), width = 700, height = 600)
   output$SbSPlot1 <- shiny::renderPlot(ShootingZonePlot(PlaysetNoun = "Player", Identifier = input$SbSPlayer1, input$Stat.To.Plot), width = 700, height = 600)
   output$SbSPlot2 <- shiny::renderPlot(ShootingZonePlot(PlaysetNoun = "Player", Identifier = input$SbSPlayer2, input$Stat.To.Plot), width = 700, height = 600)
   
   
}

## It is evidently important to initialize these values.  They get changed within the app, but this enables them to be used on the first run successfull. 
Identifier <- "CGY"
PlaysetNoun <- "Team"
Statistic.To.Plot = "Goals"