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
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            ## Summary Statistics Side Panel
            ## Normal Distribution Side Panel
            ## CTL Side Panel
            ## Hypothesis Tests Side Panel
            ## CI Side Panel
            ## Regression Side Panel
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(
                id = 'dataset',
                tabPanel("Summary Statistics"),
                tabPanel("Normal Distribution"),
                tabPanel("Central Limit Theorem"),
                tabPanel("Hypothesis Tests"),
                tabPanel("Confidence Intervals"),
                tabPanel("Regression")
            )
        )
    )
))
