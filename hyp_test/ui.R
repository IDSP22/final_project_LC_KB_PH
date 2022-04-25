#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("The Tortoise and the Hare"),
    
    # Introduction Text
    h6("You may be familiar with the famous fable, \"The Tortoise and the Hare.\" 
       The Hare challenges an unlikely competitor, the Tortoise, to a race to 
       see which one is \"the fastest.\" While the Hare takes advantage of his 
       natural strength in speed by acting careless and taking breaks/naps 
       during the race, the Tortoise continues to move very slowly but without 
       stopping and finally wins the race. The moral lesson of the story is that 
       you can be more successful by doing things slowly and steadily than by 
       acting quickly and carelessly."),
    h6("As statisticians, we want to take a different spin and investigate if 
       the Tortoise is faster than the Hare through Hypothesis testing! 
       Hypothesis testing allows us to set a null hypothesis and test the 
       validity of this using an alternative hypothesis."),
    h6(strong("For this simulation, our null hypothesis is: The Tortoise is not 
              faster than the Hare.")),
    h6(strong("Our alternative hypothesis is: The Tortoise is faster 
              than the Hare.")),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            numericInput("tort_races", "Number of Races the Tortoise Ran:",
                         min = 10, value = 30, max = 100, step = 30),
            sliderInput("tort_speed",
                        "Average Tortoise Speed:",
                        min = 20,
                        max = 40,
                        value = 30),
            numericInput("hare_races", "Number of Races the Hare Ran:",
                         min = 10, value = 30, max = 100, step = 30),
            sliderInput("hare_speed",
                        "Average Hare Speed:",
                        min = 20,
                        max = 40,
                        value = 30),
            sliderInput("sig_level",
                        "Significance Level:",
                        min = 0.01,
                        max = 0.3,
                        value = 0.05)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot"),
            uiOutput("t_stat"),
            uiOutput("p_val"),
            uiOutput("estimate")
        )
    )
))