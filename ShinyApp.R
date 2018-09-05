library(shiny)
library(gapminder)
library(ggplot2)
library(colourpicker)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      textInput(inputId = "title", 
                label = "Title", 
                "GDP vs life exp"),
      numericInput("size", 
                   "Point size", 
                   1, 
                   min =  1),
      checkboxInput("fit", 
                    "Add line of best fit", 
                    FALSE),
      colourInput("color", "Point color", "blue"),
      selectInput("continents", "Continents",
                  choices = levels(gapminder$continent),
                  multiple = TRUE,
                  selected = "Americas"),
      sliderInput("years", 
                  "Years", 
                  min = min(gapminder$year), 
                  max = max(gapminder$year),
                  value = c(1977,2002))
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output) {
  output$plot <- renderPlot({
    data <- subset(gapminder,
                   continent %in% input$continents &
                     year >= input$years[1] & year <= input$years[2])
    
    p <- ggplot(data, aes(gdpPercap, lifeExp)) +
      geom_point(size = input$size, col = input$color) +
      scale_x_log10() +
      ggtitle(input$title)
    
    if (input$fit) {
      p <- p + geom_smooth(method="lm")
    }
    p
  })
}

shinyApp(ui = ui, server = server)
