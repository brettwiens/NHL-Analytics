ZoneDefinition <- function(X,Y){
   if(Y > 0) {
      Side = "Left"
   } else {
      Side = "Right"
   }
   
   if(X <= 25) {
      Zone = "Neutral"
   } else if (X > 89) {
      Zone = "Behind Net"
   } else if(X <= 45 & (Y > 12 | Y <= -12)) {
      Zone = "Outside Point"
   } else if(X <= 55 & Y <= 12 & Y > -12) {
      Zone = "Inside Point"
   # } else if(X <= 55 & Y > -12 & Y <= 12) {
   #    Zone = "Low Point"
   } else if(X <= 55) {
      Zone = "Shallow Point"
   } else if(X > 75 & (Y > 18 | Y <= -18)) {
      Zone = "Sharp"
   } else if(X > 75 & ((Y > 10 & Y <= 18) | (Y <= -10 & Y > -18))) {
      Zone = "Wing"
   } else if(X > 81) {
      Zone = "Crease"
   } else if(X > 75) {
      Zone = "Slot"
   } else if(Y > -10 & Y <= 10){
      Zone = "High Slot"
   } else if((Y <= 22 & Y > 10) | (Y > -22 & Y <= -10)){
      Zone = "Inside Faceoff Circle"
   } else {
      Zone = "Outside Faceoff Circle"
   }
   
   return(paste(Side, Zone, sep = " "))
}

## zone is a polygon generation data frame to be used alongside geom_polygon(aes(group = Zone))
zone = data.frame(
   Zone = c("Left Neutral","Left Neutral","Left Neutral","Left Neutral",
            "Right Neutral","Right Neutral","Right Neutral","Right Neutral",
            "Left Behind Net","Left Behind Net","Left Behind Net","Left Behind Net",
            "Right Behind Net","Right Behind Net","Right Behind Net","Right Behind Net",
            "Left Crease","Left Crease","Left Crease","Left Crease",
            "Right Crease","Right Crease","Right Crease","Right Crease",
            "Left Slot","Left Slot","Left Slot","Left Slot",
            "Right Slot","Right Slot","Right Slot","Right Slot",
            "Left High Slot","Left High Slot","Left High Slot","Left High Slot",
            "Right High Slot","Right High Slot","Right High Slot","Right High Slot",
            "Left Sharp","Left Sharp","Left Sharp","Left Sharp",
            "Right Sharp","Right Sharp","Right Sharp","Right Sharp",
            "Left Wing","Left Wing","Left Wing","Left Wing",
            "Right Wing","Right Wing","Right Wing","Right Wing",
            "Left Outside Point","Left Outside Point","Left Outside Point","Left Outside Point",
            "Right Outside Point","Right Outside Point","Right Outside Point","Right Outside Point",
            "Left Inside Point","Left Inside Point","Left Inside Point","Left Inside Point",
            "Right Inside Point","Right Inside Point","Right Inside Point","Right Inside Point",
            "Left Outside Faceoff Circle","Left Outside Faceoff Circle","Left Outside Faceoff Circle","Left Outside Faceoff Circle",
            "Right Outside Faceoff Circle","Right Outside Faceoff Circle","Right Outside Faceoff Circle","Right Outside Faceoff Circle",
            "Left Shallow Point","Left Shallow Point","Left Shallow Point","Left Shallow Point",
            "Right Shallow Point","Right Shallow Point","Right Shallow Point","Right Shallow Point",
            "Left Inside Faceoff Circle","Left Inside Faceoff Circle","Left Inside Faceoff Circle","Left Inside Faceoff Circle",
            "Right Inside Faceoff Circle","Right Inside Faceoff Circle","Right Inside Faceoff Circle","Right Inside Faceoff Circle"),
   x = c(0,0,25,25,     ## Left Neutral
         0,0,25,25,     ## Right Neutral
         89,89,100,100, ## Left Behind Net
         89,89,100,100, ## Right Behind Net
         81,81,89,89,   ## Left Crease
         81,81,89,89,   ## Right Crease
         75,75,81,81,   ## Left Slot
         75,75,81,81,   ## Right Slot
         55,55,75,75,   ## Left High Slot
         55,55,75,75,   ## Right High Slot
         75,75,89,89,   ## Left Sharp
         75,75,89,89,   ## Right Sharp
         75,75,89,89,   ## Left Wing
         75,75,89,89,   ## Right Wing
         25,25,45,45,   ## Left Outside Point
         25,25,45,45,   ## Right Outside Point
         25,25,55,55,   ## Left Inside Point
         25,25,55,55,   ## Right Inside Point
         55,55,75,75,   ## Left Outside Faceoff
         55,55,75,75,   ## Right Outside Faceoff
         45,45,55,55,   ## Left Shallow Point
         45,45,55,55,   ## Right Shallow Point
         55,55,75,75,   ## Left Inside Faceoff
         55,55,75,75    ## Right Inside Faceoff
   ), 
   y = c(42.5,0,0,42.5,         ## Left Neutral
         0,-42.5,-42.5,0,       ## Right Neutral
         42.5,0,0,42.5,         ## Left Behind Net
         0,-42.5,-42.5,0,       ## Right Behind Net
         10,0,0,10,             ## Left Crease
         0,-10,-10,0,           ## Right Crease
         10,0,0,10,             ## Left Slot
         0,-10,-10,0,           ## Right Slot
         10,0,0,10,             ## Left High Slot
         0,-10,-10,0,           ## Right High Slot
         42.5,18,18,42.5,       ## Left Sharp
         -18,-42.5,-42.5,-18,   ## Right Sharp
         18,10,10,18,           ## Left Wing
         -10,-18,-18,-10,       ## Right Wing
         42.5,12,12,42.5,       ## Left Outside Point
         -12,-42.5,-42.5,-12,   ## Right Outside Point
         12,0,0,12,             ## Left Inside Point
         0,-12,-12,0,           ## Right Inside Point
         42.5,22,22,42.5,       ## Left Outside Faceoff
         -42.5,-22,-22,-42.5,   ## Right Outside Faceoff
         42.5,12,12,42.5,       ## Left Shallow Point
         -12,-42.5,-42.5,-12,   ## Right Shallow Point
         22,10,10,22,           ## Left Inside Faceoff
         -22,-10,-10,-22        ## Right Inside Faceoff
   )  
)

## Zone Labels Defines the X and Y locations at the middle of each offensive zone where labels will be placed.
ZoneLabels <- data.frame(
   Zone = c("Left Neutral","Right Neutral","Left Behind Net","Right Behind Net","Left Crease","Right Crease",
            "Left Slot","Right Slot","Left High Slot","Right High Slot","Left Sharp","Right Sharp",
            "Left Wing","Right Wing","Left Outside Point","Right Outside Point","Left Inside Point","Right Inside Point",
            "Left Outside Faceoff Circle","Right Outside Faceoff Circle","Left Inside Faceoff Circle","Right Inside Faceoff Circle","Left Shallow Point","Right Shallow Point"),
   X = c(12,12,93,93,85,85,
         77,77,65,65,82,82,
         82,82,35,35,40,40,
         65,65,65,65,50,50),
   Y = c(20,-20,20,-20,5,-5,
         5,-5,5,-5,30,-30,
         14,-14,35,-35,6,-6,
         30,-30,18,-18,25,-25)
)
