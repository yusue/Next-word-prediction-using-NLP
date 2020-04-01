
bigram <- readRDS("2-freq.RData")

words = list()
# Define UI for application that draws a histogram

server <- function(input, output, session){
    # typeahead
    observe({
        input$textInput01 # read-only
        
        # alphabetial and lower-case only 
        text <- tolower(input$textInput01)
        text <- gsub("^[^a-z]+|[^a-z]+$", " ", text)
        text <- str_trim(gsub("\\s+", " ", text))
        
        # convert input to a list of words
        words <<- unlist(strsplit(text, " "))
        print(paste0("words: ", words))
        if (length(words) == 0){
            # show message
            if (str_trim(input$textInput01) != ""){
                showshinyalert(session=session, 
                               id="shinyalert01", 
                               HTMLtext=paste0("\"", input$textInput01, 
                                               "\" isn't valid input for prediction."), 
                               styleclass="danger")
            }
            output$verbatimTextOutput01 <- renderText(NULL)
            output$tableOutput01 <- renderTable(NULL)
            output$barplot01 <- renderPlot(NULL)
            return()
        } 
        
        # show message
        showshinyalert(session=session, 
                       id="shinyalert01", 
                       HTMLtext=paste0("Words for prediction are \"", text, "\"."), 
                       styleclass="info")
        
        
        
        # search bigram dictionary
        # always match with the last  words
        # pattern = paste0('^', paste(words, collapse =   '_'))
        pattern  = paste0('^', words[length(words)])
        
        pred = bigram[grep(pattern, bigram$feature), ][1:20, 1:3]
        # match with the last word
        if (length(words)>1 & dim(pred)[1]==0){
            pred <- head(bigram[grep(paste0("^", words[length(words)], " "), 
                                     bigram[,'feature']),], 20)}
        
        if (dim(pred)[1]==0){pred <- bigram[1:20,]}
        
        head(pred)
        if (dim(pred)[1] != 0){
            # output the prediction
            output$verbatimTextOutput01 <- renderText({pred[1,1]})
            # show predicted words table
            output$tableOutput01 <- renderTable(head(pred))
            # plot bar chart
            output$barplot01 <- renderPlot({
                p01 <- ggplot(data=pred, aes(x= reorder(feature, -frequency) , y=frequency)) +
                    geom_bar(stat="identity", fill="grey") +
                    # geom_label_repel(aes(label=ngrams), size=4) +
                    geom_label_repel(aes(label=feature), size=4) +
                    labs(title="Predicted next word by frequency",
                         x="", y="Frequency") +
                    theme(plot.title=element_text(size=30, face="bold"),
                          axis.text.x=element_blank(),
                          axis.text.y=element_text(angle=90))
                print(p01)
            }) # end of renderPlot()  
            return()
        } # if (dim(pred)[1] != 0)
        
        output$verbatimTextOutput01 <- renderText("(No prediction)")
        output$tableOutput01 <- renderTable(NULL)
        output$barplot01 <- renderPlot(NULL)
        
    }) # end of observe input$typeahead01
    
    # click on "Clear Input" button
    observeEvent(input$actionButton01, {
        words <<- list()
        updateTextInput(session, "textInput01", value="")
        output$verbatimTextOutput01 <- renderText(NULL)
        output$tableOutput01 <- renderTable(NULL)
        output$barplot01 <- renderPlot(NULL)
        # show message
        showshinyalert(session=session, 
                       id="shinyalert01", 
                       HTMLtext=paste0("Input has been cleared."), 
                       styleclass="success")
        return()
    }) # end of observeEvent input$actionButton01
    
} # end of server function

# shinyApp(ui=ui, server=server)