require(jsonlite); library(dplyr); library(ggplot2); library(ggforce)

##### Team Data #####

api <- "https://statsapi.web.nhl.com/"

teamData <- as.data.frame(jsonlite::fromJSON(paste(api, "api/v1/teams")))  ## Read the team data 
teamData <- teamData[,-1]

##### Roster Information #####

teamList <- character()
rosters <- list()

for(i in 1:nrow(teamData)){
   # CurrentTeam <- teamData$teams.franchise$teamName[i]
   rosterData <- as.data.frame(jsonlite::fromJSON(paste(api,teamData$teams.link[i],"/roster", sep = "")))
   rosterData$Team <- teamData$teams.name[i]
   rosters[[i]] <- rosterData[,-1]
   rm(rosterData)
}

AllPlayers <- data.frame()

for(i in 1:nrow(teamData)){
   CurrentTeam <- data.frame(matrix(unlist(rosters[[i]]), nrow=nrow(rosters[[i]]), byrow=F))
   AllPlayers <- rbind(AllPlayers, CurrentTeam)
   rm(CurrentTeam)
}
names(AllPlayers) <- c("ID", "Name", "Link","Number","PosL","Position", "GDF", "POSL2","Active", "Team")

players <- list()

for(i in 1:nrow(AllPlayers)){
   # CurrentPlayer <- AllPlayers$Name[i]
   playerData <- as.data.frame(jsonlite::fromJSON(paste(api,AllPlayers$Link[i], sep = "")))
   players[[i]] <- playerData
   # rm(playerData)
}

AllPlayerInfo <- data.frame()
playerInfoNames <- c("copyright","people.id","people.fullName","people.link","people.firstName","people.lastName","people.primaryNumber","people.birthDate","people.currentAge","people.birthCity","people.birthStateProvince","people.birthCountry","people.nationality","people.height","people.weight","people.active","people.alternateCaptain","people.captain","people.rookie","people.shootsCatches","people.rosterStatus","people.currentTeam.id","people.currentTeam.name","people.currentTeam.link","people.primaryPosition.code","people.primaryPosition.name","people.primaryPosition.type","people.primaryPosition.abbreviation")

