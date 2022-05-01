library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("The Tortoise and the Hare"),
    
    # Introduction Text
    h6("Let's say you and a friend are playing a game. You think you are better
       than your friend at this game, but you are not sure because you win some
       rounds and lose other rounds."),
    h6(strong("For this simulation, our null hypothesis is: The Tortoise is not 
              faster than the Hare.")),
    h6(strong("Our alternative hypothesis is: The Tortoise is faster 
              than the Hare.")),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            numericInput("n_rounds", 
                         "Enter the number of rounds to play:",
                         min = 30, value = 50, max = 100),
            sliderInput("p_you_win",
                        "Enter the probability of YOU winning a given round:",
                        min = 0,
                        max = 1,
                        value = 0.5),
            sliderInput("sig_level",
                        "Significance Level:",
                        min = 0.01,
                        max = 0.3,
                        value = 0.05)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot"),
            uiOutput("p_val")
        )
    )
))