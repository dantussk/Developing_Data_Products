

library(quantmod)

shinyServer(function(input, output) {
    
   StockData <- reactive({
        getSymbols(input$SYMBOL, src = "google", 
                   from = seq(Sys.Date(), length=2, by="-1 years")[2],
                   to = Sys.Date(),
                   auto.assign = FALSE)
    })
   
   TickerName <- reactive({
       paste(getQuote(input$SYMBOL, what=yahooQF("Name"))[,2])
   })
   
   output$SelectionText <- renderText({ 
       paste("You have selected", input$SYMBOL, "(", TickerName(), ")")
   })
        
   output$StockPrice <- renderPlot({    
       chartSeries(StockData(), theme = chartTheme("black"), 
                    type = "line",  TA=c(addVo(),addBBands()), 
                    name = paste('Stock prices of',TickerName(),'in the last 1 year'))
    }) 
   
   # Generate a summary of the dataset
   output$Summary <- renderPrint({
           do.call(rbind, apply(StockData(), 2, function(col) {
           max_ind <- which.max(col)
           min_ind <- which.min(col)
           list(max=col[max_ind], max_date=as.character(index(StockData()))[max_ind], min=col[min_ind],
                min_date=as.character(index(StockData()))[min_ind])
           }))
   })
    
})

