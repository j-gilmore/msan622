library(shiny)

shinyUI(
	pageWithSidebar(
		headerPanel("The Divine Comedy by Dante"),
		sidebarPanel(fluidRow(
			column(5,
			selectInput("input_type", h5("Interaction Type"),
				c("Word Use", "Word Cloud", "Many Eyes"),
				selected = "Word Use")
			),
			column(6, offset = 1,
				radioButtons(
					"colorScheme",
					h5("Color Selection"),
					c("Red/Orange/Yellow" = "YlOrRd",
					"Blue/Green" = "BuGn"),
					selected = "YlOrRd"
				)
			)),
#			br(),
			uiOutput("ui"),
			br()
		),
		mainPanel(
			plotOutput("plotResults")
			# imageOutput("imageResults")
		)			
	)
)