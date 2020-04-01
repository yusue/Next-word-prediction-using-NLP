library(shiny)
library(shinysky)
library(ggrepel)
library(ggplot2)
library(stringr)

# setwd("/Users/yusue/Documents/GitHub/data science capstone")


ui <- shinyUI(
    fluidPage(titlePanel("Text Input Prediction"),
              
              sidebarLayout(
                  sidebarPanel(
                      
                      tags$b("Please type some words in the box below."),
                      textInput("textInput01", label=NULL, 
                                value = "", width=NULL,
                                placeholder=''),
                      shinyalert("shinyalert01"),
                      tags$b("The most possible input predicted:"),
                      verbatimTextOutput("verbatimTextOutput01", placeholder=TRUE),
                      tableOutput('tableOutput01'),
                      actionButton("actionButton01", "Clear Input")
                  ),
                  
                  mainPanel(
                      plotOutput("barplot01")
                  )
              ) # end of sidebarLayout()
    ) # end of fluidPage()
)
