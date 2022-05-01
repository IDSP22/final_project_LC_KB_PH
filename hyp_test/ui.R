library(shiny)

# Define UI for application that explains hypothesis testing
shinyUI(fluidPage(
    
    ## Title
    titlePanel("Who's Better?"),
    
    ## Introduction Text
    h6("Let's say you and a friend are playing a game. You and your friend are 
       both pretty good at the game, but you think you are actually better than
       your friend. But it is hard to tell for sure because you win some rounds
       and lose other rounds, simply due to chance."),
    h6("We can use hypothesis testing to evaluate if the results of a random 
       sampling of games provides sufficient evidence to conclude if you are in
       fact better than your friend."),
    h6("Increasing the amount of games played will reduce the chance of seeing 
    an untrue pattern of wins or losses due to random chance."),
    h6("Increasing this probability will make it so the random samples lean in 
    your favor. You will see that even though the probabilities are in your 
    favor, your friend will still win some games."),
    h6("Increasing the significance level will make it such that you need less 
    evidence to conclude that you are better than your friend. However, this 
    will also make it so that we are less confident in the conclusions."),
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
            sliderInput("p_you_win",
                        "Choose the probability that YOU win a given round:",
                        min = 0,
                        max = 1,
                        value = 0.65),
            sliderInput("sig_level",
                        "Significance Level:",
                        min = 0.01,
                        max = 0.3,
                        value = 0.05),
            actionButton("resample",
                         "Re-run simulation")
        ),
        
        ## Show a plot of the generated outcomes, the test p-val, and conclusion
        mainPanel(
            plotOutput("distPlot"),
            uiOutput("p_val"),
            uiOutput("explanation")
        )
    )
))