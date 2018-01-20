#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)


# Define server logic required to draw a plot of arrest statistics
shinyServer(function(input, output) {
  
  #Pulling and manipulating base data
  data("USArrests")
  #Need row names to be its own columns for understanding the state
  USArrests$State <- row.names(USArrests)
  #assign as a new dataset for easier coding
  usa <- USArrests

  #Generating new plot
  output$stateplot <- renderPlot({
    #Inputs
  minpop <- input$slider1[1]
  maxpop <- input$slider1[2]
    #Manipulation to only get the relevant data/states from inputs
  data1 <- subset(usa, UrbanPop >= minpop & UrbanPop <= maxpop)
  data2 <- subset(data1, names(data1)==c("State",input$metric))
  data3 <- subset(data2, data2[ ,input$metric]==max(data2[,input$metric]))
    #Generating the plot
  ggplot(data2, aes(x=data2[,input$metric], y = State, xlim(0,300)))+
    geom_point()+
    xlab(paste(input$metric," Arrests"))+
    ylab("State (A-Z)")+
    theme_classic()+
    theme(legend.position = "none")+
    geom_point(data = data3, aes(x=data3[ ,input$metric], y = State, col = 'red', 
                                 size = 5))
    
  })
  
  #Generate reactive text based on linear regression
  text1 <- reactive({
    #Building the model
    statemodel <- lm( Rape ~ Assault + UrbanPop, data = usa)
    #Inputs
    urbanpop <- as.integer(input$urbanpopmet)
    assault <- as.integer(input$assaultmet)
    #Predictive model
    rapeval<- round(predict(statemodel, 
                           newdata = data.frame(UrbanPop = urbanpop, Assault = assault)),
                   0)
    rapeval
  })
  #Output text from predictive model
  output$text1 <- renderText(paste({text1()}," Predicted Rape Arrests"))
    

  
})