for(i in 1:nrow(AllPlayers)){
   CurrentPlayer <- data.frame(matrix(unlist(players[[i]]), nrow=nrow(players[[i]]), byrow = F))
   names(CurrentPlayer) <- names(unlist(players[[i]]))
   
   if(is.null(CurrentPlayer$copyright)) CurrentPlayer$copyright <- "NA"
   if(is.null(CurrentPlayer$people.id)) CurrentPlayer$people.id <- "NA"
   if(is.null(CurrentPlayer$people.fullName)) CurrentPlayer$people.fullName <- "NA"
   if(is.null(CurrentPlayer$people.link)) CurrentPlayer$people.link <- "NA"
   if(is.null(CurrentPlayer$people.firstName)) CurrentPlayer$people.firstName <- "NA"
   if(is.null(CurrentPlayer$people.lastName)) CurrentPlayer$people.lastName <- "NA"
   if(is.null(CurrentPlayer$people.birthDate)) CurrentPlayer$people.birthDate <- "NA"
   if(is.null(CurrentPlayer$people.currentAge)) CurrentPlayer$people.currentAge <- "NA"
   if(is.null(CurrentPlayer$people.birthCity)) CurrentPlayer$people.birthCity <- "NA"
   if(is.null(CurrentPlayer$people.birthStateProvince)) CurrentPlayer$people.birthStateProvince <- "NA"
   if(is.null(CurrentPlayer$people.birthCountry)) CurrentPlayer$people.birthCountry <- "NA"
   if(is.null(CurrentPlayer$people.nationality)) CurrentPlayer$people.nationality <- "NA"
   if(is.null(CurrentPlayer$people.height)) CurrentPlayer$people.height <- "NA"
   if(is.null(CurrentPlayer$people.weight)) CurrentPlayer$people.weight <- "NA"
   if(is.null(CurrentPlayer$people.active)) CurrentPlayer$people.active <- "NA"
   if(is.null(CurrentPlayer$people.alternateCaptain)) CurrentPlayer$people.alternateCaptain <- "NA"
   if(is.null(CurrentPlayer$people.captain)) CurrentPlayer$people.captain <- "NA"
   if(is.null(CurrentPlayer$people.rookie)) CurrentPlayer$people.rookie <- "NA"
   if(is.null(CurrentPlayer$people.shootsCatches)) CurrentPlayer$people.shootsCatches <- "NA"
   if(is.null(CurrentPlayer$people.rosterStatus)) CurrentPlayer$people.rosterStatus <- "NA"
   if(is.null(CurrentPlayer$people.currentTeam.id)) CurrentPlayer$people.currentTeam.id <- "NA"
   if(is.null(CurrentPlayer$people.currentTeam.name)) CurrentPlayer$people.currentTeam.name <- "NA"
   if(is.null(CurrentPlayer$people.currentTeam.link)) CurrentPlayer$people.currentTeam.link <- "NA"
   if(is.null(CurrentPlayer$people.primaryPosition.code)) CurrentPlayer$people.primaryPosition.code <- "NA"
   if(is.null(CurrentPlayer$people.primaryPosition.name)) CurrentPlayer$people.primaryPosition.name <- "NA"
   if(is.null(CurrentPlayer$people.primaryPosition.type)) CurrentPlayer$people.primaryPosition.type <- "NA"
   if(is.null(CurrentPlayer$people.primaryPosition.abbreviation)) CurrentPlayer$people.primaryPosition.abbreviation <- "NA"
   if(is.null(CurrentPlayer$people.primaryNumber)) CurrentPlayer$people.primaryNumber <- "NA"
   
   CurrentPlayer <- CurrentPlayer[, playerInfoNames]
   
   AllPlayerInfo <- rbind(AllPlayerInfo, CurrentPlayer)
   rm(CurrentPlayer)
}

##### Player Statistics #####

## Get Point Statistics for Each Player

playerStats <- list()
for(i in 1:nrow(AllPlayerInfo)){
   currentPlayerStats <- as.data.frame(jsonlite::fromJSON(paste(api,AllPlayerInfo$people.link[[i]],"?hydrate=stats(splits=statsSingleSeason)", sep = "" )))
   playerStats[[i]] <- currentPlayerStats
   rm(currentPlayerStats)
}

AllSkaterStats <- data.frame()
AllGoalieStats <- data.frame()

