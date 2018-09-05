library(shiny)
library(gapminder)
library(ggplot2)

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
      radioButtons("color", 
                   "Point color", 
                   choices = c("blue", "red", "green", "black"))
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output) {
  output$plot <- renderPlot({
    p <- ggplot(gapminder, aes(gdpPercap, lifeExp)) +
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
