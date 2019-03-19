library(ggplot2)

## Full Arena ####

Full.Arena <- ggplot2::ggplot() +
   ## Rink Geometry
   ## Centre Red Line
   geom_segment(aes(x = 0, xend = 0, y = -42.5, yend = 42.5), colour = "red", linetype = 'dashed', size = 1) +
   ## Zone Lines
   geom_segment(aes(x = 25, xend = 25, y = -42.5, yend = 42.5), colour = "blue", size = 1.1) +   ## Attacking End
   geom_segment(aes(x = -25, xend = -25, y = -42.5, yend = 42.5), colour = "blue", size = 1.1) + ## Defensive End
   ## Goal Lines
   geom_segment(aes(x = 89, xend = 89, y = -42.5, yend = 42.5), colour = "red", size = 0.5) +    ## Attacking End 
   geom_segment(aes(x = -89, xend = -89, y = -42.5, yend = 42.5), colour = "red", size = 0.5) +  ## Defensive End
   ## Faceoff Spots
   ## geom_point(aes(x = 0, y = 0), size = 25, colour = "blue", shape = 1) + ## Centre Ice (Not Regulated)
   geom_point(aes(x = 0, y = 0), size = 2, colour = "blue") +             ## Centre Ice Faceoff Spot
   geom_point(aes(x = 20, y = 22), size = 2, colour = "red") +            ## Neutral Zone Attacking Top
   geom_point(aes(x = -20, y = 22), size = 2, colour = "red") +           ## Neutral Zone Defensive Top 
   geom_point(aes(x = -20, y = -22), size = 2, colour = "red") +          ## Neutral Zone Defensive Bottom 
   geom_point(aes(x = 20, y = -22), size = 2, colour = "red") +           ## Neutral Zone Attacking Bottom
   geom_point(aes(x = 69, y = 22), size = 2, colour = "red") +            ## Attacking Zone Top
   geom_point(aes(x = -69, y = 22), size = 2, colour = "red") +           ## Defensive Zone Top
   geom_point(aes(x = -69, y = -22), size = 2, colour = "red") +          ## Defensive Zone Bottom
   geom_point(aes(x = 69, y = -22), size = 2, colour = "red") +           ## Attacking Zone Bottom
   ## Attacking Zone Top Faceoff Circle
   geom_curve(aes(x = 54, xend = 84, y = 22, yend = 22), curvature = -1, colour = "red") +
   geom_curve(aes(x = 54, xend = 84, y = 22, yend = 22), curvature = 1, colour = "red") +
   ## Defensive Zone Top Faceoff Circle
   geom_curve(aes(x = -54, xend = -84, y = 22, yend = 22), curvature = -1, colour = "red") +
   geom_curve(aes(x = -54, xend = -84, y = 22, yend = 22), curvature = 1, colour = "red") +
   ## Attacking Zone Bottom Faceoff Circle
   geom_curve(aes(x = 54, xend = 84, y = -22, yend = -22), curvature = -1, colour = "red") +
   geom_curve(aes(x = 54, xend = 84, y = -22, yend = -22), curvature = 1, colour = "red") +
   ## Defensive Zone Bottom Faceoff Circle
   geom_curve(aes(x = -54, xend = -84, y = -22, yend = -22), curvature = -1, colour = "red") +
   geom_curve(aes(x = -54, xend = -84, y = -22, yend = -22), curvature = 1, colour = "red") +
   ## Creases
   geom_curve(aes(x = 89, xend = 89, y = -4, yend = 4), curvature = -1, colour = "red") +  ## Attacking Crease
   geom_curve(aes(x = -89, xend = -89, y = -4, yend = 4), curvature = 1, colour = "red") + ## Defensive Crease
   ## Boards
   geom_curve(aes(x = -91.5, xend = -100, y = 42.5, yend = 34), colour = "black", curvature = 0.33, size = 1.6) +
   geom_curve(aes(x = -100, xend = -91.5, y = -34, yend = -42.5), colour = "black", curvature = 0.33, size = 1.6) +
   geom_curve(aes(x = 91.5, xend = 100, y = -42.5, yend = -34), colour = "black", curvature = 0.33, size = 1.6) +
   geom_curve(aes(x = 100, xend = 91.5, y = 34, yend = 42.5), colour = "black", curvature = 0.33, size = 1.6) +
   geom_segment(aes(x = -91.5, xend = 91.5, y = 42.5, yend = 42.5), colour = "black", size = 1.6) +
   geom_segment(aes(x = -91.5, xend = 91.5, y = -42.5, yend = -42.5), colour = "black", size = 1.6) +
   geom_segment(aes(x = 100, xend = 100, y = -34, yend = 34), colour = "black", size = 1.6) +
   geom_segment(aes(x = -100, xend = -100, y = -34, yend = 34), colour = "black", size = 1.6) +
   ## Top Right Hash Marks
   geom_segment(aes(x = 71, xend = 71, y = 22.75, yend = 25.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = 67, xend = 67, y = 22.75, yend = 25.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = 71, xend = 71, y = 21.25, yend = 18.25), colour = "red", size = 0.5) +
   geom_segment(aes(x = 67, xend = 67, y = 21.25, yend = 18.25), colour = "red", size = 0.5) +
   geom_segment(aes(x = 67, xend = 63, y = 22.75, yend = 22.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = 75, xend = 71, y = 22.75, yend = 22.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = 67, xend = 63, y = 21.25, yend = 21.25), colour = "red", size = 0.5) +
   geom_segment(aes(x = 75, xend = 71, y = 21.25, yend = 21.25), colour = "red", size = 0.5) +
   ## Bottom Right Hash Marks
   geom_segment(aes(x = 71, xend = 71, y = -22.75, yend = -25.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = 67, xend = 67, y = -22.75, yend = -25.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = 71, xend = 71, y = -21.25, yend = -18.25), colour = "red", size = 0.5) +
   geom_segment(aes(x = 67, xend = 67, y = -21.25, yend = -18.25), colour = "red", size = 0.5) +
   geom_segment(aes(x = 67, xend = 63, y = -22.75, yend = -22.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = 75, xend = 71, y = -22.75, yend = -22.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = 67, xend = 63, y = -21.25, yend = -21.25), colour = "red", size = 0.5) +
   geom_segment(aes(x = 75, xend = 71, y = -21.25, yend = -21.25), colour = "red", size = 0.5) +
   ## Bottom Left Hash Marks
   geom_segment(aes(x = -71, xend = -71, y = -22.75, yend = -25.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = -67, xend = -67, y = -22.75, yend = -25.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = -71, xend = -71, y = -21.25, yend = -18.25), colour = "red", size = 0.5) +
   geom_segment(aes(x = -67, xend = -67, y = -21.25, yend = -18.25), colour = "red", size = 0.5) +
   geom_segment(aes(x = -67, xend = -63, y = -22.75, yend = -22.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = -75, xend = -71, y = -22.75, yend = -22.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = -67, xend = -63, y = -21.25, yend = -21.25), colour = "red", size = 0.5) +
   geom_segment(aes(x = -75, xend = -71, y = -21.25, yend = -21.25), colour = "red", size = 0.5) +
   ## Top Left Hash Marks
   geom_segment(aes(x = -71, xend = -71, y = 22.75, yend = 25.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = -67, xend = -67, y = 22.75, yend = 25.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = -71, xend = -71, y = 21.25, yend = 18.25), colour = "red", size = 0.5) +
   geom_segment(aes(x = -67, xend = -67, y = 21.25, yend = 18.25), colour = "red", size = 0.5) +
   geom_segment(aes(x = -67, xend = -63, y = 22.75, yend = 22.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = -75, xend = -71, y = 22.75, yend = 22.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = -67, xend = -63, y = 21.25, yend = 21.25), colour = "red", size = 0.5) +
   geom_segment(aes(x = -75, xend = -71, y = 21.25, yend = 21.25), colour = "red", size = 0.5) +
   ## Left Trapezoid
   geom_segment(aes(x = -89, xend = -100, y = 9, yend = 14), colour = "red", size = 0.5) + 
   geom_segment(aes(x = -89, xend = -100, y = -9, yend = -14), colour = "red", size = 0.5) + 
   ## Right Trapezoid
   geom_segment(aes(x = 89, xend = 100, y = 9, yend = 14), colour = "red", size = 0.5) + 
   geom_segment(aes(x = 89, xend = 100, y = -9, yend = -14), colour = "red", size = 0.5) + 
   theme(legend.position = 'none', axis.text.x = element_blank(), axis.text.y = element_blank(),
         axis.title = element_blank(), axis.ticks = element_blank())