for(i in 1:length(playerStats)){               ## For all players with statsitsics
   currentPlayer <- data.frame(matrix(unlist(playerStats[[i]]), nrow = nrow(playerStats[[i]]), byrow = F))
   names(currentPlayer) <- names(unlist(playerStats[[i]]))
   ## Unlist the list into a matrix, convert it to a dataframe and save it to the currentPlayer dataframe
   if(!length(currentPlayer) < 32){                   ## Handles Odd Exception where a player has no statistics
      if(is.null(currentPlayer$copyright)) currentPlayer$copyright <- "NA"
      if(is.null(currentPlayer$people.id)) currentPlayer$people.id <- "NA"
      if(is.null(currentPlayer$people.fullName)) currentPlayer$people.fullName <- "NA"
      if(is.null(currentPlayer$people.link)) currentPlayer$people.link <- "NA"
      if(is.null(currentPlayer$people.firstName)) currentPlayer$people.firstName <- "NA"
      if(is.null(currentPlayer$people.lastName)) currentPlayer$people.lastName <- "NA"
      if(is.null(currentPlayer$people.birthDate)) currentPlayer$people.birthDate <- "NA"
      if(is.null(currentPlayer$people.currentAge)) currentPlayer$people.currentAge <- "NA"
      if(is.null(currentPlayer$people.birthCity)) currentPlayer$people.birthCity <- "NA"
      if(is.null(currentPlayer$people.birthStateProvince)) currentPlayer$people.birthStateProvince <- "NA"
      if(is.null(currentPlayer$people.birthCountry)) currentPlayer$people.birthCountry <- "NA"
      if(is.null(currentPlayer$people.nationality)) currentPlayer$people.nationality <- "NA"
      if(is.null(currentPlayer$people.height)) currentPlayer$people.height <- "NA"
      if(is.null(currentPlayer$people.weight)) currentPlayer$people.weight <- "NA"
      if(is.null(currentPlayer$people.active)) currentPlayer$people.active <- "NA"
      if(is.null(currentPlayer$people.alternateCaptain)) currentPlayer$people.alternateCaptain <- "NA"
      if(is.null(currentPlayer$people.captain)) currentPlayer$people.captain <- "NA"
      if(is.null(currentPlayer$people.rookie)) currentPlayer$people.rookie <- "NA"
      if(is.null(currentPlayer$people.shootsCatches)) currentPlayer$people.shootsCatches <- "NA"
      if(is.null(currentPlayer$people.rosterStatus)) currentPlayer$people.rosterStatus <- "NA"
      if(is.null(currentPlayer$people.currentTeam.id)) currentPlayer$people.currentTeam.id <- "NA"
      if(is.null(currentPlayer$people.currentTeam.name)) currentPlayer$people.currentTeam.name <- "NA"
      if(is.null(currentPlayer$people.currentTeam.link)) currentPlayer$people.currentTeam.link <- "NA"
      if(is.null(currentPlayer$people.primaryPosition.code)) currentPlayer$people.primaryPosition.code <- "NA"
      if(is.null(currentPlayer$people.primaryPosition.name)) currentPlayer$people.primaryPosition.name <- "NA"
      if(is.null(currentPlayer$people.primaryPosition.type)) currentPlayer$people.primaryPosition.type <- "NA"
      if(is.null(currentPlayer$people.primaryPosition.abbreviation)) currentPlayer$people.primaryPosition.abbreviation <- "NA"
      if(is.null(currentPlayer$people.primaryNumber)) currentPlayer$people.primaryNumber <- "NA"
      
      if(playerStats[[i]]$people.primaryPosition$code != "G"){     ## If the player is not a goalie, treat as a skater
         AllSkaterStats <- rbind(AllSkaterStats,currentPlayer)
         ## Add the current skater to the list of skater statistics
      }
      if(playerStats[[i]]$people.primaryPosition$code == "G"){      ## If the current player is a goalie, treat as such
         
         if(is.null(currentPlayer$people.stats.splits.season)) 
            currentPlayer$people.primaryPosition.type <- "NA"    
         if(is.null(currentPlayer$people.stats.splits.stat.timeOnIce)) 
            currentPlayer$people.primaryPosition.type <- "NA"          
         if(is.null(currentPlayer$people.stats.splits.stat.ot)) 
            currentPlayer$people.primaryPosition.type <- "NA"                        
         if(is.null(currentPlayer$people.stats.splits.stat.shutouts)) 
            currentPlayer$people.primaryPosition.type <- "NA"
         if(is.null(currentPlayer$people.stats.splits.stat.ties)) 
            currentPlayer$people.stats.splits.stat.ties <- "NA"
         if(is.null(currentPlayer$people.stats.splits.stat.wins)) 
            currentPlayer$people.stats.splits.stat.wins <- "NA"
         if(is.null(currentPlayer$people.stats.splits.stat.losses)) 
            currentPlayer$people.stats.splits.stat.losses <- "NA"
         if(is.null(currentPlayer$people.stats.splits.stat.saves)) 
            currentPlayer$people.stats.splits.stat.saves <- "NA"
         if(is.null(currentPlayer$people.stats.splits.stat.powerPlaySaves)) 
            currentPlayer$people.stats.splits.stat.powerPlaySaves <- "NA"
         if(is.null(currentPlayer$people.stats.splits.stat.shortHandedSaves)) 
            currentPlayer$people.stats.splits.stat.shortHandedSaves <- "NA"
         if(is.null(currentPlayer$people.stats.splits.stat.evenSaves)) 
            currentPlayer$people.stats.splits.stat.evenSaves <- "NA"
         if(is.null(currentPlayer$people.stats.splits.stat.shortHandedShots)) 
            currentPlayer$people.stats.splits.stat.shortHandedShots <- "NA"
         if(is.null(currentPlayer$people.stats.splits.stat.evenShots)) 
            currentPlayer$people.stats.splits.stat.evenShots <- "NA"
         if(is.null(currentPlayer$people.stats.splits.stat.powerPlayShots)) 
            currentPlayer$people.stats.splits.stat.powerPlayShots <- "NA"
         if(is.null(currentPlayer$people.stats.splits.stat.savePercentage)) 
            currentPlayer$people.stats.splits.stat.savePercentage <- "NA"
         if(is.null(currentPlayer$people.stats.splits.stat.goalAgainstAverage)) 
            currentPlayer$people.stats.splits.stat.goalAgainstAverage <- "NA"
         if(is.null(currentPlayer$people.stats.splits.stat.games)) 
            currentPlayer$people.stats.splits.stat.games <- "NA"
         if(is.null(currentPlayer$people.stats.splits.stat.gamesStarted)) 
            currentPlayer$people.stats.splits.stat.gamesStarted <- "NA"
         if(is.null(currentPlayer$people.stats.splits.stat.shotsAgainst)) 
            currentPlayer$people.stats.splits.stat.shotsAgainst <- "NA"
         if(is.null(currentPlayer$people.stats.splits.stat.goalsAgainst)) 
            currentPlayer$people.stats.splits.stat.goalsAgainst <- "NA"
         if(is.null(currentPlayer$people.stats.splits.stat.timeOnIcePerGame)) 
            currentPlayer$people.stats.splits.stat.timeOnIcePerGame <- "NA"
         if(is.null(currentPlayer$people.stats.splits.stat.powerPlaySavePercentage)) 
            currentPlayer$people.stats.splits.stat.powerPlaySavePercentage <- "NA"
         if(is.null(currentPlayer$people.stats.splits.stat.shortHandedSavePercentage)) 
            currentPlayer$people.stats.splits.stat.shortHandedSavePercentage <- "NA"
         if(is.null(currentPlayer$people.stats.splits.stat.evenStrengthSavePercentage)) 
            currentPlayer$people.stats.splits.stat.evenStrengthSavePercentage <- "NA"
         
         AllGoalieStats <- rbind(AllGoalieStats, currentPlayer)
         ## Add the current goalie to the list of goalie statistics
      }
   }
   #rm(currentPlayer)
}

