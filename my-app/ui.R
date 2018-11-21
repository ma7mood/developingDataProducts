library(shiny)


glb <- read.csv('GLB.Ts+dSST.csv', stringsAsFactors = FALSE)
glb[,2:13] <- sapply(glb[,2:13], as.numeric)


randYear <- round(runif(1, 1880, 1950), 0)
randYear2 <- round(runif(1,1950, 2018), 0)
minYear <- min(glb$Year)
maxYear <- max(glb$Year)


fluidPage(
  headerPanel("Temperature Rise over the years"),
  sidebarPanel(
    p("The inputs here, reactively update the plot"),
    checkboxInput(inputId = "smoother", "Add A Smoother to Observe Trend", TRUE),
    sliderInput(inputId = "rangeYears", 
                label = "Choose a range of years", 
                value = c(randYear, randYear2),
                min = minYear, 
                max = maxYear,
                dragRange = TRUE
    )
  ),
  mainPanel(
    p("The plot shows the surface temperature change over the years for each month"),
    plotOutput("plot")
  )
)