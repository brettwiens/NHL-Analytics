## GoalTime
## The purpose of this script is to identify:
## All of the goals scored.
## All of the plays that preceed those goals by a defined period of time.  (Default = 5 seconds)

library(lubridate)
# 
# test <- allGamePlays
# testGoals <- test[test$event == "Goal",]
# testShots <- test[grepl("Shot",test$event),]
# GoalTimes <- testGoals$dateTime
# GoalGames <- testGoals$GameCode
# GoalTimeStarts <- testGoals$dateTime - 5
# GoalTimeEnds <- testGoals$dateTime
# 
# GoalTime5 <- GoalTimes - 5
# GoalTime4 <- GoalTimes - 4
# GoalTime3 <- GoalTimes - 3
# GoalTime2 <- GoalTimes - 2
# GoalTime1 <- GoalTimes - 1
# GoalTime <- c(GoalTimes, GoalTime1, GoalTime2, GoalTime3, GoalTime4, GoalTime5)
# 
# GoalInterval <- interval(GoalTimeStarts, GoalTimes)
# Goals <- data.frame(GoalTimes, GoalTimeStarts, GoalGames, GoalInterval)
# 
# # testPlays <- test[test$dateTime %within% GoalInterval[1],]
# 
# GoalShots <- testShots[testShots$dateTime %in% GoalTime,]
# 
# testPlays <- test[test$dateTime %in% GoalTime,]
# 
# testNew <- testPlays[testPlays$event != "Goal",]
# 
# testP <- testPlays[!duplicated(testPlays),]

ShotGeneratingGoals <- function(events){
   eventGoals <- events[events$event == "Goal",]
   eventShots <- events[grepl("Shot", events$event),]
   GoalTimes <- c(eventGoals$dateTime, eventGoals$dateTime - 1, eventGoals$dateTime - 2, eventGoals$dateTime - 3, 
                  eventGoals$dateTime - 4, eventGoals$dateTime - 5, eventGoals$dateTime - 6, eventGoals$dateTime - 7)
   GoalShots <- eventShots[eventShots$dateTime %in% GoalTimes,]
   
   return(GoalShots)
}