#####

completedgames <- list()

for(i in 1:nrow(teamData)){
   completedGameData <- as.data.frame(jsonlite::fromJSON(paste(api,"/api/v1/schedule?teamId=", teamData$teams.id[i], "&startDate=2017-08-01&endDate=2018-08-01", sep = "")))
   completedgames[[i]] <- completedGameData
   rm(completedGameData)
}

currentGameData <- list()
completeGameData <- list()
gameList <- character()

for(i in 1:nrow(teamData)){
   for(j in 1:length(completedgames[[i]]$dates.games)){
      currentGameData[[j]] <- data.frame(matrix(unlist(completedgames[[i]]$dates.games[[j]]), nrow = 1, byrow = F))
      names(currentGameData[[j]]) <- names(unlist(completedgames[[i]]$dates.games[[j]]))
      gameList <- c(gameList,as.character(currentGameData[[j]]$gamePk[1]))
      
      if(is.null(currentGameData[[j]]$gamePk)) currentGameData[[j]]$gamePk <- "NA"
      if(is.null(currentGameData[[j]]$link)) currentGameData[[j]]$link <- "NA"
      if(is.null(currentGameData[[j]]$gameType)) currentGameData[[j]]$gameType <- "NA"
      if(is.null(currentGameData[[j]]$season)) currentGameData[[j]]$season <- "NA"
      if(is.null(currentGameData[[j]]$gameDate)) currentGameData[[j]]$gameDate <- "NA"
      if(is.null(currentGameData[[j]]$abstractGameState)) currentGameData[[j]]$abstractGameState <- "NA"
      if(is.null(currentGameData[[j]]$codedGameState)) currentGameData[[j]]$codedGameState <- "NA"
      if(is.null(currentGameData[[j]]$detailedState)) currentGameData[[j]]$detailedState <- "NA"
      if(is.null(currentGameData[[j]]$statusCode)) currentGameData[[j]]$statusCode <- "NA"
      if(is.null(currentGameData[[j]]$startTimeTBD)) currentGameData[[j]]$startTimeTBD <- "NA"
      if(is.null(currentGameData[[j]]$awayLeagueRecordWins)) currentGameData[[j]]$awayLeagueRecordWins <- "NA"
      if(is.null(currentGameData[[j]]$awayLeagueRecordLosses)) currentGameData[[j]]$awayLeagueRecordLosses <- "NA"
      if(is.null(currentGameData[[j]]$awayLeagueRecordOT)) currentGameData[[j]]$awayLeagueRecordOT <- "NA"
      if(is.null(currentGameData[[j]]$awayLeagueRecordType)) currentGameData[[j]]$awayLeagueRecordType <- "NA"
      if(is.null(currentGameData[[j]]$awayScore)) currentGameData[[j]]$awayScore <- "NA"
      if(is.null(currentGameData[[j]]$awayTeamID)) currentGameData[[j]]$awayTeamID <- "NA"
      if(is.null(currentGameData[[j]]$awayTeamName)) currentGameData[[j]]$awayTeamName <- "NA"
      if(is.null(currentGameData[[j]]$awayTeamLink)) currentGameData[[j]]$awayTeamLink <- "NA"
      if(is.null(currentGameData[[j]]$homeRecordWins)) currentGameData[[j]]$homeRecordWins <- "NA"
      if(is.null(currentGameData[[j]]$homeRecordLosses)) currentGameData[[j]]$homeRecordLosses <- "NA"
      if(is.null(currentGameData[[j]]$homeRecordOT)) currentGameData[[j]]$homeRecordOT <- "NA"
      if(is.null(currentGameData[[j]]$homeRecordType)) currentGameData[[j]]$homeRecordType <- "NA"
      if(is.null(currentGameData[[j]]$homeScore)) currentGameData[[j]]$homeScore <- "NA"
      if(is.null(currentGameData[[j]]$homeTeamID)) currentGameData[[j]]$homeTeamID <- "NA"
      if(is.null(currentGameData[[j]]$homeTeamName)) currentGameData[[j]]$homeTeamName <- "NA"
      if(is.null(currentGameData[[j]]$homeTeamLink)) currentGameData[[j]]$homeTeamLink <- "NA"
      if(is.null(currentGameData[[j]]$venueName)) currentGameData[[j]]$venueName <- "NA"
      if(is.null(currentGameData[[j]]$venueLink)) currentGameData[[j]]$venueLink <- "NA"
      if(is.null(currentGameData[[j]]$gameContentLink)) currentGameData[[j]]$gameContentLink <- "NA"
      if(is.null(currentGameData[[j]]$`NA`)) currentGameData[[j]]$`NA` <- "NA"      
   }
   completeGameData[[i]]<- currentGameData
   #names(completeGameData[[i]]) <- c("gamePk","link", "gameType", "season", "gameData",
   # "abstractGameState", "codedGameState", "detailedState","statusCode",
   # "startTimeTBD", "awayLeagueRecordWins", "awayLeagueRecordLosses",
   # "awayLeagueRecordOT","awayLeagueRecordType","awayScore","awayTeamID",
   # "awayTeamName","awayTeamLink","homeRecordWins", "homeRecordLosses",
   # "homeRecordOT", "homeRecordType", "homeScore", "homeTeamID","homeTeamName",
   # "homeTeamLink","venueName", "venueLink", "gameContentLink")
   # 
}
rm(completedGameData)
names(completeGameData) <- teamData$teams.name
gameList <- unique(gameList)
## Get information from feed live - has all plays in the game.
## https://statsapi.web.nhl.com/api/v1/game/2017010004/feed/live  (Flames vs Edmonton)
## 0,0 coordinates = Centre Ice

