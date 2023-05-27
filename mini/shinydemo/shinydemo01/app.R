library(shiny)
library(bslib)

ui <- page_fixed(
  theme = bs_theme(bootswatch = "minty"),
  h2("Hello world")
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)