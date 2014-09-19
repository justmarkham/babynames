library(shiny)
library(ggplot2)
library(dplyr)

# load data objects created by helper.R
bn <- readRDS("bn.rds")
bn.unique <- readRDS("bn.unique.rds")
bn.topyear <- readRDS("bn.topyear.rds")
bn.alltime <- readRDS("bn.alltime.rds")

shinyServer(function(input, output){
    
    # create reactive functions to filter data by input name
    namedata <- reactive(bn %>% filter(lname==tolower(input$name)))
    topyeardata <- reactive(bn.topyear %>% filter(lname==tolower(input$name)))
    alltimedata <- reactive(bn.alltime %>% filter(lname==tolower(input$name)))
    
    # render the plot
    output$namePlot <- renderPlot({
        ggplot(namedata()) +
            aes(x=year, y=n, color=sex) +
            geom_line() +
            theme_bw() +
            theme(legend.position=c(0,1), legend.justification=c(0,1),
                  legend.title=element_blank(),
                  legend.background=element_blank(),
                  legend.text=element_text(size=14),
                  axis.title.x=element_text(size=16),
                  axis.text.x=element_text(size=12),
                  axis.text.y=element_text(size=12),
                  plot.title=element_text(size=18)) +
            scale_colour_discrete(labels=c("Female","Male")) +
            ggtitle(paste0("Number of children born with the name \"",
                           input$name, "\"")) + 
            xlab("Birth Year") +
            ylab("") +
            xlim(input$year[1], input$year[2])
    })
    
    # render "quick facts" header text
    output$text0 <- renderText({
        paste0("Quick facts about ", input$name)
    })
    
    # render "most popular year" text
    output$text1 <- renderText({
        validate(need(tolower(input$name) %in% bn.unique, label="Valid name"))
        paste0("The most popular year for \"", input$name, "\" was ",
               topyeardata()$year, ", when ",
               format(topyeardata()$count, big.mark=","),
               " children were born with that name.")
    })
    
    # render "all-time births" text
    output$text2 <- renderText({
        validate(need(tolower(input$name) %in% bn.unique, label="Valid name"))
        paste0(format(alltimedata()$total, big.mark=","), " children (",
               format(alltimedata()$F, big.mark=","), " females and ",
               format(alltimedata()$M, big.mark=","),
               " males) have been born with that name since 1880.")
    })

})
