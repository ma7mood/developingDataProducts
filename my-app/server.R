library(shiny)

library(tibble)
library(tidyr)
library(ggplot2)
library(ggthemes)

glb <- read.csv('GLB.Ts+dSST.csv', stringsAsFactors = FALSE)
glb[,2:13] <- sapply(glb[,2:13], as.numeric)


function(input, output) {
  
  output$plot <- renderPlot({
    cols <- colnames(glb)[2:13]
    glb_long <- gather(glb,key='Month',value='Temperature_Anomaly', cols)
    glb_long$Temperature_Anomaly <- as.numeric(glb_long$Temperature_Anomaly)
    glb_long$Month <- factor(glb_long$Month, levels = cols)
    modified_glb_long <- glb_long[glb_long$Year > input$rangeYears[1] & glb_long$Year < input$rangeYears[2],]
    g <- ggplot(modified_glb_long, aes(x=Year,y=Temperature_Anomaly)) + 
      geom_point() + facet_wrap(~Month)
    if (input$smoother) {
      g <- g + geom_smooth(aes(color=Month), show.legend = FALSE)
    }
    
    print(g)
  })
}