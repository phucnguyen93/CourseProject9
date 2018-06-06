library(shiny)
shinyServer(function(input, output) {
  model <- lm(weight ~ height, data = women)
  modelPredict <- reactive({
    heightInput <- input$slider
    predict(model, newdata = data.frame(height = heightInput))
  })
  output$distPlot <- renderPlot({
    xlab <- ifelse(input$showXlab, "Height (inches)", "")
    ylab <- ifelse(input$showYlab, "Weight (pounds)", "")
    main <- ifelse(input$showTitle, "Average Heights and Weights for American Women", "")
    plot(women$height, women$weight, main = main,xlab = xlab, ylab = ylab, xlim = c(50, 80), ylim = c(75, 190))
    if (input$showModel) {
      abline(model, col = "red", lwd = 2)
    }
    points(input$slider, modelPredict(), col = "blue", pch = 16, cex = 2)
  })
  output$pred = renderText({
    modelPredict()
  })
  output$averageHeight <- reactive({
    brushedData <- brushedPoints(women, input$brush1, xvar = "height", yvar = "weight")
    if (nrow(brushedData) < 1) {
      return(0)
    } else {
      return(mean(brushedData$height))
    }
  })
})