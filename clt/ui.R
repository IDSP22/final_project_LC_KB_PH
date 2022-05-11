library(shiny)

shinyUI(bootstrapPage(
  titlePanel(""),
  column(width=12,
         wellPanel(
           h1("When does the Central Limit Theorem apply?"),
           HTML('The Central Limit Theorem (CLT) helps us understand the characteristics of sample statistics, particularly the sample mean and sample standard deviation and their relationship with the true population mean and standard deviation. It tells us that if we have a population with a mean μ and standard deviation σ and we take a large number of sufficiently large random samples from the population, then the sample means will be approximately normally distributed. 
           <br> 
           <br>
           This not only applies when the underlying population is normally distributed but also when it is not! 
           <br> 
           <br>
           In this app, you can test when the central limit theorem applies for 4 different underlying distributions. The first visualization shows the true population containing 1000 draws from one of the selected distribution. The sliders allow you to select the number of samples drawn and the size of each sample. The other visualization shows the distribution of the means of this sample. 
           <br>
           <br>
           Observe how the shape of the distribution of the means changes as you vary the sample size and number of samples. CLT holds true when the distribution is approximately bell shaped! Now, can you roughly estimate the sample size and number of samples need for CLT to apply for each of the distributions below?
')),
         ),
  sidebarPanel(
    sliderInput(inputId = 'sampsize',
                label = "Size of each sample",
                value = 100, min = 1, max = 1000),
    sliderInput(inputId = 'nsamp', label='Number of samples',
                value = 100, min=1, max = 500),
    radioButtons("dist", "Distribution type:",
                 c("Normal" = "norm",
                   "Uniform" = "unif",
                   "Log-normal" = "lnorm",
                   "Exponential" = "exp")), 
    actionButton(inputId = "resample", 
                 label= "Resample", 
                 class = "btn-primary")
  ), 
  mainPanel(
    fluidRow(
      column(6, plotOutput(outputId = "pop")), 
      column(6, plotOutput(outputId = "hist"))
    ), 
    fluidRow(
      column(12, 
             wellPanel(
             textOutput(outputId = "true_mean"), 
             textOutput(outputId = "true_sd"),
             textOutput(outputId = "print_mean"), 
             textOutput(outputId = "print_sd"))
      )
    )
    
  )
)
)