fullPlaybyPlay <- list()
results <- list()
about <- list()
coordinates <- list()
players <- list()
team <- list()

####

allGamePlays <- data.frame()

for(i in 1:length(gameList)){
   currentPlaybyPlay <- as.list(jsonlite::fromJSON(paste(api,"api/v1/game/", gameList[i], "/feed/live", sep = "")))
   
   if(!is.null(length(currentPlaybyPlay))){
      
      ## Gathers ALL data about the current game, which is intense
      # fullPlaybyPlay[[i]] <-currentPlaybyPlay$liveData
      ## Subsets that data into just the play-by-play (liveData) - which is less enormous - but still enormous
      fullPlaybyPlay[[i]] <- currentPlaybyPlay$liveData$plays$allPlays
      #names(fullPlaybyPlay[[i]]) <- names(unlist(currentPlaybyPlay$liveData))
      
      if(!is.null(currentPlaybyPlay$liveData$plays$allPlays$result)){
         currentResults <- data.frame(matrix(unlist(currentPlaybyPlay$liveData$plays$allPlays$result), nrow = nrow(currentPlaybyPlay$liveData$plays$allPlays$result)))
         if(ncol(currentResults) == 10){
            currentResults$X11 <- "NA"
         }
         names(currentResults) <- c("event", "eventCode", "eventTypeId","description", "secondaryType","penaltySeverity","penaltyMinutes","strength.code","strength.name","gameWinningGoal","emptyNet")
      }
      
      if(!is.null(currentPlaybyPlay$liveData$plays$allPlays$about)){
         currentAbout <- data.frame(matrix(unlist(currentPlaybyPlay$liveData$plays$allPlays$about), nrow = nrow(currentPlaybyPlay$liveData$plays$allPlays$about)))
         names(currentAbout) <- c("eventIdx","eventId","period","periodType","ordinalNum","periodTime","periodTimeRemaining","dateTime","goals.away","goals.home")
      }
      
      if(!is.null(currentPlaybyPlay$liveData$plays$allPlays$coordinates)){
         currentCoordinates <- currentPlaybyPlay$liveData$plays$allPlays$coordinates
      }
      
      if(!is.null(currentPlaybyPlay$liveData$plays$allPlays$players)){
         currentPlayers <- currentPlaybyPlay$liveData$plays$allPlays$players
      }
      
      if(!is.null(currentPlaybyPlay$liveData$plays$allPlays$team)){
         currentTeam <- currentPlaybyPlay$liveData$plays$allPlays$team
      }
      
      allPlayPlayers <- data.frame()
      for(j in 1: length(currentPlayers)){
         if(length(currentPlayers[[j]]) != 0){ 
            temp <- data.frame(matrix(unlist(currentPlayers[j]), nrow = 1))
            names(temp) <- names(unlist(currentPlayers[[j]]))
            if(names(temp)[1] == "player.id") names(temp) <- c("player.id1", "player.fullName1", "player.link1", "playerType1")
         } 
         if(length(currentPlayers[[j]]) == 0){
            temp <- data.frame(player.id1 = "NA", player.id2 = "NA")
         }
         
         if(is.null(temp$player.id1)) temp$player.id1 <- "NA"
         if(is.null(temp$player.id2)) temp$player.id2 <- "NA"
         if(is.null(temp$player.id3)) temp$player.id3 <- "NA"
         if(is.null(temp$player.id4)) temp$player.id4 <- "NA"
         if(is.null(temp$player.fullName1)) temp$player.fullName1 <- "NA"
         if(is.null(temp$player.fullName2)) temp$player.fullName2 <- "NA" 
         if(is.null(temp$player.fullName3)) temp$player.fullName3 <- "NA"
         if(is.null(temp$player.fullName4)) temp$player.fullName4 <- "NA"
         if(is.null(temp$player.link1)) temp$player.link1 <- "NA"
         if(is.null(temp$player.link2)) temp$player.link2 <- "NA"
         if(is.null(temp$player.link3)) temp$player.link3 <- "NA"
         if(is.null(temp$player.link4)) temp$player.link4 <- "NA"
         if(is.null(temp$playerType1)) temp$playerType1 <- "NA"
         if(is.null(temp$playerType2)) temp$playerType2 <- "NA" 
         if(is.null(temp$playerType3)) temp$playerType3 <- "NA"
         if(is.null(temp$playerType4)) temp$playerType4 <- "NA"
         if(is.null(temp$seasonTotal1)) temp$seasonTotal1 <- "NA"
         if(is.null(temp$seasonTotal2)) temp$seasonTotal2 <- "NA"
         if(is.null(temp$seasonTotal3)) temp$seasonTotal3 <- "NA"
         if(is.null(temp$seasonTotal4)) temp$seasonTotal4 <- "NA"
         
         temp <- temp[,c('player.id1','player.id2','player.id3','player.id4', 'player.fullName1', 'player.fullName2', 'player.fullName3', 'player.fullName4', 'player.link1', 'player.link2', 'player.link3', 'player.link4', 'playerType1', 'playerType2', 'playerType3', 'playerType4', 'seasonTotal1', 'seasonTotal2', 'seasonTotal3', 'seasonTotal4')]
         
         allPlayPlayers <- rbind(allPlayPlayers, temp)
      }
      
      allCurrent <- cbind(currentResults, currentAbout, currentCoordinates, currentTeam, allPlayPlayers)
      # rownames(allCurrent) <- c()
      if(is.null(allCurrent$x)) allCurrent$x <- "NA"
      if(is.null(allCurrent$y)) allCurrent$y <- "NA"
      
   }
   # if(exists('allCurrent')){
   allGamePlays <- rbind(allGamePlays, allCurrent)
   # rm(allCurrent)
   # }
}

