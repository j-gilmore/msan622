library(shiny)

data(movies)

shinyUI(
	pageWithSidebar(
		headerPanel(tags$head(tags$img(src="imdblogo.png", height = 100, width = 100, alt ="Internet Movie Database")), "IMDb Ratings and Budget"),
		sidebarPanel( 
			radioButtons(
				"mpaaVal",
				"MPAA Rating:",
				c("All", "PG", "PG-13", "R", "NC-17"),
				selected = "All"
			),
			checkboxGroupInput(
				"genreVal",
				"Movie Genres:",
				c("Action", "Animation", "Comedy", "Documentary", "Drama", 					"Romance", "Short"),
				selected = "None"
			),
			selectInput(
				"colorScheme",
				"Color Scheme:",
				choices = c("Default", "Accent", "Dark2", "Pastel1", "Pastel2", 				"Set1", "Set2"),
				selected = "Default"
			),
			sliderInput(inputId = "alphaVal",
				label = "More or Less Transparency",
				min = 0, max = 0.9, value = .5, step = 0.1
			),
			sliderInput(inputId = "pointVal",
				label = "Point Value",
				min = 1, max = 10, value = 5, step = 1
			)
		),
			
		mainPanel(
			plotOutput("scatterPlot"),
			br(),
			br(),
			br(),
			br(),
			includeHTML("jitterStatement.html"),
			radioButtons(
				"jitterVal",
				"Apply Jitter:",
				c("Yes", "No"),
				selected = "No"
			)			
		)
	)
)