## One Side Arena ####

One.Side.Arena <- ggplot2::ggplot() +
   ## Rink Geometry
   ## Centre Red Line
   geom_segment(aes(x = 0, xend = 0, y = -42.5, yend = 42.5), colour = "red", linetype = 'dashed', size = 1) +
   ## Zone Lines
   geom_segment(aes(x = 25, xend = 25, y = -42.5, yend = 42.5), colour = "blue", size = 1.1) +   ## Attacking End
   ## Goal Lines
   geom_segment(aes(x = 89, xend = 89, y = -42.5, yend = 42.5), colour = "red", size = 0.5) +    ## Attacking End 
   ## Faceoff Spots
   geom_point(aes(x = 0, y = 0), size = 2, colour = "blue") +             ## Centre Ice Faceoff Spot
   geom_point(aes(x = 20, y = 22), size = 2, colour = "red") +            ## Neutral Zone Attacking Top
   geom_point(aes(x = 20, y = -22), size = 2, colour = "red") +           ## Neutral Zone Attacking Bottom
   geom_point(aes(x = 69, y = 22), size = 2, colour = "red") +            ## Attacking Zone Top
   geom_point(aes(x = 69, y = -22), size = 2, colour = "red") +           ## Attacking Zone Bottom
   ## Attacking Zone Top Faceoff Circle
   geom_curve(aes(x = 54, xend = 84, y = 22, yend = 22), curvature = -1, colour = "red") +
   geom_curve(aes(x = 54, xend = 84, y = 22, yend = 22), curvature = 1, colour = "red") +
   ## Attacking Zone Bottom Faceoff Circle
   geom_curve(aes(x = 54, xend = 84, y = -22, yend = -22), curvature = -1, colour = "red") +
   geom_curve(aes(x = 54, xend = 84, y = -22, yend = -22), curvature = 1, colour = "red") +
   ## Creases
   geom_curve(aes(x = 89, xend = 89, y = -4, yend = 4), curvature = -1, colour = "red") +  ## Attacking Crease
   ## Boards
   geom_curve(aes(x = 91.5, xend = 100, y = -42.5, yend = -34), colour = "black", curvature = 0.33, size = 1.6) +
   geom_curve(aes(x = 100, xend = 91.5, y = 34, yend = 42.5), colour = "black", curvature = 0.33, size = 1.6) +
   geom_segment(aes(x = 0, xend = 91.5, y = 42.5, yend = 42.5), colour = "black", size = 1.6) +
   geom_segment(aes(x = 0, xend = 91.5, y = -42.5, yend = -42.5), colour = "black", size = 1.6) +
   geom_segment(aes(x = 100, xend = 100, y = -34, yend = 34), colour = "black", size = 1.6) +
   ## Top Right Hash Marks
   geom_segment(aes(x = 71, xend = 71, y = 22.75, yend = 25.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = 67, xend = 67, y = 22.75, yend = 25.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = 71, xend = 71, y = 21.25, yend = 18.25), colour = "red", size = 0.5) +
   geom_segment(aes(x = 67, xend = 67, y = 21.25, yend = 18.25), colour = "red", size = 0.5) +
   geom_segment(aes(x = 67, xend = 63, y = 22.75, yend = 22.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = 75, xend = 71, y = 22.75, yend = 22.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = 67, xend = 63, y = 21.25, yend = 21.25), colour = "red", size = 0.5) +
   geom_segment(aes(x = 75, xend = 71, y = 21.25, yend = 21.25), colour = "red", size = 0.5) +
   ## Bottom Right Hash Marks
   geom_segment(aes(x = 71, xend = 71, y = -22.75, yend = -25.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = 67, xend = 67, y = -22.75, yend = -25.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = 71, xend = 71, y = -21.25, yend = -18.25), colour = "red", size = 0.5) +
   geom_segment(aes(x = 67, xend = 67, y = -21.25, yend = -18.25), colour = "red", size = 0.5) +
   geom_segment(aes(x = 67, xend = 63, y = -22.75, yend = -22.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = 75, xend = 71, y = -22.75, yend = -22.75), colour = "red", size = 0.5) +
   geom_segment(aes(x = 67, xend = 63, y = -21.25, yend = -21.25), colour = "red", size = 0.5) +
   geom_segment(aes(x = 75, xend = 71, y = -21.25, yend = -21.25), colour = "red", size = 0.5) +
   ## Right Trapezoid
   geom_segment(aes(x = 89, xend = 100, y = 9, yend = 14), colour = "red", size = 0.5) + 
   geom_segment(aes(x = 89, xend = 100, y = -9, yend = -14), colour = "red", size = 0.5) + 
   theme(legend.position = 'none', axis.text.x = element_blank(), axis.text.y = element_blank(),
         axis.title = element_blank(), axis.ticks = element_blank())
