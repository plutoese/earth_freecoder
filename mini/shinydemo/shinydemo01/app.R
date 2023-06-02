library(shiny)
library(htmltools)
library(bslib)

ui <- page_navbar(
  title = "My App",
  bg = "#0062cc",
  nav(title = "One", p("First page content.")),
  nav(title = "Two", p("Second page content.")),
  nav_spacer(),
  nav_menu(
    title = "Other links",
    align = "right",
    nav("Three", p("Third page content.")),
  )
)


server <- function(input, output, session) {
}

shinyApp(ui, server)
