library(shiny)
library(tidyverse)

# Define server logic required to run the hypothesis test app
shinyServer(function(input, output) {
    ## Generate single game simulation
    single_game_result <- eventReactive(input$single_run, {
        result <- sample(c("You won!", "Your friend won"), 1)
        return(result)
    })
    
    output$single_output <- renderUI({
        if(is.null(single_game_result()) == TRUE){
            paste("")
        }
        else{
            paste(single_game_result())
        }
    })
    
    ## Generate data for distributions
    game_dat <- eventReactive(input$resample, {
        dat <- tibble(
            results = sample(x = c("You won", "Friend won"), 
                             size = input$n_rounds, 
                             replace = TRUE, 
                             prob = c(input$p_you_win, 1-input$p_you_win))
        )
        return(dat)
    })
    
    ## Calculate one-proportion z-test results
    t_test_output <- reactive({
        test <- prop.test(x = length(game_dat()$results[which(game_dat()$results == "You won")]), 
                          n = nrow(game_dat()),
                          p = 0.5, 
                          alternative = "greater",
                          conf.level = input$sig_level)
    })
    
    ## Make bar graph plot
    output$distPlot <- renderPlot({
        ggplot(data = game_dat(), aes(x = results)) +
            geom_bar(fill = c("skyblue4", "firebrick4")) +
            scale_x_discrete(limits = c("You won", "Friend won")) +
            labs(x = NULL, y = "Number of Games Won")
    })
    
    ## Generate text stating the p-value of the hypothesis test.
    output$p_val <- renderUI({
        paste0("Our test returned a p-value of ",
               round(t_test_output()$p.val, 2), ".")
    })
    
    ## Generate text explaining the conclusion of the test
    output$explanation <- renderUI({
        ifelse(t_test_output()$p.val < input$sig_level,
               paste0("We are ", 
                      (1 - input$sig_level)*100, 
                      "% confident that you are on average better than your 
                      friend."),
               paste0("There is not sufficient evidence to say that you are on 
                      average better than your friend at this significance 
                      level."))
    })
})

    
    