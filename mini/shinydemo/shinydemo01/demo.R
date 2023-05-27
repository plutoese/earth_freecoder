library(shiny)

reactiveConsole(TRUE)

x <- reactiveVal(10)
x()       # get
#> [1] 10
x(20)     # set
x()       # get
#> [1] 20

r <- reactiveValues(x = 10)
r$x       # get
#> [1] 10
r$x <- 20 # set
r$x       # get
#> [1] 20

r <- reactive(stop("Error occured at ", Sys.time(), call. = FALSE))
r()
#> Error: Error occured at 2022-08-23 23:10:12

