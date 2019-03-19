require(jsonlite); library(dplyr); library(ggplot2); library(ggforce)

GetPlayerInfo <- function(PlayerList){
   api <- "https://statsapi.web.nhl.com/"
   
   # teamData <- as.data.frame(jsonlite::fromJSON(paste(api, "api/v1/teams")))  ## Read the team data 
   # teamData <- teamData[,-1]
   # 
   # teamList <- character()
   # rosters <- list()
   # 
   # for(i in 1:nrow(teamData)){
   #    # CurrentTeam <- teamData$teams.franchise$teamName[i]
   #    rosterData <- as.data.frame(jsonlite::fromJSON(paste(api,teamData$teams.link[i],"/roster", sep = "")))
   #    rosterData$Team <- teamData$teams.name[i]
   #    rosters[[i]] <- rosterData[,-1]
   #    rm(rosterData)
   # }
   # 
   # AllPlayers <- data.frame()
   # 
   # for(i in 1:nrow(teamData)){
   #    CurrentTeam <- data.frame(matrix(unlist(rosters[[i]]), nrow=nrow(rosters[[i]]), byrow=F))
   #    AllPlayers <- rbind(AllPlayers, CurrentTeam)
   #    rm(CurrentTeam)
   # }
   # names(AllPlayers) <- c("ID", "Name", "Link","Number","PosL","Position", "GDF", "POSL2","Active", "Team")
   # 
   PlayerList <- PlayerList[PlayerList != "NA"]
   
   players <- list()
   
   for(i in 1:length(PlayerList)){
      # CurrentPlayer <- AllPlayers$Name[i]
      playerData <- as.data.frame(jsonlite::fromJSON(paste(api,PlayerList[i], sep = "")))
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
   return(AllPlayerInfo)
}
