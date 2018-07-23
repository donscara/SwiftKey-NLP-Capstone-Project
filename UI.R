library(shiny)

fluidPage(
  
  
  mainPanel(
    h3("SwiftKey NLP App"),
    h5("Predict next word provided a text input"),
    
    
    textInput("TI",label=h3("Type text here:")),
    submitButton('Submit'),
    h4('Your input : '),
    verbatimTextOutput("inputValue"),
    h4('Next word :'),
    verbatimTextOutput("prediction")
    
  )
)