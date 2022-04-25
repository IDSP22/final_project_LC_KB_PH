library(shiny)

shinyUI(bootstrapPage(
  titlePanel("When does the Central Limit Theorem apply?"),
  sidebarPanel(
    numericInput(inputId = 'nx', label = 'Size of underlying population', 
                 value = 1000),
    sliderInput(inputId = 'sampsize',
                label = "Size of each sample",
                value = 100, min = 1, max = 500),
    sliderInput(inputId = 'nsamp', label='Number of samples',
                value = 100, min=1, max = 500),
    radioButtons("dist", "Distribution type:",
                 c("Normal" = "norm",
                   "Uniform" = "unif",
                   "Log-normal" = "lnorm",
                   "Exponential" = "exp"))
  ), 
  mainPanel(
    fluidRow(
      column(6, plotOutput(outputId = "hist")), 
      column(6, plotOutput(outputId = "pop"))
    )
    
  )
)
)