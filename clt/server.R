library(shiny)

shinyServer(function(input, output, session) {
  
  #fixed size of underlying population
  popsize <- 1000
  
  #defining the distribution of the underlying population
  dist <- reactive( {switch(input$dist,
                            norm = rnorm,
                            unif = runif,
                            lnorm = rlnorm,
                            exp = rexp,
                            rnorm)} )
  
  #
  x <- reactive( {dist()(popsize)} )
  sampsize <- reactive({input$sampsize})
  nsamp <- reactive({input$nsamp})
  
  resample <- function(x, sampsize, nsamp){
    means <- c()
    for (i in 1:nsamp){
      samp <- sample(x(), sampsize)
      means[i] <- mean(samp)
    }
    return(means)
  }
  
  sample_means <- reactive({
          resample(x(), sampsize(), nsamp())
        })
  
  output$hist <- renderPlot({ 
    hist(sample_means(), col='skyblue3', 
         xlab='sample mean', freq=FALSE, main='Distribution of Sample Means')
    }, width=350, height=350)
  
  output$pop <- renderPlot( {
    hist(dist()(x()), xlab="x", main="Underlying Population Distribution", 
         col='skyblue3')
  }, width = 350, height = 350)
  
  output$print_mean <- renderText(
    paste("Mean of Sample Means: ", round(mean(sample_means()), 2))
  )
  
  output$print_sd <- renderText(
    paste("Standard Deviation of Sample Means: ", round(sd(sample_means()), 2))
  )
  
  output$true_mean <- renderText(
    paste("True Population Mean: ", round(mean(x()), 2))
  )
  
  output$true_sd <- renderText(
    paste("True Population Standard Deviation: ", round(sd(x()), 2))
  )
  
  observeEvent(input$resample, {
    sample_means <- reactive({
      resample(x(), sampsize(), nsamp())
    })
    
    output$hist <- renderPlot({ 
      hist(sample_means(), col='skyblue3', 
           xlab='sample mean', freq=FALSE, main='Distribution of Sample Means')
    }, width=350, height=350)
    
    output$print_mean <- renderText(
      paste("Mean of Sample Means: ", round(mean(sample_means()), 2))
    )
    
    output$print_sd <- renderText(
      paste("Standard Deviation of Sample Means: ", round(sd(sample_means()), 2))
    )
    
  })
  
  
  
  
})