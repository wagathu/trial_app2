
source("global.R")
ui <- fluidPage(
    fluidRow(
        h2("Trial app", style = "color:#27AAE1; text-align:center"),
        column(2),
        column(8,
               highchartOutput("my_plot", width = "100%", height = "500px")
               ),
        column(2)
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
output$my_plot <- renderHighchart({
    dd |> 
        hchart(
            hcaes(
                x = date,
                y = cases
            ),
            type = "spline",
            color = "#27AAE1"
        )
})
}

# Run the application 
shinyApp(ui = ui, server = server)
