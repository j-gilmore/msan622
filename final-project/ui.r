library(shiny)

shinyUI(navbarPage("BLS Interactive",
	tabPanel("The Data",
	pageWithSidebar(
		headerPanel(h4("")),
		sidebarPanel(fluidRow(
				includeHTML("datahierarchy.html"),
				radioButtons("dataplotbutton", h5("Show Levels"),
					choices = c("Industry" = "Industry",
								"States" = "States"),
					selected = "Industry"
				),
			uiOutput("dataadd")
		)),
		mainPanel(
			plotOutput(
				outputId = "dataplotResults", height="auto"))
			)),
	tabPanel("National Overview",
	pageWithSidebar(
		headerPanel(h4("National Overview")),
		sidebarPanel(fluidRow(
			column(12,
				selectInput("input_type", h5("Select Industry"),
					c("All Industries", "Architecture and Engineering", "Arts, Design, Entertainment, Sports, and Media", "Building and Grounds Cleaning and Maintenance", "Business and Financial Operations", "Community and Social Service", "Computer and Mathematical", "Construction and Extraction", "Education, Training, and Library", "Farming, Fishing, and Forestry", "Food Preparation and Serving Related", "Healthcare Practitioners and Technical", "Healthcare Support", "Installation, Maintenance, and Repair", "Legal", "Life, Physical and Social Science", "Management", "Office and Administrative Support", "Personal Care and Service", "Production", "Protective Service", "Sales and Related", "Transportation and Material Moving"),
					selected = "All Industries")),
				br(),
				br(),
				radioButtons("dorpplot", h5("Type of Plot"),
					choices = c("Employment Density Map" = "density",
								"Points by Total Employed" = "points"),
					selected = "density"
				),
			uiOutput("natui")
		)),
		mainPanel(
			plotOutput(
				outputId = "natplotResults")) #, height="auto"
			)),
	tabPanel("Industry Overview",
	pageWithSidebar(
		headerPanel(h4("Industry Overview")),
		sidebarPanel(fluidRow(
			column(12,
				selectInput("input_industry", h5("Select Industry"),
					c("All Occupations" = "00-0000", "Architecture and Engineering" = "17-0000", "Arts, Design, Entertainment, Sports, and Media" = "27-0000", "Building and Grounds Cleaning and Maintenance" = "37-0000", "Business and Financial Operations" = "13-0000", "Community and Social Service" = "21-0000", "Computer and Mathematical" = "15-0000", "Construction and Extraction" = "47-0000", "Education, Training, and Library" = "25-0000", "Farming, Fishing, and Forestry" = "45-0000", "Food Preparation and Serving Related" = "35-0000", "Healthcare Practitioners and Technical" = "29-0000", "Healthcare Support" = "31-0000", "Installation, Maintenance, and Repair" = "49-0000", "Legal" = "23-0000", "Life, Physical, and Social Science" = "19-0000", "Management" = "11-0000", "Office and Administrative Support" = "43-0000", "Personal Care and Service" = "39-0000", "Production" = "51-0000", "Protective Service" = "33-0000", "Sales and Related" = "41-0000", "Transportation and Material Moving" = "53-0000"),
					selected = "00-0000")),
				br(),
				radioButtons("radio_overview", h5("Wage Type"),
					choices = c("Hourly" = "Hourly",
								"Annual" = "Annual"),
					selected = "Hourly"
				),
				column(12,
			tableOutput("overviewstatsResults"))
		)),
		mainPanel(
			plotOutput(
				outputId = "natoverviewResults"),
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
				selectInput("tableoverview_sort", h5("Sort Table By:"),
					c("Total Employed" = "TOT_EMP",
					"Mean" = "H_MEAN",
					"Median" = "H_MEDIAN"),
					selected = "TOT_EMP")
				),
			column(10,
			tableOutput("tableoverviewResults")))
			)),
	tabPanel("Distribution Details",
	pageWithSidebar(
		headerPanel(h4("Distribution Details")),
		sidebarPanel(fluidRow(
			column(12,
				radioButtons("tree_df", h5("View"),
					choices = c("National" = "National",
								"State" = "State",
								"Industry" = "Industry"),
					selected = "National"
				),
				selectInput("tree_industry", h5("Select Industry"),
					c("All Industries", "Architecture and Engineering", "Arts, Design, Entertainment, Sports, and Media", "Building and Grounds Cleaning and Maintenance", "Business and Financial Operations", "Community and Social Service", "Computer and Mathematical", "Construction and Extraction", "Education, Training, and Library", "Farming, Fishing, and Forestry", "Food Preparation and Serving Related", "Healthcare Practitioners and Technical", "Healthcare Support", "Installation, Maintenance, and Repair", "Legal", "Life, Physical and Social Science", "Management", "Office and Administrative Support", "Personal Care and Service", "Production", "Protective Service", "Sales and Related", "Transportation and Material Moving"),
					selected = "Architecture and Engineering")),
			uiOutput("treeui"),
			radioButtons("tree_category", h5("Select Category"),
				choices = c("Total Employees" = "TOT_EMP",
							"Wage" = "A_MEAN"),
					selected = "TOT_EMP"
				),
			radioButtons("tree_scale", h5("Select Scale"),
				choices = c("Total Employees" = "TOT_EMP",
							"Wage" = "A_MEAN"),
					selected = "A_MEAN"
				)
		)),
		mainPanel(
			plotOutput(
				outputId = "treeResults", height="auto"),
			br(),
			br()	
			)
			)),
	tabPanel("Local Stats",
	pageWithSidebar(
		headerPanel(h4("Find Local Stats")),
		sidebarPanel(fluidRow(
			br(),
			column(12, #fluidRow(
				selectInput("local_ind", h5("Select Industry"),
					c("Architecture and Engineering", "Arts, Design, Entertainment, Sports, and Media", "Building and Grounds Cleaning and Maintenance", "Business and Financial Operations", "Community and Social Service", "Computer and Mathematical", "Construction and Extraction", "Education, Training, and Library", "Farming, Fishing, and Forestry", "Food Preparation and Serving Related", "Healthcare Practitioners and Technical", "Healthcare Support", "Installation, Maintenance, and Repair", "Legal", "Life, Physical and Social Science", "Management", "Office and Administrative Support", "Personal Care and Service", "Production", "Protective Service", "Sales and Related", "Transportation and Material Moving"),
					selected = "Architecture and Engineering"),
				uiOutput("localui"),
				column(6,
					selectInput("state_select", h5("Select State"),
						c("Alabama" = "AL", "Alaska" = "AK", "Arizona" = "AZ", "Arkansas" = "AR", "California" = "CA", "Colorado" = "CO", "Connecticut" = "CT", "Delaware" = "DE", "District of Columbia" = "DC", "Florida" = "FL", "Georgia" = "GA", "Hawaii" = "HI", "Idaho" = "ID", "Illinois" = "IL", "Indiana" = "IN", "Iowa" = "IA", "Kansas" = "KS", "Kentucky" = "KY", "Louisiana" = "LA", "Maine" = "ME", "Maryland" = "MD", "Massachusetts" = "MA", "Michigan" = "MI", "Minnesota" = "MN", "Mississippi" = "MS", "Missouri" = "MO", "Montana" = "MT", "Nebraska" = "NE", "Nevada" = "NV", "New Hampshire" = "NH", "New Jersey" = "NJ", "New Mexico" = "NM", "New York" = "NY", "North Carolina" = "NC", "North Dakota" = "ND", "Ohio" = "OH", "Oklahoma" = "OK", "Oregon" = "OR", "Pennsylvania" = "PA", "Rhode Island" = "RI", "South Carolina" = "SC", "South Dakota" = "SD", "Tennessee" = "TN", "Texas" = "TX", "Utah" = "UT", "Vermont" = "VT", "Virginia" = "VA", "Washington" = "WA", "West Virginia" = "WV", "Wisconsin" = "WI", "Wyoming" = "WY"),
						selected = "CA"))
			),
			column(12,
				radioButtons("dorpplotlocal", h5("Type of Plot"),
					choices = c("Employment Density Map" = "density",
								"Points by Total Employed" = "points"),
					selected = "points"
				)),
			column(12,
			h5(textOutput("textResults")))
		)),
		mainPanel(
			plotOutput(
				outputId = "localplotResults"
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
			)
		)			
	))
))