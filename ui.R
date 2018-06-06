library(shiny)
shinyUI(fluidPage(
  titlePanel("Predicted Weight (pounds) of American Woman"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("slider", "What is her height (inches)?",
                  50, 80, value = 60),
      checkboxInput("showXlab", "Show/Hide Height Label", value = TRUE),
      checkboxInput("showYlab", "Show/Hide Weight Label", value = TRUE),
      checkboxInput("showTitle", "Show/Hide Title", value = TRUE),
      checkboxInput("showModel", "Show Model", value = TRUE)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h4("Grab over some points to calculate average height"),
      plotOutput("distPlot", brush = brushOpts(id = "brush1")),
      h5("Predicted Weight (pounds) of a American Woman from Input Height (inches)"),
      textOutput("pred"),
      h5("Average height in brushed area"),
      textOutput("averageHeight")
    )
  )
))