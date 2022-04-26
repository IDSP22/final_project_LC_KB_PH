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
    titlePanel("Middle School Sprint"),
    h5("We timed 1000 middle-school boys in a 20-yard sprint and found 
       that their times fell on a Normal distribution with a mean of 6.5 
       seconds and a standard deviation of 0.5 seconds. The plot below depicts 
       this distribution."),
    h5("The vertical line below the distribution represents a time of interest,
       or possible observed sprint time. The shaded area represents the 
       probability that a randomly selected student ran faster than this sprint
       time. Use the slider below to change the time of interest and 
       see how the size of the shaded area changes as the time of interest 
       changes."),
    h5("We can also observe the probability that a randomly selected student ran
       slower than the time of interest by changing which side of the time of 
       interest we shade. We can control this by selecting \"Slower\" below."),

    # Sidebar
    sidebarLayout(
        sidebarPanel(
            radioButtons(inputId = "test", 
                         label = "The probability that a randomly selected 
                         student is:", 
                         choices = c("Faster", "Slower"),
                         selected = "Faster"),
            sliderInput(inputId = "point",
                        label = "than this time:",
                        min = 4.5,
                        max = 8.5,
                        value = 6),
            uiOutput("probability")),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
)))
