
library(shiny)

shinyUI(fluidPage(
    titlePanel("Visualization of stock prices in the last one year"),
    
    sidebarLayout(
        sidebarPanel(                       
            textInput("SYMBOL", "Select the symbol of the stock ticker", "GOOG")            
                    ),        
        mainPanel(
            h3(textOutput("SelectionText")),
            br(),
            plotOutput("StockPrice"),
            br(),
            h4("Maximum and minimum of the stock prices and their corresponding dates"),
                verbatimTextOutput("Summary")
            )
)))