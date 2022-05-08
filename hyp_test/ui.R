library(shiny)
library(shinyBS)

# Define UI for application that explains hypothesis testing
shinyUI(fluidPage(
    
    ## Title
    titlePanel("Who's Better?"),
    
    ## Introduction Text
    h6("Let's say you and a friend are playing a game. You and your friend are 
       both pretty good at the game, but you think you are actually better than
       your friend. But it is hard to tell for sure because you win some rounds
       and lose other rounds, simply due to chance."),
    h6("Use the button below to simulate playing an individual game with your friend"),
    actionButton("single_run","Simulate Game!"),
    uiOutput("single_output"),
    h6("If we simulated a bunch of games, we could use hypothesis testing to 
    see if the results have sufficient evidence to conclude that you are in
       fact better than your friend. Use the simulator below to test this."),
    h6(strong("The null hypothesis is: You and your friend 
              are equally good at this game.")),
    h6(strong("The alternative hypothesis is: You are better than your friend 
              at this game.")),
    
    ## Sidebar with a numeric input (rounds played) and 
    ## 2 sliders (prob winning & significance level)
    sidebarLayout(
        sidebarPanel(
            numericInput("n_rounds", 
                         "Enter the number of rounds to play:",
                         min = 50, value = 65, max = 100),
            bsTooltip(id = "n_rounds", 
                      title = "Increasing the amount of games played will reduce the chance of seeing an untrue random pattern of wins or losses."),
            sliderInput("p_you_win",
                        "Choose the probability that YOU win a given round:",
                        min = 0,
                        max = 1,
                        value = 0.65),
            bsTooltip(id = "p_you_win", 
                      title = "Increasing this probability will make it so the random samples lean in your favor."),
            sliderInput("sig_level",
                        "Significance Level:",
                        min = 0.01,
                        max = 0.3,
                        value = 0.05),
            bsTooltip(id = "sig_level", 
                      title = "Increasing the significance level will make it so that you need less evidence to conclude that you are better than your friend, but you will also be less confident in the conclusions."),
            actionButton("resample",
                         "Run simulation")
        ),
        
        ## Show a plot of the generated outcomes, the test p-val, and conclusion
        mainPanel(
            plotOutput("distPlot"),
            uiOutput("p_val"),
            uiOutput("explanation")
        )
    )
))