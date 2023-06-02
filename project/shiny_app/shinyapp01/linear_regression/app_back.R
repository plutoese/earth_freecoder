#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(bslib)
library(shiny)
library(crosstalk)
library(plotly)
library(leaflet)
library(lorem)

# Creates the "filter link" between the controls and plots
dat <- SharedData$new(dplyr::sample_n(diamonds, 1000))

card1 <- card(
  full_screen = TRUE,
  card_header(class = "bg-dark", "Scrolling content"),
  lapply(
    lorem::ipsum(paragraphs = 3, sentences = c(5, 5, 5)),
    tags$p
  )
)
card2 <- card(
  full_screen = TRUE,
  card_header(markdown("**Nothing much here**")),
  accordion_panel(title="模型", "Yes")
)
card3 <- card(
  full_screen = TRUE,
  card_header("Filling content"),
  card_body(
    class = "p-0",
    shiny::plotOutput("p")
  )
)

# Sidebar elements (e.g., filter controls)
filters <- list(
  filter_select("cut", "Cut", dat, ~cut),
  filter_select("color", "Color", dat, ~color),
  filter_select("clarity", "Clarity", dat, ~clarity)
)

# plotly visuals
plots <- list(
  plot_ly(dat) |> add_histogram(x = ~price),
  plot_ly(dat) |> add_histogram(x = ~carat),
  plot_ly(dat) |> add_histogram(x = ~cut, color = ~clarity)
)
plots <- lapply(plots, \(x) config(x, displayModeBar = FALSE))

# map filter and visual
quake_dat <- SharedData$new(quakes)
map_filter <- filter_slider("mag", "Magnitude", quake_dat, ~mag)
map_quakes <- leaflet(quake_dat) |>
  addTiles() |>
  addCircleMarkers()


diamonds_view <- layout_sidebar(
  sidebar = sidebar(
    title = "Diamond filters",
    !!!filters
  ),
  fillable = TRUE,
  border = FALSE,
  border_radius = FALSE,
  !!!plots
)


quakes_view <- card(
  full_screen = TRUE,
  card_header("Earthquake locations"),
  layout_sidebar(
    sidebar = sidebar(map_filter),
    map_quakes
  )
)

link_back <- tags$a(shiny::icon("house"), "返回应用库", href = "http://www.cloudstudio.vip/apps")

# Define UI for application that draws a histogram
ui <- page_navbar(
  theme = bs_theme(bootswatch = "journal"),
  title = "线性回归模型",
  fillable = TRUE,
  nav_panel("简介", diamonds_view),
  nav_panel("应用", quakes_view),
  nav_panel("关于", 
            layout_column_wrap(
              width = NULL, height = NULL, fill = FALSE,
              style = css(grid_template_columns = "2fr 1fr"),
              card1, card2
            )
  ),
  nav_spacer(),
  nav_item(link_back),
)
# Define server logic required to draw a histogram
server <- function(input, output, session) {
  
}

# Run the application 
shinyApp(ui = ui, server = server)
