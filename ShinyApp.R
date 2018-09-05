library(shiny)
library(gapminder)
library(ggplot2)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      textInput(inputId = "title", 
                label = "Title", 
                "GDP vs life exp"),
      numericInput("size", "Point size", 1, min =  1)
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output) {
  output$plot <- renderPlot({
    ggplot(gapminder, aes(gdpPercap, lifeExp)) +
      geom_point(size = input$size) +
      scale_x_log10() +
      ggtitle(input$title)
  })
}

shinyApp(ui = ui, server = server)
