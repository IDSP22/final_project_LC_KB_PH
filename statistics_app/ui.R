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
            ## KB: Summary Statistics Side Panel
            ## LC: Normal Distribution Side Panel
            ## PH: CTL Side Panel
            ## LC: Hypothesis Tests Side Panel
            ## KB: CI Side Panel
            ## PH: Regression Side Panel
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(
                id = 'dataset',
                ## KB: Summary Statistics Main Panel
                tabPanel("Summary Statistics"),
                
                ## LC: Normal Distribution Main Panel
                tabPanel("Normal Distribution"),
                
                ## PH: CTL Main Panel
                tabPanel("Central Limit Theorem"),
                
                ## LC: Hypothesis Tests Main Panel
                tabPanel("Hypothesis Tests"),
                
                ## KB: CI Main Panel
                tabPanel("Confidence Intervals"),
                
                ## PH: Regression Main Panel
                tabPanel("Regression")
            )
        )
    )
))
