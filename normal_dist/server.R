## DGP ##
# set.seed(1234)
# dat <- data.frame("Time" = rnorm(1000, 6.5, 0.5))
# write.csv(dat, file = "./normal_dist/race_times.csv")

library(shiny)
library(tidyverse)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    ## Make data for plot, never changing
    dat <- reactive({
        tibble(
            time = seq(from = 4.5, to = 8.5, by = 0.005),
            dist = dnorm(time, mean = 6.5, sd = 0.5)
        )
    })
    ## Determine side
    lower_side <- reactive({
        ifelse(input$test == "Faster", TRUE, FALSE)
    })
    ## Calculate p-value
    p_val <- reactive({
        round(pnorm(input$point, mean = 6.5, sd = 0.5, 
                    lower.tail = lower_side()), 3)
    })
    ## Make plot output
    output$distPlot <- renderPlot({
        if(lower_side() == TRUE){
            ggplot(data = dat(), aes(time, dist)) +
                geom_line() +
                theme_light() +
                #geom_segment(aes(x = input$point, y = 0, xend = input$point, 
                #                 yend = dist[which(time == input$point)])) +
                geom_area(data = dplyr::filter(dat(), time <= input$point), 
                          aes(x = time, y = dist), alpha = 0.2) +
                labs(x = "Time", y = "Density")
        }
        else{
            ggplot(data = dat(), aes(time, dist)) +
                geom_line() +
                theme_light() +
                #geom_segment(aes(x = input$point, y = 0, xend = input$point, 
                #                 yend = dist[which(time == input$point)])) +
                geom_area(data = dplyr::filter(dat(), time >= input$point), 
                          aes(x = time, y = dist), alpha = 0.2) +
                labs(x = "Time", y = "Density")
        }
    })
    ## Calculate probability
    output$probability <- renderUI({
        if(lower_side() == TRUE){
            strong(paste0("The probability that a randomly selected 
                         student ran the sprint in less than ", 
                          input$point, " seconds is ", 
                          round(pnorm(input$point, mean = 6.5, sd = 0.5, 
                                      lower.tail = lower_side()), 3), "."))
        }
        else{
            strong(paste0("The probability that a randomly selected 
                         student ran the sprint in more than ", 
                          input$point, " seconds is ", 
                          round(pnorm(input$point, mean = 6.5, sd = 0.5, 
                                      lower.tail = lower_side()), 3), "."))
        }
        })
})

## 6.8-7.8 by 0.25 -- 
