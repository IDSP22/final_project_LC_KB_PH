library(shiny)

shinyServer(function(input, output, session) {
  observeEvent(input$nx, {
    updateSliderInput(session, "sampsize", max = input$nx)
  })
  
  dist <- reactive( {switch(input$dist,
                            norm = rnorm,
                            unif = runif,
                            lnorm = rlnorm,
                            exp = rexp,
                            rnorm)} )
  x <- reactive( {dist()(input$nx)} )
  output$hist <- renderPlot({ 
    means <- c()
    for (i in 1:input$nsamp){
      samp <- sample(x(), input$sampsize)
      means[i] <- mean(samp)
    }
    
    hist(means, col='skyblue3', 
         xlab='mean of x', freq=FALSE, main='Distribution of Sample Means')
    
  }, width=350, height=350)
  output$pop <- renderPlot( {
    hist(dist()(x()), xlab="x", main="Underlying Population Distribution", 
         col='skyblue3')
  }, width = 350, height = 350)
}
)