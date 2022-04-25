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
    h6("We timed 1000 middle-school-aged boys in a 20-yard sprint and found 
    that their times fell on a Normal distribution with a mean of 6.5 seconds 
       and a standard deviation of 0.5 seconds."),
    h6("Use the slider below to change the point of interest and calculate the 
       probability that a randomly selected student will be faster than your
       selected time."),

    # Sidebar
    sidebarLayout(
        sidebarPanel(
            sliderInput(inputId = "point",
                        label = "Point of Interest:",
                        min = 4.5,
                        max = 8.5,
                        value = 6.5),
            radioButtons(inputId = "test", 
                         label = "Test Type", 
                         choices = c("Less than", "Greater than"),
                         selected = "Less than")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot"),
            uiOutput("probability")
        )
    )
))