allGamePlays$x <- as.numeric(allGamePlays$x)
allGamePlays$y <- as.numeric(allGamePlays$y)

allGamePlays$dateTime <- as.POSIXct(allGamePlays$dateTime, format = "%Y-%m-%dT%H:%M:%OSZ")

## Identify Games - Necessary for time-sensitive analysis
GameCount <- 0
for(i in 1:nrow(allGamePlays)){
   if(allGamePlays$event[i] == "Game Scheduled"){
      GameCount = GameCount + 1
      allGamePlays$GameCode[i] = GameCount
   } else {
      allGamePlays$GameCode[i] = GameCount
   }
}

# Get rid of plays that don't have coordinate information
allGamePlays <- allGamePlays[!is.na(allGamePlays$x),]

# Make the plays one-sided
for(i in 1:nrow(allGamePlays)){
   if(allGamePlays$x[i] < 0){
      allGamePlays$OneSidex[i] = abs(allGamePlays$x[i])
      allGamePlays$OneSidey[i] = -1 * allGamePlays$y[i]
   } else {
      allGamePlays$OneSidex[i] = allGamePlays$x[i]
      allGamePlays$OneSidey[i] = allGamePlays$y[i]
   }
}

source('ZoneDefinition.R')   ## Define the zones for analytical comparison
## Define the zones
for(i in 1:nrow(allGamePlays)){
   allGamePlays$ZoneName[i] = ZoneDefinition(allGamePlays$OneSidex[i], allGamePlays$OneSidey[i])
}

source('PlayerInfo.R')       ## Collect supplemental information about each player
# Players to be compared by handedness and position, need to append that information to the dataset.
PlayerDetails <- GetPlayerInfo(unique(AllPlays$player.link1))
saveRDS(PlayerDetails, "PlayerDetails.RDS")
keyDetails <- as.data.frame(cbind(as.numeric(as.character(PlayerDetails$people.id)),as.character(PlayerDetails$people.shootsCatches),as.character(PlayerDetails$people.primaryPosition.code)))
names(keyDetails) <- c("people.id","people.shootsCatches","people.primaryPosition.code")

allGamePlays <- merge(allGamePlays, keyDetails, by.x = 'player.id1', by.y = 'people.id')

allGamePlays$uid <- seq.int(nrow(allGamePlays))

saveRDS(allGamePlays, "FullPlay.RDS")
