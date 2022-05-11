library(shiny)
# Other useful packages
#library(datasets)
# library(rpart)
# library(party)
library(fpc)

# Define colors
palette(c("#E73032", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFDD33", "#A65628", "#F781BF", "#999999"))

# Define server logic 
shinyServer(function(input, output) {
  
  datasetInput <- reactive({
    switch(input$dataset,
           "all iris data" = iris)
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
    print("values:")
   print(head(df_iris[,c(input$Xvar)], n = input$obs))
   print("sum of values:")
   print(sum(head(df_iris[,c(input$Xvar)], n = input$obs)))
   print("divide sum of values by total number of observations:")
    mean(head(df_iris[,c(input$Xvar)], n = input$obs))
  })
  
  output$meantexty <- renderText({
    paste("What is the mean/average value of", input$Yvar," ?")
  })
  
  output$calcmeany <- renderPrint({
    df_iris <- datasetInput()
    print("values:")
    print(head(df_iris[,c(input$Yvar)], n = input$obs))
    print("sum of values:")
    print(sum(head(df_iris[,c(input$Yvar)], n = input$obs)))
    print("divide sum of values by total number of observations:")
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
    head(df_iris[,c(input$Xvar)], n = input$obs) - meanx
    
  })
  output$sqdifftext <- renderText({ 
    paste("Next, take the square of the difference")
  })
  output$sqdiffx <- renderPrint({
    df_iris <- datasetInput()
    meanx <-mean(head(df_iris[,c(input$Xvar)], n = input$obs))
    diff <- head(df_iris[,c(input$Xvar)], n = input$obs) - meanx
    squared_diff <- diff^2
    squared_diff
  })
  output$varfinaltext <- renderText({ 
    paste("Finally,sum the square difference and divide by the number of samples minus 1 ")
  })
  
  output$varfinal <- renderPrint({
    df_iris <- datasetInput()
    meanx <-mean(head(df_iris[,c(input$Xvar)], n = input$obs))
    diff <- head(df_iris[,c(input$Xvar)], n = input$obs) - meanx
    squared_diff <- diff^2
    print("Take the sum of the squared difference")
    print(sum(squared_diff))
    print("Divide by the number of samples minus 1")
    sum(squared_diff) / (length(head(df_iris[,c(input$Xvar)], n = input$obs)) - 1)
  })
 
  
  # Show the first n observations
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
  output$NbRows <- renderText({ 
    paste("You have selected to show ", input$obs," lines.")
  })
  
  # Show boxplot
  output$boxPlot <- renderPlot({
    df_iris <- datasetInput()
      boxplot(df_iris[,c(input$Yvar)] ~ df_iris[,5], xlab = "Species", ylab = input$Yvar, main = "IRIS", 
              border = "black", col = myColors())
    })
})

  
 
  

