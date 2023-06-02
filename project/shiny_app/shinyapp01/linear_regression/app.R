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
library(haven)
library(DT)
library(reactable)
library(kableExtra)


# Creates the "filter link" between the controls and plots
dat <- SharedData$new(dplyr::sample_n(diamonds, 1000))

card_model_intro <- card(
  full_screen = TRUE,
  card_header(class = "bg-dark", "线性回归模型"),
)

card_osl_intro <- card(
  full_screen = TRUE,
  card_header(class = "bg-dark", "普通最小二乘估计"),
)

card_data <- card(
  full_screen = TRUE,
  card_header(class = "bg-white", "数据"),
  reactableOutput("datatable")
)

card_eda <- card(
  full_screen = TRUE,
  card_header(class = "bg-white", "探索性数据分析"),
  card_body(
    selectInput("state", "What's your favourite state?", state.name),
  )
)

card_model <- card(
  full_screen = TRUE,
  card_header(class = "bg-white", "线性回归模型"),
)

app_control_view <- layout_sidebar(
  fillable = TRUE,
  sidebar = sidebar(
    width = 300,
    h5("上传数据"),
    br(),
    fileInput("upload", NULL, accept = c(".csv", ".xls", ".xlsx", ".dta"), 
              buttonLabel = "浏览",
              placeholder = "尚未选择",),
    markdown("仅接受以下格式：csv/xls/xlsx/dta"),
    hr(),
    br(),
    h5("设定"),
    br(),
  ),
  border = FALSE,
  border_radius = FALSE,
  layout_column_wrap(
    width = NULL, height = NULL, fill = FALSE,
    style = css(grid_template_columns = "1fr 1fr"),
    card_data, card_eda),
  card_model,
)

link_back <- tags$a(shiny::icon("house"), "返回应用库", href = "http://www.cloudstudio.vip/apps")

# Define UI for application that draws a histogram
ui <- page_navbar(
    theme = bs_theme(bootswatch = "journal"),
    title = "线性回归模型与OLS估计",
    fillable = TRUE,
    nav_panel("简介", 
              layout_column_wrap(
                width = NULL, height = NULL, fill = FALSE,
                style = css(grid_template_columns = "1fr 1fr"),
                card_model_intro, card_osl_intro
              )),
    nav_panel("应用", app_control_view),
    nav_spacer(),
    nav_item(link_back),
)
# Define server logic required to draw a histogram
server <- function(input, output, session) {
  data <- reactive({
    req(input$upload)
    
    ext <- tools::file_ext(input$upload$name)
    switch(ext,
           csv = vroom::vroom(input$upload$datapath, delim = ","),
           dta = read_dta(input$upload$datapath),
           validate("不支持此格式文件！")
    )
  })
  output$datatable <- renderReactable({
    reactable(format(as.data.frame(data()), digits=2), 
              searchable = TRUE, minRows = 10, 
              bordered = TRUE, striped = TRUE)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
