library(shiny)

shinyUI(
	pageWithSidebar(
		headerPanel("Auto Fatalities"),
		sidebarPanel(fluidRow(
			column(5,
			selectInput("input_type", h5("Plot Type"),
				c("Heatmaps", "Area Chart", "Multi-Line"),
				selected = "Heatmaps")
			),
			column(12, fluidRow(
				sliderInput(
       				"yearrange", 
        			"Year Range:", 
					min = 1969, 
            		max = 1984,
            		value = c(1973, 1980),
            		step = 1
				)
			))
			),
			uiOutput("ui"),
			br()
		),
		mainPanel(
			plotOutput(
				outputId = "plotResults"
			),
			br(),
			br(),
			br(),
			br(),
			br(),
			br(),
			br(),
			br(),
			br(),
			br(),
			column(10,
			includeHTML("aboutseatbelts.html")
			)
		)			
	)
)