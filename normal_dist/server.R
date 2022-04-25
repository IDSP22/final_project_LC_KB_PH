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
            time = seq(from = 4.5, to = 8.5, by = 0.01),
            dist = dnorm(time, mean = 6.5, sd = 0.5)
        )
    })
    ## Make plot output
    output$distPlot <- renderPlot({
        ggplot(data = dat(), aes(time, dist)) +
            geom_line() +
            theme_light() +
            geom_segment(aes(x = input$point, y = 0, xend = input$point, 
                             yend = dist[which(time == input$point)])) +
            labs(x = "Time", y = "Probability of Observing")
    })
    ## Calculate probability
    output$probability <- renderPrint(round(pnorm(input$point, 
                                                  mean = 6.5, sd = 0.5), 3))
})
