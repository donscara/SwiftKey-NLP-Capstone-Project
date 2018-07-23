library(shiny)
library(NLP)
library(tm)

source("NLP Algorithms.R")


shinyServer(
  function(input, output) {
    output$inputValue <- renderPrint({input$TI})
    output$prediction <- renderPrint({wordproc(input$TI)})
    
    
    
  }
)