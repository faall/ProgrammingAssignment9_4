#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Italian Olive Oil Identifier"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("Palmitic",
                   "Palmitic:",
                   min = 600,
                   max = 1800,
                   value = 1085),
       sliderInput("Stearic",
                   "Stearic:",
                   min = 150,
                   max = 400,
                   value = 180),
       sliderInput("Linoleic",
                   "Linoleic:",
                   min = 440,
                   max = 1500,
                   value = 605),
       sliderInput("Arachidic",
                   "Arachidic:",
                   min = 0,
                   max = 110,
                   value = 50),
       sliderInput("Eicosenoic",
                   "Eicosenoic:",
                   min = 1,
                   max = 60,
                   value = 1),
       actionButton("goButton", "Go!")
    ),
    
    # Creat a tabbed main panel, one tab to show output with map, other tab with help.
    mainPanel(
          tabsetPanel(
                tabPanel("Results",
                         h2(textOutput("area")),
                         htmlOutput("italyMap")
                ),
                tabPanel("Help",
                         h3("Funtionality"),
                         p("This app finds the production area of an olive oil sample based on some of its components amounts."),
                         p("After entering the values for the fatty acids the app will indicate the production area and highlight in the map the italian province where the area is located"),
                         h3("How to Use"),
                         p("Move the sliders in the left panel to set the values of each fatty acid."),
                         p("Press ", strong("Go!"), " to update de Area name and the map."),
                         h3("Try it with some real values!"),
                         p("Do not mind if you cannot set the exact value!"),
                         br(),
                         p("Palmitic: 1116"),
                         p("Stearic: 231"),
                         p("Linoleic: 1168"),
                         p("Arachidic: 66"),
                         p("Eicosenoic: 1"),
                         p(strong("Inland Sardinia")),
                         h3("Take a look inside"),
                         p("If you would like to know more about this app press ", a(href="","here"))
                         )
          )
    )
  )
))
