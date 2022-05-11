library(shiny)
library(shinythemes)
library(shinyWidgets)

shinyUI(bootstrapPage(
  titlePanel(""),
  column(width = 12, 
   wellPanel(h1('Linear Regression Assumptions'),
             HTML('
When we fit a linear regression to a given dataset, we are implicitly making certain assumptions. Particularly, we assume that:
<br>
<br>
<ul>
<li> X and Y are linearly related 
<li> The errors are homoscedastic (i.e. they have equal variance across all values of X and Y) 
<li> The individual observations are independent
<li> The errors are normally distributed
</li></ul>

<br>
When these assumptions are violated, a linear regression will fit the data poorly. We can diagnose these violations through a number of diagnostic plots. 
<br>
<br>
In this app, we fit a simple linear regression using simulated values of Y and X. You can switch on and off each linear regression assumption and observe how the diagnostic plots change for different violations. 
'))
    ),
  sidebarPanel(
    h5('Assumptions'),
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
      column(width = 10, plotOutput(outputId = "plots"))
    ), 
    fluidRow(
      column(width=12, 
             wellPanel(
               uiOutput("list")
             ))
    )
  )
)
)


