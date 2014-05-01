library(shiny)

shinyUI(navbarPage("BLS Interactive",
	tabPanel("National Stats",
		sidebarPanel(fluidRow(
			column(12,
				selectInput("input_type", h5("Select Industry"),
					c("Management", "Business and Financial"),
					selected = "Management"))))),
	tabPanel("State Stats",
		sidebarPanel(fluidRow(
			column(12,
				selectInput("input_type", h5("Select Industry"),
					c("Management", "Business and Financial"),
					selected = "Management"))))),
	tabPanel("Local Stats",
	pageWithSidebar(
		headerPanel(h4("Find Local Stats")),
		# column(12, #fluidRow(
		# column(3, 
		sidebarPanel(fluidRow(
			column(9,
			selectInput("input_type", h5("Select Industry"),
				c("Management", "Business and Financial", "Computer and Mathematical", "Architecture and Engineering", "Life, Physical, and Social Science", "Community and Social Service", "Legal", "Education, Training, and Library", "Arts, Design, Entertainment, Sports, and Media", "Healthcare Practitioners and Technical", "Healthcare Support", "Protective Service", "Food Preparation and Serving Related", "Building and Grounds Cleaning and Maintenance", "Personal Care and Service", "Sales and Related", "Office and Administrative Support", "Farming, Fishing, and Forestry", "Construction and Extraction", "Installation, Maintenance, and Repair", "Production", "Transportation and Material Moving"),
				selected = "Management")
			),
			uiOutput("ui"),
			br(),
			column(12, #fluidRow(
				column(6,
					selectInput("state_select", h5("Select State"),
						c("Alabama" = "AL", "Alaska" = "AK", "Arizona" = "AZ", "Arkansas" = "AR", "California" = "CA", "Colorado" = "CO", "Connecticut" = "CT", "Delaware" = "DE", "Florida" = "FL", "Georgia" = "GA", "Hawaii" = "HI", "Idaho" = "ID", "Illinois" = "IL", "Indiana" = "IN", "Iowa" = "IA", "Kansas" = "KS", "Kentucky" = "KY", "Louisiana" = "LA", "Maine" = "ME", "Maryland" = "MD", "Massachusetts" = "MA", "Michigan" = "MI", "Minnesota" = "MN", "Mississippi" = "MS", "Missouri" = "MO", "Montana" = "MT", "Nebraska" = "NE", "Nevada" = "NV", "New Hampshire" = "NH", "New Jersey" = "NJ", "New Mexico" = "NM", "New York" = "NY", "North Carolina" = "NC", "North Dakota" = "ND", "Ohio" = "OH", "Oklahoma" = "OK", "Oregon" = "OR", "Pennsylvania" = "PA", "Rhode Island" = "RI", "South Carolina" = "SC", "South Dakota" = "SD", "Tennessee" = "TN", "Texas" = "TX", "Utah" = "UT", "Vermont" = "VT", "Virginia" = "VA", "Washington" = "WA", "West Virginia" = "WV", "Wisconsin" = "WI", "Wyoming" = "WY"),
						selected = "CA"))
			),
			column(12,
			h5(textOutput("textResults")))
		)),
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
			column(3,
				selectInput("table_sort", h5("Sort Table By:"),
					c("Total Employed" = "TOT_EMP",
					"Jobs per 1000" = "JOBS_1000",
					"Wage" = "H_MEAN"),
					selected = "TOT_EMP")
				),
			column(10,
			tableOutput("tableResults")
			# includeHTML("aboutseatbelts.html")
			)
		)			
	))
))