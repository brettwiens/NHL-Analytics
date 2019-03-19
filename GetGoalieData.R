GoalieData <- AllPlays[AllPlays$playerType2 == "Goalie" | AllPlays$playerType3 == "Goalie" | AllPlays$playerType4 == "Goalie",]

for(i in 1:nrow(GoalieData)){
   if(GoalieData$playerType2[i] == "Goalie"){
      GoalieData$Goalie[i] <- GoalieData$player.fullName2[i]
   }
   if(GoalieData$playerType3[i] == "Goalie"){
      GoalieData$Goalie[i] <- GoalieData$player.fullName3[i]
   }
   if(GoalieData$playerType4[i] == "Goalie"){
      GoalieData$Goalie[i] <- GoalieData$player.fullName4[i]
   }
}

saveRDS(GoalieData, file = "GoalieData.RDS")

# GoalieData <- GoalieData[GoalieData$Goalie == "Sergei Bobrovsky",]
# GoalieData <- GoalieData[GoalieData$event == "Goal",]
# 
# 
# ggplot2::ggplot(GoalieData, mapping = aes(x = GoalieData$OneSidex, y = GoalieData$OneSidey, colour = GoalieData$event)) + geom_point()
# 
# OneSideDensityRinkPlot(GoalieData, currentTeamLogo)
