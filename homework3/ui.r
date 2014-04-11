library(shiny)

shinyUI(
	pageWithSidebar(
		headerPanel("State Interactive"),
		sidebarPanel(fluidRow(
			column(6,
			selectInput("input_type", "Input Type",
				c("Bubble", "Small Multiples", "Parallel"),
				selected = "Bubble")
			),
			column(6,
				radioButtons(
					"subsetGeog",
					"Geographic Emphasis:",
					c("Region", "Division"),
					selected = "Region"
				)
			)),
			br(),
			sliderInput("perc", "GDP Percentile Range:", min=0, max=1, 
				value=c(0,1), step=.01, 
			),
			br(),
			uiOutput("ui"),
			br(),
			includeHTML("VariableDefinitions.html")
		),
			
		mainPanel(
			plotOutput("plotResults")
		)
	)
)
