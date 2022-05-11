library(shiny)
library(tidyverse)
library(sortable)
library(shinyWidgets)
library(ggplot2)
library(gridExtra)


shinyServer(function(input, output, session) {
  
  ################## MY FUNCTIONS ###########################
  generate_y <- function(x, err, linear=TRUE){
    if (linear==TRUE){
      return (1+2.35*x + err)
    }else{
      return (100+(0.2*x)^3 - (0.2*x)^2 + 100*err)
    }
  }
  
  generate_err_dist <- function(mean, sd, length, normal=TRUE){
    if (normal==TRUE){
      return (rnorm(mean=mean,sd=sd,length))
    }
    else{
      return (rexp(length, sd/2000))
    }
  }
  
  generate_err <- function(x, homoscedastic=TRUE, independent=TRUE, normal=TRUE){
    if (homoscedastic==TRUE){
      sd <- 50
    }
    else{
      sd <- abs(x)
    }
    if (independent==FALSE){
      err <- generate_err_dist(mean=0,sd=sd/2,length=length(x), normal=normal)
      ar_err <- 10*arima.sim(model = list(ar = c(0.9), ma = c(0.7)), n = length(x))
      return (ar_err+err)
    }
    else{
      return (generate_err_dist(mean=0,sd=sd,length=length(x), normal=normal))
    }
  }
  
  ggplot_pacf <- function(data, lag.max = 24, ci = 0.95, theme=theme_bw()){
    list.pacf <- acf(data, lag.max = lag.max, type = "partial", plot = FALSE)
    N <- as.numeric(list.pacf$n.used)
    df <- data.frame(lag = list.pacf$lag,pacf = list.pacf$acf)
    df$pacfstd <- sqrt(1/N)
    plot.pacf <- ggplot(data = df, aes(x = lag, y = pacf)) +
      geom_hline(yintercept = qnorm((1+ci)/2)/sqrt(N), 
                 colour = "red",
                 linetype = "dashed") + 
      geom_hline(yintercept = - qnorm((1+ci)/2)/sqrt(N), 
                 colour = "red",
                 linetype = "dashed") +
      geom_col(fill = "grey", width = 0.7, alpha=1) +
      scale_x_continuous(breaks = seq(0,max(df$lag, na.rm = TRUE),6), name='Lag') +
      scale_y_continuous(name = 'PACF') + theme
    
    return (plot.pacf)
  }
  
  ##########################################################################
  
  linear <- reactive(input$linearity)
  homoscedastic <- reactive(input$homoscedasticity)
  independent <- reactive(input$independence)
  normal <- reactive(input$normality)
  
  X <- rep(seq(1,200, 1),2)
  
  err <- reactive({
    generate_err(X, homoscedastic=homoscedastic(), independent = independent(), normal=normal())
  })
  
  Y <- reactive({
    generate_y(X, err(), linear=linear())
  })
  
  output$plots <- renderPlot({
    data <- data.frame(X=X, Y=Y())
    model <- lm(Y~X, data=data)
    data$res <- residuals(model)
    
    my_theme <- theme(plot.title = element_text(hjust = 0.5), 
                      # plot.margin = margin("in"), 
                      panel.grid.major = element_blank(), 
                      panel.grid.minor = element_blank(),
                      panel.background = element_blank(), 
                      axis.line = element_line(colour = "black"))
    
    options(repr.plot.width = 4, repr.plot.height =4)
    
    lf <- ggplot(data,aes(X, Y)) +
      geom_point(color='grey', alpha=0.8) +
      geom_smooth(method='lm', se=FALSE, color='red') + 
      labs(title = 'Linear fit') +
      my_theme
    
    res <- ggplot(data, aes(X, res)) + 
      geom_point(color='grey',alpha=0.8) + 
      labs(title ='Residuals', y='Residuals') + 
      my_theme
    
    
    qqn <- ggplot(data, aes(sample=res)) + 
      geom_qq(color='grey', alpha=1) + 
      geom_qq_line(color='red') + 
      labs(title='Normal QQ Plot', y = 'Residuals', x = 'X') + 
      my_theme
    
    rpacf <- pacf(data$res, plot=FALSE)
    pacfdf <- with(rpacf, data.frame(lag, acf))
    
    pcf <- ggplot_pacf(data$res, theme = my_theme) + labs(title='Partial Autocorrelation of Residuals')
    
    grid.arrange(lf, res, qqn, pcf, nrow = 2)
    
  })
   
  output$list <- renderUI({
    linear_false <- "<li> When the linearity assumption is switched off you can see that a staight line does not capture the true pattern of the data
    and the residuals are not uniformly distributed around 0"
    homosc_false <- "<li> When the erros are not homoscedastic then they are correlated with X, this can be observed in the funnel-like pattern of the residuals"
    indep_false <- "<li> When the independence assumption is violated, errors are correlated to each other. This can be diagnosed through significant autocorrelations 
    in the partial autocorrelation plot (bottom right)"
    normal_false <- "<li> When the errors are not normally distributed, they do not fall on a straight line in the Normal QQ Plot (bottom left)"
    assum1 <- ifelse(linear(), "", linear_false)
    assum2 <- ifelse(homoscedastic(), "", homosc_false)
    assum3 <- ifelse(independent(), "", indep_false)
    assum4 <- ifelse(normal(), "", normal_false)
    
    
    HTML("<ul>", assum1, assum2, assum3, assum4, 
         "</li>"
         )
    })
  

})