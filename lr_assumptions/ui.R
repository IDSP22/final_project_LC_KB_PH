library(shiny)
library(shinythemes)
library(shinyWidgets)

shinyUI(bootstrapPage(
  titlePanel("Linear Regression Assumptions"),
  sidebarPanel(
    h5('Use the switches below to test the Linear Regression assumptions'),
    br(),
    prettySwitch(inputId = 'linearity', label = 'Y is linearly related to X', 
                 value = TRUE, inline = FALSE, fill = TRUE),
    prettySwitch(inputId = 'homoscedasticity', label = 'Errors are homoscedastic', 
                 value = TRUE, inline = FALSE, fill = TRUE),
    prettySwitch(inputId = 'independence', label = 'Observations are independent', 
                 value = TRUE, inline = FALSE, fill = TRUE),
    prettySwitch(inputId = 'normality', label = 'Errors are normally distributed', 
                 value = TRUE, inline = FALSE, fill = TRUE)
  ), 
  mainPanel(
    fluidRow(
      h3('Diagnostic plots'), 
      plotOutput(outputId = "plots")
    )
  )
)
)


