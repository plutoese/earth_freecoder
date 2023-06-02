library(shiny)
library(bslib)
library(htmltools)
library(plotly)

plotly_widget <- plot_ly(x = diamonds$cut) %>%
  config(displayModeBar = FALSE) %>%
  layout(margin = list(t = 0, b = 0, l = 0, r = 0))

# UI logic
ui <- page_fluid(
  card(
    height = 250,
    full_screen = TRUE,
    card_header("A filling plot"),
    card_body(plotly_widget)
  )
)

# Server logic
server <- function(input, output, session) {
}

shinyApp(ui, server)