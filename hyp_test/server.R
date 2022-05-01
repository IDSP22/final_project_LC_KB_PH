library(shiny)
library(tidyverse)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    game_dat <- reactive({
        dat <- tibble(
            results = sample(x = c("You won", "Friend won"), 
                             size = input$n_rounds, 
                             replace = TRUE, 
                             prob = c(input$p_you_win, 1-input$p_you_win))
        )
        
        return(dat)
    })
    
    t_test_output <- reactive({
        test <- prop.test(x = length(game_dat()$results[which(game_dat()$results == "You won")]), 
                          n = nrow(game_dat()),
                          p = 0.5, 
                          alternative = "greater",
                          conf.level = input$sig_level)
    })
    
    output$distPlot <- renderPlot({
        ggplot(data = game_dat(), aes(x = results)) +
            geom_bar(fill = c("skyblue4", "firebrick4")) +
            scale_x_discrete(limits = c("You won", "Friend won")) +
            labs(x = NULL, y = "Number of Games Won")
    })
    
    output$p_val <- renderPrint({
        ifelse(t_test_output()$p.val < input$sig_level,
               paste0("Our test returned a p-value of ",
                      round(t_test_output()$p.val, 2),
                      ". We are ", (1 - input$sig_level)*100, 
                      "% confident that you are on 
               average better than your friend."),
               paste0("Our test returned a p-value of ",
                      round(t_test_output()$p.val, 2),
                      ". There is not sufficient evidence to say that you are on",
               " average better than your friend at this significance level."
               ))
    })
})
    
    
    