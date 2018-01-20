data()
head(USArrests)
library(ggplot2)
library(dplyr)
USArrests$State <- row.names(USArrests)
g <- ggplot(USArrests, aes(x=Murder, y = State))+
  geom_point()

g + facet_grid(.~UrbanPop)

range(USArrests$UrbanPop)



minpop <- 80
maxpop <- 91
dataA <- subset(usa, UrbanPop >= minpop & UrbanPop <= maxpop)
dataB <- dataA[ ,c("State","Murder")]
ggplot(data2, aes(x=State, y = Murder))+
  geom_point()
dataA
names(dataB)
dataC <- subset(dataB, dataB[ ,"Murder"]==max(dataB[,"Murder"]))
dataC

           
library(randomForest)   
usa <- tibble::rownames_to_column(usa, "Name")
usa$State <- as.(usa$State)
staterf <- randomForest(UrbanPop ~ Murder + Rape + Assault, data = usa, type = 'class')


statemodel <- lm(Rape ~  Assault + UrbanPop, data = usa)

murder <- 10
rape <- 50
assault <- 250
urbanpop <- 91
newdf <- data.frame(assault,urbanpop)

mod <- predict(statemodel, newdata = usa)
usa
staterf
summary(statemodel)
predict(statemodel, newdata = data.frame(UrbanPop = urbanpop, Assault = assault))
        
round(predict(statemodel, newdata = data.frame(UrbanPop = urbanpop, Assault = assault)),0)

assault <- as.integer(assault)
urbanpop <- as.integer(urbanpop)
urbanpop
class(assault)
