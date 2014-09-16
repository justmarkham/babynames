library(shiny)

shinyUI(fluidPage(
    
    titlePanel("Baby Names by Birth Year"),
    
    sidebarLayout(
        
        sidebarPanel(
            h4("Instructions:"),
            textInput("name", label="Enter your first name:", value="Kevin"),
            sliderInput("year", "Select years to display:", min=1880, max=2013, value=c(1880, 2013), format="####"),
            hr(),
            h4("About:"),
            p("This application plots the number of children born in the US each year (1880-2013), separated by gender. Data is provided by the ", a("Social Security Administration", href="http://www.ssa.gov/oact/babynames/limits.html"), " and was converted into an ", a("R package", href="https://github.com/hadley/babynames"), "by Hadley Wickham."),
            h4("External Links:"),
            tags$ul(
                tags$li(a("Top 10 names for 2013", href="http://www.ssa.gov/oact/babynames/index.html")),
                tags$li(a("Change in popularity (2012-2013)", href="http://www.ssa.gov/oact/babynames/rankchange.html")),
                tags$li(a("Popular names by state", href="http://www.ssa.gov/oact/babynames/state/index.html"))
            ),
            h4("Development:"),
            p("Created by ", a("Kevin Markham", href="http://www.dataschool.io"), " using ", a("Shiny", href="http://shiny.rstudio.com/"), " and hosted on ", a("ShinyApps.io", href="https://www.shinyapps.io")),
            tags$ul(
                tags$li(a("Source Code", href="https://github.com/justmarkham/babynames")),
                tags$li(a("Slides", href="http://justmarkham.github.io/babynames/"))
            )
        ),
        
        mainPanel(
            plotOutput("namePlot"),
            h3(textOutput("text0")),
            textOutput("text1"),
            br(),
            textOutput("text2")
            )

        )

))

