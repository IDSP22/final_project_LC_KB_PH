# Define server logic required to summarize and view the selected dataset



#insert image of formula 

create_plot= function(n = input$nsamp, pop.mean = input$mean, pop.sd = input$variance, conf.lvl = (input$conf.level/100)) {
  
  plot(NULL
       ,xlim = c(pop.mean-pop.sd,pop.mean+pop.sd)
       ,ylim = c(0,100)
       ,yaxt = 'n'
       ,xlab = (conf.lvl)
       ,ylab = (n)
  )
  
  abline(v = pop.mean, col = 'black')
  mtext(expression(mu), cex = 2, at = pop.mean)
  
  for (i in 1:100){
    x <- rnorm(n, mean = pop.mean, sd = pop.sd)
    test <- t.test(x,conf.level=conf.lvl)
    interval <- test$conf.int
    
    if(pop.mean>interval[1] & pop.mean<interval[2]){
      lines(c(interval[1],interval[2]),c(i,i), lwd=2,col='black')
    }
    else{
      lines(c(interval[1],interval[2]),c(i,i), lwd=2,col='red' )
    } 
  } 
  abline(v =interval[1], col = 'blue')
  mtext(round(interval[1],1), cex = 2, at = interval[1])
  abline(v =interval[2], col = 'blue')
  mtext(round(interval[2],1), cex = 2, at = interval[2])
}


# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output) {
  
  thePlot <- eventReactive(input$simulate | input$simulate == 0, {
    create_plot(input$nsamp, input$mean, input$variance, (input$conf.level/100))
  })
  
  output$conf.plot <- renderPlot({
    thePlot()
  })
  
  # Add intro text into confidence intervals and what they do 
  output$introtxt <- renderText({ 
    paste("A confidence interval gives us a range of values between which we would find our true estimate with high certainty. 
        For example, when we are calculating the 95% confidence interval, we can say that we 95% that the value will fall between
        the calculated range. You can calculate this range through the following formula: ")}
  )
  
  #Image inserted
  
})



  
  
  
