#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
data("USArrests")
USArrests$State <- row.names(USArrests)
usa <- USArrests

# Define UI for application 
shinyUI(fluidPage(
  
  # Application title
  titlePanel("State Arrests Analysis and Prediction (per 100,000)"),
  
  # Sidebar with a slider and text inputs
  sidebarLayout(
    sidebarPanel(
      h3("Choose Type of Arrest"),
       sliderInput("slider1","Choose Urban Population Range (in Percent to Total)", min(usa$UrbanPop), max(usa$UrbanPop),
                   value = c(min(usa$UrbanPop),max(usa$UrbanPop)),step = 2, round = 0),
      selectInput('metric','Choose Crime', names(usa[,c("Murder","Rape","Assault")])),
      h3("Enter in Urban Pop. % and Assualt Arrests for Rape Arrest Prediction"),
      textInput('urbanpopmet', "% Urban Population of a State (32-91)", placeholder = 32),
      textInput('assaultmet','Assault Arrest (0-300)', placeholder = 100)
    ),
    
    
    # Plot of the generated statistics and predicted number below it
    mainPanel(
      h1("State Metrics"),
      h5("(highlighted dot for highest value)"),
      plotOutput("stateplot"),
      h5("Prediction of Rape Arrests based on Assault Arrests and Urban Pop. Percentage"),
      h1(textOutput('text1'))
    )
  )
))
