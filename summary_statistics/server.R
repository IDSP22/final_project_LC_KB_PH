library(shiny)
# Other useful packages
#library(datasets)
library(rpart)
library(party)
library(fpc)

# Define colors
palette(c("#E73032", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFDD33", "#A65628", "#F781BF", "#999999"))

# Define server logic 
shinyServer(function(input, output) {
  
  datasetInput <- reactive({
    switch(input$dataset,
           "all iris data" = iris,
           "setosa" = subset(iris, iris$Species == "setosa"),
           "versicolor" = subset(iris, iris$Species == "versicolor"),
           "virginica" = subset(iris, iris$Species == "virginica"))
  })
  
  colX <- reactive({
    switch(input$Xvar,
           "Sepal.Length" = iris$Sepal.Length,
           "Sepal.Width" = iris$Sepal.Width,
           "Petal.Length" = iris$Petal.Length,
           "Petal.Width" = iris$Petal.Width)
  })
  
  colY <- reactive({
    switch(input$Yvar,
           "Sepal.Length" = iris$Sepal.Length,
           "Sepal.Width" = iris$Sepal.Width,
           "Petal.Length" = iris$Petal.Length,
           "Petal.Width" = iris$Petal.Width)
  })
  
  
  myColors <- reactive({
    switch(input$dataset,
           "all iris data" = c(palette()[1],palette()[2],palette()[3]),
           "setosa" = palette()[1],
           "versicolor" = palette()[2],
           "virginica" = palette()[3])
  })
  
  # Generate a summary of the dataset (or subset by Iris.Species)
  output$summary <- renderPrint({
    dataset <- datasetInput()
    summary(dataset)
  })
  
  #Generate means
  output$meantext <- renderText({ 
    paste("You calculate the mean by taking the sum of your input values and dividing by the number of the input values in the dataset.\ 
          In this case you have", input$obs," observations.")
  })
  output$meantextx <- renderText({ 
    paste("You calculate the mean by taking the sum of your input values and dividing by the number of the input values in the dataset.\ 
          In this case you have", input$obs," observations.")
    paste("What is the mean/average value of", input$Xvar," ?")
  })
  
  output$calcmeanx <- renderPrint({
    df_iris <- datasetInput()
    mean(head(df_iris[,c(input$Xvar)], n = input$obs))
  })
  
  output$meantexty <- renderText({
    paste("What is the mean/average value of", input$Yvar," ?")
  })
  
  output$calcmeany <- renderPrint({
    df_iris <- datasetInput()
    mean(head(df_iris[,c(input$Yvar)], n = input$obs))
  })
  
  
  #Generate variance
  output$vartext <- renderText({ 
    paste("Variance is the sum of squares of differences between all numbers and means. Here's an example calculation!")
  })
  output$vartextx <- renderText({ 
    paste("You just calculated the mean for", input$Xvar,"next, you will first calculate the deviations of each data point from the mean of and square the result of each")
  })
  
  output$devx <- renderPrint({
    df_iris <- datasetInput()
    meanx <-mean(head(df_iris[,c(input$Xvar)], n = input$obs))
    diff <- head(df_iris[,c(input$Xvar)], n = input$obs) - mean_ppg
    
  })
  output$sqdifftext <- renderText({ 
    paste("Next, take the square of the difference")
  })
  output$sqdiffx <- renderPrint({
    df_iris <- datasetInput()
    meanx <-mean(head(df_iris[,c(input$Xvar)], n = input$obs))
    diff <- head(df_iris[,c(input$Xvar)], n = input$obs) - mean_ppg
    sum(squared_diff) / (length(head(df_iris[,c(input$Xvar)], n = input$obs)) - 1)
  })
  
  
  
  # Show the first n observations
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
  output$NbRows <- renderText({ 
    paste("You have selected to show ", input$obs," lines.")
  })
  
  
  # Show a simple x,y plot
  output$simplePlot <- renderPlot({
    
    df_iris <- datasetInput()
    plot(df_iris[,c(input$Xvar,input$Yvar)], xlab = input$Xvar, ylab = input$Yvar,
         main=toupper(ifelse(input$dataset == "all iris data", "iris", input$dataset)), pch=16, cex = 2,
         col = ifelse(df_iris$Species == "setosa", palette()[1], 
                      ifelse(df_iris$Species == "versicolor", palette()[2], palette()[3])) )
    
    legend("bottomright", legend = unique(df_iris[,5]), 
           col = myColors(), title = expression(bold("Iris.Species")),
           pch = 16, bty = "n", pt.cex = 2, 
           cex = 0.8, text.col = "black", horiz = FALSE, inset = c(0.05, 0.05))
  })
  
  # Show boxplot
  output$boxPlot <- renderPlot({
    df_iris <- datasetInput()
    
    if (input$dataset == "all iris data") {
      boxplot(df_iris[,c(input$Yvar)] ~ df_iris[,5], xlab = "Species", ylab = input$Yvar, main = "IRIS", 
              border = "black", col = myColors())
    }
    else {
      boxplot(df_iris[,c(input$Yvar)], xlab = "Species", ylab = input$Yvar, main = toupper(input$dataset),
              border = "black", col = myColors())
    }
  })
  
  # Create a .csv file with dataframe inside
  output$downloadData <- downloadHandler(
    filename = function() {
      paste('data-Iris-', Sys.Date(), '.csv', sep='')
    },
    content = function(con) {
      write.csv(iris, con)
    }
  )
  
})
