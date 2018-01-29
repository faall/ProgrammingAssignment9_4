#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(googleVis)
library(gbm)
library(plyr)
library(caret)

# Load the olive oil fitted model
load("model.rda")

# https://en.wikipedia.org/wiki/ISO_3166-2:IT
areaMap <- read.csv("italy_regions.csv")

# Define server logic
shinyServer(function(input, output) {
      
      areaText <- function(){
            newOil <- data.frame(Palmitic = input$Palmitic, 
                                  Stearic = input$Stearic,
                                  Linoleic = input$Linoleic,
                                  Arachidic = input$Arachidic,
                                  Eicosenoic = input$Eicosenoic
                                 )
            
            predArea <- predict(gbm3, newOil)
            as.character(predArea)
      }
      
      output$area <- renderText({
            input$goButton
            isolate(areaText())
      })
      
      output$italyMap <- renderGvis({
            input$goButton
            area <- isolate(areaText())
            
            splitName <- unlist(strsplit(area, " "))
            
            plotName <- if(length(splitName) > 1) splitName[2] else splitName[1]
            
            plotCode <- areaMap[areaMap[,3] == plotName,]  
            
            gvisGeoChart(plotCode, 
                            locationvar = "code", 
                            hovervar = "english",
                            options=list(region="IT", 
                                         displayMode="regions", 
                                         resolution="provinces"
                                         )
                            )
      
      })
  
})
