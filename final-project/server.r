library(shiny)

shinyServer(function(input, output) {
	
	cat("Press \"ESC\" to exit...\n")

	output$dataadd <- renderUI({
		if (is.null(input$dataplotbutton))
			return()
		
		switch(input$dataplotbutton,
			"Industry" = fluidRow(
				column(12,
					radioButtons("addstates", h5("Add States?"),
						choices = c("Yes" = "Yes",
								"No" = "No"),
						selected = "No"
					))),
			"States" = fluidRow(
				column(12,
					radioButtons("addprofs", h5("Add Professions?"),
						choices = c("Yes" = "Yes",
								"No" = "No"),
						selected = "No"
					)))
				) })

	output$treeui <- renderUI({
		if (is.null(input$tree_df))
			return()
		
		switch(input$tree_df,
			"State" = fluidRow(
				column(12,
					selectInput("tree_state", h5("Select State"),
						c("Alabama" = "AL", "Alaska" = "AK", "Arizona" = "AZ", "Arkansas" = "AR", "California" = "CA", "Colorado" = "CO", "Connecticut" = "CT", "Delaware" = "DE", "District of Columbia" = "DC", "Florida" = "FL", "Georgia" = "GA", "Hawaii" = "HI", "Idaho" = "ID", "Illinois" = "IL", "Indiana" = "IN", "Iowa" = "IA", "Kansas" = "KS", "Kentucky" = "KY", "Louisiana" = "LA", "Maine" = "ME", "Maryland" = "MD", "Massachusetts" = "MA", "Michigan" = "MI", "Minnesota" = "MN", "Mississippi" = "MS", "Missouri" = "MO", "Montana" = "MT", "Nebraska" = "NE", "Nevada" = "NV", "New Hampshire" = "NH", "New Jersey" = "NJ", "New Mexico" = "NM", "New York" = "NY", "North Carolina" = "NC", "North Dakota" = "ND", "Ohio" = "OH", "Oklahoma" = "OK", "Oregon" = "OR", "Pennsylvania" = "PA", "Rhode Island" = "RI", "South Carolina" = "SC", "South Dakota" = "SD", "Tennessee" = "TN", "Texas" = "TX", "Utah" = "UT", "Vermont" = "VT", "Virginia" = "VA", "Washington" = "WA", "West Virginia" = "WV", "Wisconsin" = "WI", "Wyoming" = "WY"),
						selected = "CA")
				)
			),
			"Industry" = fluidRow(
				column(12,
					# br(),
					uiOutput("tree_profui")
				)
			)			
		)
	})
	output$tree_profui <- renderUI({
		if (is.null(input$tree_industry))
			return()
		
		switch(input$tree_industry,
			"Management" = fluidRow(
				column(12,
					# br(),
					selectInput("treeocc", h5("Select Profession"),
						choices = c("All Professions" = "99-9999", "Administrative Service Managers" = "11-3011",
							"Advertising and Promotions Managers" = "11-2011",
							"Architectural and Engineering Managers" = "11-9041",
							"Chief Executives" = "11-1011",
							"Compensation and Benefits Managers" = "11-3111",
							"Computer and Information Systems Managers" = "11-3021",
							"Construction Managers" = "11-9021",
							"Education Administrators, Elementary and Secondary School" = "11-9032",
							"Educaiton Administrators, Postsecondary" = "11-9033",
							"Education Administrators, Preschool and Childcare Center/Program" = "11-9031",
							"Farmers, Ranchers, and Other Agricultural Managers" = "11-9013",
							"Financial Managers" = "11-3031",
							"Food Service Managers" = "11-9051",
							"Gaming Managers" = "11-9071",
							"Human Resources Managers" = "11-3121",
							"Industrial Production Managers" = "11-3051",
							"Lodging Managers" = "11-9081",
							"Medical and Health Services Managers" = "11-9111",
							"Natural Sciences Managers" = "11-9121",
							"Property, Real Estate, and Community Association Managers" = "11-9141",
							"Public Relations and Fundraising Managers" = "11-2031",
							"Purchasing Managers" = "11-3061",
							"Sales Managers" = "11-2022",
							"Social and Community Service Managers" = "11-9151",
							"Training and Development Managers" = "11-3131"
							),
						selected = "11-3011"
					)
				)),
			"Business and Financial Operations" = fluidRow(
				column(12,
					# br(),
					selectInput("treeocc", h5("Select Profession"),
						choices = c("All Professions" = "99-9999", "Accountants and Auditors" = "13-2011",
							"Appraisers and Assessors of Real Estate" = "13-2021",
							"Budget Analysts" = "13-2031",
							"Claims Adjusters, Examiners and Investigators" = "13-1031",
							"Compensation, Benefits, and Job Analysis Specialists" = "13-1141",
							"Cost Estimators" = "13-1051",
							"Financial Analysts" = "13-2051",
							"Financial Examiners" = "13-2061",
							"Fundraisers" = "13-1131",
							"Insurance Underwriters" = "13-2053",
							"Loan Officers" = "13-2072",
							"Logisticians" = "13-1081",
							"Management Analysts" = "13-1111",
							"Market Research Analysts and Marketing Specialists" = "13-1161",
							"Meeting, Convention, and Event Planners" = "13-1121",
							"Personal Financial Advisors" = "13-2052",
							"Tax Examiners and Collectors, and Revenue Agents" = "13-2081",
							"Training and Development Specialists" = "13-1151"
									),
						selected = "13-2011"
					)
				)
			),
			"Computer and Mathematical" = fluidRow(
				column(12,
					# br(),
					selectInput("treeocc", h5("Select Profession"),
						choices = c("All Professions" = "99-9999", "Actuaries" = "15-2011",
							"Computer and Information Research Scientists" = "15-1111",
							"Computer Network Architects" = "15-1143",
							"Computer Programmers" = "15-1131",
							"Computer Systems Analysts" = "15-1121",
							"Computer User Support Specialists" = "15-1151",
							"Database Administrators" = "15-1141",
							"Information Security Analysts" = "15-1122",
							"Mathematicians" = "15-2021",
							"Network and Computer Systems Administrators" = "15-1142",
							"Operations Research Analysts" = "15-2031",
							"Software Developers, Applications" = "15-1132",
							"Statisticians" = "15-2041",
							"Web Developers" = "15-1134"
									),
						selected = "15-2011"
					)
				)
			),
			"Architecture and Engineering" = fluidRow(
				column(12,
					# br(),
					selectInput("treeocc", h5("Select Profession"),
						choices = c("All Professions" = "99-9999", "Aerospace Engineering and Operations Technicians" = "17-3021",
							"Aerospace Engineers" = "17-2011",
							"Agricultural Engineers" = "",
							"Architects, Except Landscape and Naval" = "17-1011",
							"Architectural and Civil Drafters" = "17-3011",
							"Biomedical Engineers" = "17-2031",
							"Cartographers and Photogrammetrists" = "17-1021",
							"Chemical Engineers" = "17-2041",
							"Civil Engineering Technicians" = "17-3022",
							"Civil Engineers" = "17-2051",
							"Computer Hardware Engineers" = "17-2061",
							"Electrical and Electronics Engineering Technicians" = "17-3023",
							"Electrical Engineers" = "17-2071",
							"Electro-Mechanical Technicians" = "17-3024",
							"Environmental Engineering Technicians" = "17-3025",
							"Environmental Engineers" = "17-2081",
							"Health and Safety Engineers, Except Mining Safety Engineers and Inspectors" = "17-2111",
							"Industrial Engineering Technicians" = "17-3026",
							"Industrial Engineers" = "17-2112",
							"Landscape Architects" = "17-1012",
							"Marine Engineers and Naval Architects" = "17-2121",
							"Materials Engineers" = "17-2131",
							"Mechanical Engineering Technicians" = "17-3027",
							"Mechanical Engineers" = "17-2141",
							"Mining and Geological Engineers, Including Mining Safety Engineers" = "17-2151",
							"Nuclear Engineers" = "17-2161",
							"Petroleum Engineers" = "17-2171",
							"Surveying and Mapping Technicians" = "17-3031",
							"Surveyors" = "17-1022"
									),
						selected = "11-1011"
					)
				)
			),
			"Life, Physical and Social Science" = fluidRow(
				column(12,
					# br(),
					selectInput("treeocc", h5("Select Profession"),
						choices = c("All Professions" = "99-9999", "Agricultural and Food Science Technicians" = "19-4011",
							"Animal Scientists" = "19-1011",
							"Anthropologists and Archeologists" = "19-3091",
							"Astronomers" = "19-2011",
							"Atmospheric and Space Scientists" = "19-2021",
							"Biochemists and Biophysicists" = "19-1021",
							"Biological Technicians" = "19-4021",
							"Chemical Technicians" = "19-4031",
							"Chemists" = "19-2031",
							"Clinical, Counseling, and School Psychologists" = "19-3031",
							"Conservation Scientists" = "19-1031",
							"Economists" = "19-3011",
							"Environmental Science and Protection Technicians, Including Health" = "19-4091",
							"Environmental Scientists and Specialists, Including Health" = "19-2041",
							"Epidemiologists" = "19-1041",
							"Forensic Science Technicians" = "19-4092",
							"Forest and Conservation Technicians" = "19-4093",
							"Geographers" = "19-3092",
							"Geological and Petroleum Technicians" = "19-4041",
							"Geoscientists, Except Hydrologists and Geographers" = "19-2042",
							"Historians" = "19-3093",
							"Hydrologists" = "19-2043",
							"Medical Scientists, Except Epidemiologists" = "19-1042",
							"Microbiologists" = "19-1022",
							"Nuclear Technicians" = "19-4051",
							"Political Scientists" = "19-3094",
							"Sociologists" = "19-3041",
							"Survey Researchers" = "19-3022",
							"Urban and Regional Planners" = "19-3051",
							"Zoologists and Wildlife Biologists" = "19-1023"
									),
						selected = "19-4011"
					)
				)
			),
			"Community and Social Service" = fluidRow(
				column(12,
					# br(),
					selectInput("treeocc", h5("Select Profession"),
						choices = c("All Professions" = "99-9999", "Child, Family, and School Social Workers" = "21-1021",
							"Educational, Guidance, School, and Vocational Counselors" = "21-1012",
							"Health Educators" = "21-1091",
							"Marriage and Family Therapists" = "21-1013",
							"Probation Officers and Correctional Treatment Specialists" = "21-1092",
							"Rehabilitation Counselors" = "21-1015",
							"Social and Human Service Assistants" = "21-1093",
							"Substance Abuse and Behavioral Disorder Counselors" = "21-1011"
									),
						selected = "21-1021"
					)
				)
			),
			"Legal" = fluidRow(
				column(12,
					# br(),
					selectInput("treeocc", h5("Select Profession"),
						choices = c("All Professions" = "99-9999", "Court Reporters" = "23-2091",
							"Lawyers" = "23-1011",
							"Paralegals and Legal Assistants" = "23-2011"
									),
						selected = "11-1011"
					)
				)
			),
			"Education, Training, and Library" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("All Professions" = "99-9999", "Adult Basic and Secondary Education and Literacy Teachers and Instructors" = "25-3011",
							"Archivists" = "25-4011",
							"Instructional Coordinators" = "25-9031",
							"Kindergarten Teachers, Except Special Education" = "25-2012",
							"Librarians" = "25-4021",
							"Library Technicians" = "25-4031",
							"Middle School Teachers, Except Special/Technical Education" = "25-2022",
							"Preschool Teachers, Except Special Education" = "25-2011",
							"Secondary School Teachers, Except Special and Career/Technical Education" = "25-2031",
							"Special Education Teachers, Preschool" = "25-2051",
							"Teacher Assistants" = "25-9041",
							"Vocational Education Teachers, Postsecondary" = "25-1194"
									),
						selected = "25-3011"
					)
				)
			),
			"Arts, Design, Entertainment, Sports, and Media" = fluidRow(
				column(12,
					# br(),
					selectInput("treeocc", h5("Select Profession"),
						choices = c("All Professions" = "99-9999", "Actors" = "27-2011",
							"Art Directors" = "27-1011",
							"Athletes and Sports Competitors" = "27-2021",
							"Audio and Video Equipment Technicians" = "27-4011",
							"Broadcast News Analysts" = "27-3021",
							"Camera Operators, Television, Video, and Motion Picture" = "27-4031",
							"Coaches and Scouts" = "27-2022",
							"Commercial and Industrial Designers" = "27-1021",
							"Craft Artists" = "27-1012",
							"Dancers" = "27-2031",
							"Editors" = "27-3041",
							"Fashion Designers" = "27-1022",
							"Floral Designers" = "27-1023",
							"Graphic Designers" = "27-1024",
							"Interior Designers" = "27-1025",
							"Interpreters and Translators" = "27-3091",
							"Multimedia Artists and Animators" = "27-1014",
							"Music Directors and Composers" = "27-2041",
							"Musicians and Singers" = "27-2042",
							"Photographers" = "27-4021",
							"Producers and Directors" = "27-2012",
							"Public Relations Specialists" = "27-3031",
							"Radio and Television Announcers" = "27-3011",
							"Technical Writers" = "27-3042",
							"Umpires, Referees, and Other Sports Officials" = "27-2023",
							"Writers and Authors" = "27-3043"
									),
						selected = "27-2011"
					)
				)
			),
			"Healthcare Practitioners and Technical" = fluidRow(
				column(12,
					# br(),
					selectInput("treeocc", h5("Select Profession"),
						choices = c("All Professions" = "99-9999", "Anesthesiologists" = "29-1061",
							"Athletic Trainers" = "29-9091",
							"Audiologists" = "27-1181",
							"Cardiovascular Technologists and Technicians" = "29-2031",
							"Chiropractors" = "29-1011",
							"Dental Hygienists" = "29-2021",
							"Dentists, General" = "29-1021",
							"Dietitians and Nutritionists" = "29-1031",
							"Emergency Medical Technicians and Paramedics" = "29-2041",
							"Genetic Counselors" = "29-9092",
							"Licensed Practical and Licensed Vocational Nurses" = "29-2061",
							"Medical and Clinical Laboratory Technologists" = "29-2011",
							"Medical Records and Health Information Technicians" = "29-2071",
							"Nuclear Medicine Technologists" = "29-2033",
							"Nurse Anesthetists" = "29-1151",
							"Occupational Health and Safety Specialists" = "29-9011",
							"Occupational Health and Safety Technicians" = "29-9012",
							"Occupational Therapists" = "29-1122",
							"Opticians, Dispensing" = "29-2081",
							"Optometrists" = "29-1041",
							"Orthotists and Prosthetists" = "29-2091",
							"Pharmacists" = "29-1051",
							"Pharmacy Technicians" = "29-2052",
							"Physical Therapists" = "29-1123",
							"Physician Assistants" = "29-1071",
							"Podiatrists" = "29-1081",
							"Psychiatric Technicians" = "29-2053",
							"Radiation Therapists" = "29-1124",
							"Radiologic Technologists" = "29-2034",
							"Recreational Therapists" = "29-1125",
							"Registered Nurses" = "29-1141",
							"Respiratory Therapists" = "29-1126",
							"Speech-Language Pathologists" = "29-1127",
							"Surgical Technologists" = "29-2055",
							"Veterinarians" = "29-1131",
							"Veterinary Technologists and Technicians" = "29-2056"
									),
						selected = "29-1061"
					)
				)
			),
			"Healthcare Support" = fluidRow(
				column(12,
					# br(),
					selectInput("treeocc", h5("Select Profession"),
						choices = c("All Professions" = "99-9999", "Dental Assistants" = "31-9091",
							"Home Health Aides" = "31-1011",
							"Massage Therapists" = "31-9011",
							"Medical Assistants" = "31-9092",
							"Medical Transcriptionists" = "31-9094",
							"Nursing Assistants" = "31-1014",
							"Occupational Therapy Assistants" = "32-2011",
							"Physical Therapist Assistants" = "31-2021",
							"Veterinary Assistants and Laboratory Animal Caretakers" = "31-9096"
									),
						selected = "31-9091"
					)
				)
			),
			"Protective Service" = fluidRow(
				column(12,
					# br(),
					selectInput("treeocc", h5("Select Profession"),
						choices = c("All Professions" = "99-9999", "Bailiffs" = "33-3011",
							"Detectives and Criminal Investigators" = "33-3021",
							"Fire Inspectors and Investigators" = "33-2021",
							"Firefighters" = "33-2011",
							"Gaming Surveillance Officers and Gaming Investigators" = "33-9031",
							"Private Detectives and Investigators" = "33-9021"
									),
						selected = "33-3011"
					)
				)
			),
			"Food Preparation and Serving Related" = fluidRow(
				column(12,
					# br(),
					selectInput("treeocc", h5("Select Profession"),
						choices = c("All Professions" = "99-9999", "Bartenders" = "35-3011",
							"Chefs and Head Cooks" = "35-1011",
							"Combined Food Preparation and Serving Workers, Including Fast Food" = "35-3021",
							"Cooks, Fast Food" = "35-2011",
							"Food Preparation Workers" = "35-2021",
							"Waiters and Waitresses" = "35-3031"
									),
						selected = "35-3011"
					)
				)
			),
			"Building and Grounds Cleaning and Maintenance" = fluidRow(
				column(12,
					# br(),
					selectInput("treeocc", h5("Select Profession"),
						choices = c("All Professions" = "99-9999", "First-Line Supervisors of Landscaping, Lawn Service, and Groundskeeping Workers" = "37-1012",
							"Janitors and Cleaners, Except Maids and Housekeeping Cleaners" = "37-2011",
							"Maids and Housekeeping Cleaners" = "37-2012",
							"Pest Control" = "37-2021"
									),
						selected = "37-1012"
					)
				)
			),
			"Personal Care and Service" = fluidRow(
				column(12,
					# br(),
					selectInput("treeocc", h5("Select Profession"),
						choices = c("All Professions" = "99-9999", "Animal Trainers" = "39-2011",
							"Barbers" = "39-5011",
							"Childcare Workers" = "39-9011",
							"Fitness Trainers and Aerobics Instructors" = "39-9031",
							"Manicurists and Pedicurists" = "39-5092",
							"Personal Care Aides" = "39-9021",
							"Recreation Workers" = "39-9032",
							"Skincare Specialists" = "39-5094"
									),
						selected = "39-2011"
					)
				)
			),
			"Sales and Related" = fluidRow(
				column(12,
					# br(),
					selectInput("treeocc", h5("Select Profession"),
						choices = c("All Professions" = "99-9999", "Advertising Sales Agents" = "41-3011",
							"Cashiers" = "41-2011",
							"Insurance Sales Agents" = "41-3021",
							"Models" = "41-9012",
							"Parts Salespersons" = "41-2022",
							"Real Estate Brokers" = "41-9021",
							"Sales Engineers" = "41-9031",
							"Sales Representatives, Wholesale and Manufacturing, Technical and Scientific Products" = "41-4011",
							"Securities, Commodities, and Financial Services Sales Agents" = "41-3031",
							"Travel Agents" = "41-3041"
									),
						selected = "41-3011"
					)
				)
			),
			"Office and Administrative Support" = fluidRow(
				column(12,
					# br(),
					selectInput("treeocc", h5("Select Profession"),
						choices = c("All Professions" = "99-9999", "Bill and Account Collectors" = "43-3011",
							"Billing and Posting Clerks" = "43-3021",
							"Bookkeeping, Accounting, and Auditing Clerks" = "43-3031",
							"Correspondence Clerks" = "43-4021",
							"Customer Service Representatives" = "43-4051",
							"Desktop Publishers" = "43-9031",
							"Executive Secretaries and Executive Administrative Assistants" = "43-6011",
							"Office Clerks, General" = "43-9061",
							"Police, Fire, and Ambulance Dispatchers" = "43-5031",
							"Postal Service Clerks" = "43-5051",
							"Production, Planning, and Expediting Clerks" = "43-5061",
							"Receptionists and Information Clerks" = "43-4171",
							"Tellers" = "43-3071"
									),
						selected = "43-3011"
					)
				)
			),
			"Farming, Fishing, and Forestry" = fluidRow(
				column(12,
					# br(),
					selectInput("treeocc", h5("Select Profession"),
						choices = c("All Professions" = "99-9999", "Animal Breeders" = "45-2021",
							"Fallers" = "45-4021",
							"Fishers and Related Fishing Workers" = "45-3011",
							"Forest and Conservation Workers" = "45-4011"
									),
						selected = "45-4011"
					)
				)
			),
			"Construction and Extraction" = fluidRow(
				column(12,
					# br(),
					selectInput("treeocc", h5("Select Profession"),
						choices = c("All Professions" = "99-9999", "Boilermakers" = "47-2011",
							"Brickmasons and Blockmasons" = "47-2021",
							"Carpenters" = "47-2037",
							"Cement Masons and Concrete Finishers" = "47-2051",
							"Construction and Building Inspectors" = "47-4011",
							"Construction Laborers" = "47-2061",
							"Drywall and Ceiling Tile Installers" = "47-2081",
							"Electricians" = "47-2111",
							"Elevator Installers and Repairers" = "47-4021",
							"Glaziers" = "47-2121",
							"Hazardous Materials Removal Workers" = "47-4041",
							"Insulation Workers, Floor, Ceiling, and Wall" = "47-2131",
							"Painters, Construction and Maintenance" = "47-2141",
							"Paving, Surfacing, and Tamping Equipment Operators" = "47-2071",
							"Plumbers, Pipefitters, and Steamfitters" = "47-2152",
							"Roofers" = "47-2181",
							"Sheet Metal Workers" = "47-2211",
							"Solar Photovoltaic Installers" = "47-2231",
							"Structural Iron and Steel Workers" = "47-2221",
							"Tile and Marble Setters" = "47-2044"
									),
						selected = "47-2011"
					)
				)
			),
			"Installation, Maintenance, and Repair" = fluidRow(
				column(12,
					# br(),
					selectInput("treeocc", h5("Select Profession"),
						choices = c("All Professions" = "99-9999", "Automotive Body and Related Repairers" = "49-3021",
							"Automotive Service Technicians and Mechanics" = "49-3023",
							"Avionics Technicians" = "49-2091",
							"Bus and Truck Mechanics and Diesel Engine Specialists" = "49-3031",
							"Computer, Automated Teller, and Office Machine Repairers" = "49-2011",
							"Electric Motor, Power Tool, and Related Repairers" = "49-2092",
							"Electrical Power-Line Installers and Repairers" = "49-9051",
							"Farm Equipment Mechanics and Service Technicians" = "49-3041",
							"Heating, Air Conditioning, and Refrigeration Mechanics and Installers" = "49-9021",
							"Industiral Machinery Mechanics" = "49-9041",
							"Maintenance and Repair Workers, General" = "49-9071",
							"Medical Equipment Repairers" = "49-9062",
							"Motorboat Mechanics and Service Technicians" = "49-3051",
							"Telecommunications Equipment Installers and Repairers, Except Line Installers" = "49-2022",
							"Wind Turbine Service Technicians" = "49-9081"
									),
						selected = "49-3021"
					)
				)
			),
			"Production" = fluidRow(
				column(12,
					# br(),
					selectInput("treeocc", h5("Select Profession"),
						choices = c("All Professions" = "99-9999", "Aircraft Structure, Surfaces, Rigging, and Systems Assembers" = "51-2011",
							"Bakers" = "51-2011",
							"Butchers and Meat Cutters" = "51-3021",
							"Cabinetmakers and Bench Carpenters" = "51-7011",
							"Coating, Painting, and Spraying Machine Setters, Operators, and Tenders" = "51-9121",
							"Computer-Controlled Machine Tool Operators, Metal and Plastic" = "51-4011",
							"Dental Laboratory Technicians" = "51-9081",
							"Food and Tobacco Roasting, Baking, and Drying Machine Operators and Tenders" = "51-3091",
							"Inspectors, Testers, Sorters, Samplers, and Weighers" = "51-9061",
							"Jewelers and Precious Stone and Metal Workers" = "51-9071",
							"Laundry and Dry-Cleaning Workers" = "51-6011",
							"Machinists" = "51-4041",
							"Nuclear Power Reactor Operators" = "51-8011",
							"Prepress Technicians and Workers" = "51-5111",
							"Semiconductor Processors" = "51-9141",
							"Slaughterers and Meat Packers" = "51-3023",
							"Stationany Engineers and Boiler Operators" = "51-8021",
							"Water and Wastewater Treatment Plant and System Operators" = "51-8031",
							"Welders, Cutters, Solderers, and Brazers" = "51-4121"
									),
						selected = "51-2011"
					)
				)
			),
			"Transporation and Material Moving" = fluidRow(
				column(12,
					# br(),
					selectInput("treeocc", h5("Select Profession"),
						choices = c("All Professions" = "99-9999", "Air Traffic Controllers" = "53-2021",
							"Airline Pilots, Copilots, and Flight Engineers" = "53-2011",
							"Bus Drivers, Transit and Intercity" = "53-3021",
							"Cleaners of Vehicles and Equipment" = "53-7061",
							"Conveyor Operators and Tenders" = "53-7011",
							"Driver/Sales Workers" = "53-3031",
							"Flight Attendants" = "53-2031",
							"Heavy and Tractor-Trailer Truck Drivers" = "53-3032",
							"Locomotive Engineers" = "53-4011",
							"Sailers and Marine Oilers" = "53-5011",
							"Taxi Drivers and Chauffeurs" = "53-3041"
									),
						selected = "11-1011"
					)
				)
			)
		)
	})

	output$localui <- renderUI({
		if (is.null(input$local_ind))
			return()
		
		switch(input$local_ind,
			"Management" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("Administrative Service Managers" = "11-3011",
							"Advertising and Promotions Managers" = "11-2011",
							"Architectural and Engineering Managers" = "11-9041",
							"Chief Executives" = "11-1011",
							"Compensation and Benefits Managers" = "11-3111",
							"Computer and Information Systems Managers" = "11-3021",
							"Construction Managers" = "11-9021",
							"Education Administrators, Elementary and Secondary School" = "11-9032",
							"Educaiton Administrators, Postsecondary" = "11-9033",
							"Education Administrators, Preschool and Childcare Center/Program" = "11-9031",
							"Farmers, Ranchers, and Other Agricultural Managers" = "11-9013",
							"Financial Managers" = "11-3031",
							"Food Service Managers" = "11-9051",
							"Gaming Managers" = "11-9071",
							"Human Resources Managers" = "11-3121",
							"Industrial Production Managers" = "11-3051",
							"Lodging Managers" = "11-9081",
							"Medical and Health Services Managers" = "11-9111",
							"Natural Sciences Managers" = "11-9121",
							"Property, Real Estate, and Community Association Managers" = "11-9141",
							"Public Relations and Fundraising Managers" = "11-2031",
							"Purchasing Managers" = "11-3061",
							"Sales Managers" = "11-2022",
							"Social and Community Service Managers" = "11-9151",
							"Training and Development Managers" = "11-3131"
							),
						selected = "11-3011"
					)
				)),
			"Business and Financial Operations" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("Accountants and Auditors" = "13-2011",
							"Appraisers and Assessors of Real Estate" = "13-2021",
							"Budget Analysts" = "13-2031",
							"Claims Adjusters, Examiners and Investigators" = "13-1031",
							"Compensation, Benefits, and Job Analysis Specialists" = "13-1141",
							"Cost Estimators" = "13-1051",
							"Financial Analysts" = "13-2051",
							"Financial Examiners" = "13-2061",
							"Fundraisers" = "13-1131",
							"Insurance Underwriters" = "13-2053",
							"Loan Officers" = "13-2072",
							"Logisticians" = "13-1081",
							"Management Analysts" = "13-1111",
							"Market Research Analysts and Marketing Specialists" = "13-1161",
							"Meeting, Convention, and Event Planners" = "13-1121",
							"Personal Financial Advisors" = "13-2052",
							"Tax Examiners and Collectors, and Revenue Agents" = "13-2081",
							"Training and Development Specialists" = "13-1151"
									),
						selected = "13-2011"
					)
				)
			),
			"Computer and Mathematical" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("Actuaries" = "15-2011",
							"Computer and Information Research Scientists" = "15-1111",
							"Computer Network Architects" = "15-1143",
							"Computer Programmers" = "15-1131",
							"Computer Systems Analysts" = "15-1121",
							"Computer User Support Specialists" = "15-1151",
							"Database Administrators" = "15-1141",
							"Information Security Analysts" = "15-1122",
							"Mathematicians" = "15-2021",
							"Network and Computer Systems Administrators" = "15-1142",
							"Operations Research Analysts" = "15-2031",
							"Software Developers, Applications" = "15-1132",
							"Statisticians" = "15-2041",
							"Web Developers" = "15-1134"
									),
						selected = "15-2011"
					)
				)
			),
			"Architecture and Engineering" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("Aerospace Engineering and Operations Technicians" = "17-3021",
							"Aerospace Engineers" = "17-2011",
							"Agricultural Engineers" = "",
							"Architects, Except Landscape and Naval" = "17-1011",
							"Architectural and Civil Drafters" = "17-3011",
							"Biomedical Engineers" = "17-2031",
							"Cartographers and Photogrammetrists" = "17-1021",
							"Chemical Engineers" = "17-2041",
							"Civil Engineering Technicians" = "17-3022",
							"Civil Engineers" = "17-2051",
							"Computer Hardware Engineers" = "17-2061",
							"Electrical and Electronics Engineering Technicians" = "17-3023",
							"Electrical Engineers" = "17-2071",
							"Electro-Mechanical Technicians" = "17-3024",
							"Environmental Engineering Technicians" = "17-3025",
							"Environmental Engineers" = "17-2081",
							"Health and Safety Engineers, Except Mining Safety Engineers and Inspectors" = "17-2111",
							"Industrial Engineering Technicians" = "17-3026",
							"Industrial Engineers" = "17-2112",
							"Landscape Architects" = "17-1012",
							"Marine Engineers and Naval Architects" = "17-2121",
							"Materials Engineers" = "17-2131",
							"Mechanical Engineering Technicians" = "17-3027",
							"Mechanical Engineers" = "17-2141",
							"Mining and Geological Engineers, Including Mining Safety Engineers" = "17-2151",
							"Nuclear Engineers" = "17-2161",
							"Petroleum Engineers" = "17-2171",
							"Surveying and Mapping Technicians" = "17-3031",
							"Surveyors" = "17-1022"
									),
						selected = "11-1011"
					)
				)
			),
			"Life, Physical and Social Science" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("Agricultural and Food Science Technicians" = "19-4011",
							"Animal Scientists" = "19-1011",
							"Anthropologists and Archeologists" = "19-3091",
							"Astronomers" = "19-2011",
							"Atmospheric and Space Scientists" = "19-2021",
							"Biochemists and Biophysicists" = "19-1021",
							"Biological Technicians" = "19-4021",
							"Chemical Technicians" = "19-4031",
							"Chemists" = "19-2031",
							"Clinical, Counseling, and School Psychologists" = "19-3031",
							"Conservation Scientists" = "19-1031",
							"Economists" = "19-3011",
							"Environmental Science and Protection Technicians, Including Health" = "19-4091",
							"Environmental Scientists and Specialists, Including Health" = "19-2041",
							"Epidemiologists" = "19-1041",
							"Forensic Science Technicians" = "19-4092",
							"Forest and Conservation Technicians" = "19-4093",
							"Geographers" = "19-3092",
							"Geological and Petroleum Technicians" = "19-4041",
							"Geoscientists, Except Hydrologists and Geographers" = "19-2042",
							"Historians" = "19-3093",
							"Hydrologists" = "19-2043",
							"Medical Scientists, Except Epidemiologists" = "19-1042",
							"Microbiologists" = "19-1022",
							"Nuclear Technicians" = "19-4051",
							"Political Scientists" = "19-3094",
							"Sociologists" = "19-3041",
							"Survey Researchers" = "19-3022",
							"Urban and Regional Planners" = "19-3051",
							"Zoologists and Wildlife Biologists" = "19-1023"
									),
						selected = "19-4011"
					)
				)
			),
			"Community and Social Service" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("Child, Family, and School Social Workers" = "21-1021",
							"Educational, Guidance, School, and Vocational Counselors" = "21-1012",
							"Health Educators" = "21-1091",
							"Marriage and Family Therapists" = "21-1013",
							"Probation Officers and Correctional Treatment Specialists" = "21-1092",
							"Rehabilitation Counselors" = "21-1015",
							"Social and Human Service Assistants" = "21-1093",
							"Substance Abuse and Behavioral Disorder Counselors" = "21-1011"
									),
						selected = "21-1021"
					)
				)
			),
			"Legal" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("Court Reporters" = "23-2091",
							"Lawyers" = "23-1011",
							"Paralegals and Legal Assistants" = "23-2011"
									),
						selected = "11-1011"
					)
				)
			),
			"Education, Training, and Library" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("Adult Basic and Secondary Education and Literacy Teachers and Instructors" = "25-3011",
							"Archivists" = "25-4011",
							"Instructional Coordinators" = "25-9031",
							"Kindergarten Teachers, Except Special Education" = "25-2012",
							"Librarians" = "25-4021",
							"Library Technicians" = "25-4031",
							"Middle School Teachers, Except Special/Technical Education" = "25-2022",
							"Preschool Teachers, Except Special Education" = "25-2011",
							"Secondary School Teachers, Except Special and Career/Technical Education" = "25-2031",
							"Special Education Teachers, Preschool" = "25-2051",
							"Teacher Assistants" = "25-9041",
							"Vocational Education Teachers, Postsecondary" = "25-1194"
									),
						selected = "25-3011"
					)
				)
			),
			"Arts, Design, Entertainment, Sports, and Media" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("Actors" = "27-2011",
							"Art Directors" = "27-1011",
							"Athletes and Sports Competitors" = "27-2021",
							"Audio and Video Equipment Technicians" = "27-4011",
							"Broadcast News Analysts" = "27-3021",
							"Camera Operators, Television, Video, and Motion Picture" = "27-4031",
							"Coaches and Scouts" = "27-2022",
							"Commercial and Industrial Designers" = "27-1021",
							"Craft Artists" = "27-1012",
							"Dancers" = "27-2031",
							"Editors" = "27-3041",
							"Fashion Designers" = "27-1022",
							"Floral Designers" = "27-1023",
							"Graphic Designers" = "27-1024",
							"Interior Designers" = "27-1025",
							"Interpreters and Translators" = "27-3091",
							"Multimedia Artists and Animators" = "27-1014",
							"Music Directors and Composers" = "27-2041",
							"Musicians and Singers" = "27-2042",
							"Photographers" = "27-4021",
							"Producers and Directors" = "27-2012",
							"Public Relations Specialists" = "27-3031",
							"Radio and Television Announcers" = "27-3011",
							"Technical Writers" = "27-3042",
							"Umpires, Referees, and Other Sports Officials" = "27-2023",
							"Writers and Authors" = "27-3043"
									),
						selected = "27-2011"
					)
				)
			),
			"Healthcare Practitioners and Technical" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("Anesthesiologists" = "29-1061",
							"Athletic Trainers" = "29-9091",
							"Audiologists" = "27-1181",
							"Cardiovascular Technologists and Technicians" = "29-2031",
							"Chiropractors" = "29-1011",
							"Dental Hygienists" = "29-2021",
							"Dentists, General" = "29-1021",
							"Dietitians and Nutritionists" = "29-1031",
							"Emergency Medical Technicians and Paramedics" = "29-2041",
							"Genetic Counselors" = "29-9092",
							"Licensed Practical and Licensed Vocational Nurses" = "29-2061",
							"Medical and Clinical Laboratory Technologists" = "29-2011",
							"Medical Records and Health Information Technicians" = "29-2071",
							"Nuclear Medicine Technologists" = "29-2033",
							"Nurse Anesthetists" = "29-1151",
							"Occupational Health and Safety Specialists" = "29-9011",
							"Occupational Health and Safety Technicians" = "29-9012",
							"Occupational Therapists" = "29-1122",
							"Opticians, Dispensing" = "29-2081",
							"Optometrists" = "29-1041",
							"Orthotists and Prosthetists" = "29-2091",
							"Pharmacists" = "29-1051",
							"Pharmacy Technicians" = "29-2052",
							"Physical Therapists" = "29-1123",
							"Physician Assistants" = "29-1071",
							"Podiatrists" = "29-1081",
							"Psychiatric Technicians" = "29-2053",
							"Radiation Therapists" = "29-1124",
							"Radiologic Technologists" = "29-2034",
							"Recreational Therapists" = "29-1125",
							"Registered Nurses" = "29-1141",
							"Respiratory Therapists" = "29-1126",
							"Speech-Language Pathologists" = "29-1127",
							"Surgical Technologists" = "29-2055",
							"Veterinarians" = "29-1131",
							"Veterinary Technologists and Technicians" = "29-2056"
									),
						selected = "29-1061"
					)
				)
			),
			"Healthcare Support" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("Dental Assistants" = "31-9091",
							"Home Health Aides" = "31-1011",
							"Massage Therapists" = "31-9011",
							"Medical Assistants" = "31-9092",
							"Medical Transcriptionists" = "31-9094",
							"Nursing Assistants" = "31-1014",
							"Occupational Therapy Assistants" = "32-2011",
							"Physical Therapist Assistants" = "31-2021",
							"Veterinary Assistants and Laboratory Animal Caretakers" = "31-9096"
									),
						selected = "31-9091"
					)
				)
			),
			"Protective Service" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("Bailiffs" = "33-3011",
							"Detectives and Criminal Investigators" = "33-3021",
							"Fire Inspectors and Investigators" = "33-2021",
							"Firefighters" = "33-2011",
							"Gaming Surveillance Officers and Gaming Investigators" = "33-9031",
							"Private Detectives and Investigators" = "33-9021"
									),
						selected = "33-3011"
					)
				)
			),
			"Food Preparation and Serving Related" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("Bartenders" = "35-3011",
							"Chefs and Head Cooks" = "35-1011",
							"Combined Food Preparation and Serving Workers, Including Fast Food" = "35-3021",
							"Cooks, Fast Food" = "35-2011",
							"Food Preparation Workers" = "35-2021",
							"Waiters and Waitresses" = "35-3031"
									),
						selected = "35-3011"
					)
				)
			),
			"Building and Grounds Cleaning and Maintenance" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("First-Line Supervisors of Landscaping, Lawn Service, and Groundskeeping Workers" = "37-1012",
							"Janitors and Cleaners, Except Maids and Housekeeping Cleaners" = "37-2011",
							"Maids and Housekeeping Cleaners" = "37-2012",
							"Pest Control" = "37-2021"
									),
						selected = "37-1012"
					)
				)
			),
			"Personal Care and Service" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("Animal Trainers" = "39-2011",
							"Barbers" = "39-5011",
							"Childcare Workers" = "39-9011",
							"Fitness Trainers and Aerobics Instructors" = "39-9031",
							"Manicurists and Pedicurists" = "39-5092",
							"Personal Care Aides" = "39-9021",
							"Recreation Workers" = "39-9032",
							"Skincare Specialists" = "39-5094"
									),
						selected = "39-2011"
					)
				)
			),
			"Sales and Related" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("Advertising Sales Agents" = "41-3011",
							"Cashiers" = "41-2011",
							"Insurance Sales Agents" = "41-3021",
							"Models" = "41-9012",
							"Parts Salespersons" = "41-2022",
							"Real Estate Brokers" = "41-9021",
							"Sales Engineers" = "41-9031",
							"Sales Representatives, Wholesale and Manufacturing, Technical and Scientific Products" = "41-4011",
							"Securities, Commodities, and Financial Services Sales Agents" = "41-3031",
							"Travel Agents" = "41-3041"
									),
						selected = "41-3011"
					)
				)
			),
			"Office and Administrative Support" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("Bill and Account Collectors" = "43-3011",
							"Billing and Posting Clerks" = "43-3021",
							"Bookkeeping, Accounting, and Auditing Clerks" = "43-3031",
							"Correspondence Clerks" = "43-4021",
							"Customer Service Representatives" = "43-4051",
							"Desktop Publishers" = "43-9031",
							"Executive Secretaries and Executive Administrative Assistants" = "43-6011",
							"Office Clerks, General" = "43-9061",
							"Police, Fire, and Ambulance Dispatchers" = "43-5031",
							"Postal Service Clerks" = "43-5051",
							"Production, Planning, and Expediting Clerks" = "43-5061",
							"Receptionists and Information Clerks" = "43-4171",
							"Tellers" = "43-3071"
									),
						selected = "43-3011"
					)
				)
			),
			"Farming, Fishing, and Forestry" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("Animal Breeders" = "45-2021",
							"Fallers" = "45-4021",
							"Fishers and Related Fishing Workers" = "45-3011",
							"Forest and Conservation Workers" = "45-4011"
									),
						selected = "45-4011"
					)
				)
			),
			"Construction and Extraction" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("Boilermakers" = "47-2011",
							"Brickmasons and Blockmasons" = "47-2021",
							"Carpenters" = "47-2037",
							"Cement Masons and Concrete Finishers" = "47-2051",
							"Construction and Building Inspectors" = "47-4011",
							"Construction Laborers" = "47-2061",
							"Drywall and Ceiling Tile Installers" = "47-2081",
							"Electricians" = "47-2111",
							"Elevator Installers and Repairers" = "47-4021",
							"Glaziers" = "47-2121",
							"Hazardous Materials Removal Workers" = "47-4041",
							"Insulation Workers, Floor, Ceiling, and Wall" = "47-2131",
							"Painters, Construction and Maintenance" = "47-2141",
							"Paving, Surfacing, and Tamping Equipment Operators" = "47-2071",
							"Plumbers, Pipefitters, and Steamfitters" = "47-2152",
							"Roofers" = "47-2181",
							"Sheet Metal Workers" = "47-2211",
							"Solar Photovoltaic Installers" = "47-2231",
							"Structural Iron and Steel Workers" = "47-2221",
							"Tile and Marble Setters" = "47-2044"
									),
						selected = "47-2011"
					)
				)
			),
			"Installation, Maintenance, and Repair" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("Automotive Body and Related Repairers" = "49-3021",
							"Automotive Service Technicians and Mechanics" = "49-3023",
							"Avionics Technicians" = "49-2091",
							"Bus and Truck Mechanics and Diesel Engine Specialists" = "49-3031",
							"Computer, Automated Teller, and Office Machine Repairers" = "49-2011",
							"Electric Motor, Power Tool, and Related Repairers" = "49-2092",
							"Electrical Power-Line Installers and Repairers" = "49-9051",
							"Farm Equipment Mechanics and Service Technicians" = "49-3041",
							"Heating, Air Conditioning, and Refrigeration Mechanics and Installers" = "49-9021",
							"Industiral Machinery Mechanics" = "49-9041",
							"Maintenance and Repair Workers, General" = "49-9071",
							"Medical Equipment Repairers" = "49-9062",
							"Motorboat Mechanics and Service Technicians" = "49-3051",
							"Telecommunications Equipment Installers and Repairers, Except Line Installers" = "49-2022",
							"Wind Turbine Service Technicians" = "49-9081"
									),
						selected = "49-3021"
					)
				)
			),
			"Production" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("Aircraft Structure, Surfaces, Rigging, and Systems Assembers" = "51-2011",
							"Bakers" = "51-2011",
							"Butchers and Meat Cutters" = "51-3021",
							"Cabinetmakers and Bench Carpenters" = "51-7011",
							"Coating, Painting, and Spraying Machine Setters, Operators, and Tenders" = "51-9121",
							"Computer-Controlled Machine Tool Operators, Metal and Plastic" = "51-4011",
							"Dental Laboratory Technicians" = "51-9081",
							"Food and Tobacco Roasting, Baking, and Drying Machine Operators and Tenders" = "51-3091",
							"Inspectors, Testers, Sorters, Samplers, and Weighers" = "51-9061",
							"Jewelers and Precious Stone and Metal Workers" = "51-9071",
							"Laundry and Dry-Cleaning Workers" = "51-6011",
							"Machinists" = "51-4041",
							"Nuclear Power Reactor Operators" = "51-8011",
							"Prepress Technicians and Workers" = "51-5111",
							"Semiconductor Processors" = "51-9141",
							"Slaughterers and Meat Packers" = "51-3023",
							"Stationany Engineers and Boiler Operators" = "51-8021",
							"Water and Wastewater Treatment Plant and System Operators" = "51-8031",
							"Welders, Cutters, Solderers, and Brazers" = "51-4121"
									),
						selected = "51-2011"
					)
				)
			),
			"Transporation and Material Moving" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("Air Traffic Controllers" = "53-2021",
							"Airline Pilots, Copilots, and Flight Engineers" = "53-2011",
							"Bus Drivers, Transit and Intercity" = "53-3021",
							"Cleaners of Vehicles and Equipment" = "53-7061",
							"Conveyor Operators and Tenders" = "53-7011",
							"Driver/Sales Workers" = "53-3031",
							"Flight Attendants" = "53-2031",
							"Heavy and Tractor-Trailer Truck Drivers" = "53-3032",
							"Locomotive Engineers" = "53-4011",
							"Sailers and Marine Oilers" = "53-5011",
							"Taxi Drivers and Chauffeurs" = "53-3041"
									),
						selected = "11-1011"
					)
					# includeHTML("aboutmultiline.html")
				)
				)
		)
	})
	getdataindclassvar <- reactive({
		results <- input$dataindclassvar
		return(results)
	})
	getdatatype <- reactive({
		results <- input$dataplotbutton
		return(results)
	})
	getaddstates <- reactive({
			results<- input$addstates
			return(results)
		})
	getaddprofs <- reactive({
			results<- input$addprofs
			return(results)
	})
	getindustry <- reactive({
		results <- input$input_type
		return(results)
	})
	getoverviewind <- reactive({
		results <- input$input_industry
		return(results)
	})
	getoverview <- reactive({
		results <- input$radio_overview
		return(results)
	})
	gettreedf <- reactive({
		if(input$tree_df=="National") {
			results <- oohoesnat
		}
		if(input$tree_df=="State") {
			results <- oohoesstate
		}
		if(input$tree_df=="Industry") {
			results <- oohoesstate
		}
		if(input$tree_df=="Profession") {
			results <- oohoesstate
		}
		return(results)
	})
	gettreeind <- reactive({
		results <- input$tree_industry
		return(results)
	})
	gettreetype <- reactive({
		results <- input$tree_df
		return(results)
	})
	gettreestate <- reactive({
		results <- input$tree_state
		return(results)
	})
	gettreecategory <- reactive({
		results <- input$tree_category
		return(results)
	})
	gettreescale <- reactive({
		results <- input$tree_scale
		return(results)
	})
	gettreeocc <- reactive({
		results <- input$treeocc
		return(results)
	})

	getlocalind <- reactive ({
		results <- input$local_ind
		return(results)
	})
	getocc <- reactive ({
		results <- input$occ
		return(results)
	})
	getstate <- reactive ({
		results <- input$state_select
		return(results)
	})
	gettsort <- reactive ({
		results <- input$table_sort
		return(results)
	})
	gettableoverview <- reactive ({
		results <- input$tableoverview_sort
		return(results)
	})
	getdorpplot <- reactive ({
		results <- input$dorpplot
		return(results)
	})
	getdorpplotlocal <- reactive ({
		results <- input$dorpplotlocal
		return(results)
	})
	getlat <- reactive ({
		results <- input$latnudge
		return(results)
	})
	output$dataplotResults <- renderPlot ({
		dataplotResults <- dataplot_function(oohoesmetrogeo, getdatatype(),
		getdataindclassvar(), getaddstates(), getaddprofs())
		print(dataplotResults)
	}, width = 700, height = 600)

	output$textResults <- renderText ({
		textResults <- text_function(oohoesmetrogeo, getocc())
	})
	
	output$tableResults <- renderTable ({
		tableResults <- table_function(oohoesmetrogeo, getocc(), getstate(),
			gettsort())
	})

	output$natplotResults <- renderPlot ({
		natplotResults <- natplot_function(oohoesmetrogeo, getindustry(),
		getdorpplot())
		print(natplotResults)
	}, width = 700, height = 600)

	output$natoverviewResults <- renderPlot ({
		natoverviewResults <- natwage_function(oesnatgroup,
			getoverviewind(), getoverview())
		print(natoverviewResults)
	}, width = 700, height = 600)

	output$overviewstatsResults <- renderTable ({
		overviewstatsResults <- overviewstats_function(oohoesnat,
		oesnatgroup, getoverviewind())
	})

	output$tableoverviewResults <- renderTable ({
		tableoverviewResults <- table_overviewfunction(oesnatgroup,
		gettableoverview())
	})

	output$treeResults <- renderPlot ({
		treeResults <- tree_function(gettreedf(), gettreetype(),
		gettreeind(), gettreestate(), gettreecategory(),
			gettreescale(), gettreeocc())
		print(treeResults)
	}, width = 700, height = 600)

	output$localplotResults <- renderPlot ({
		localplotResults <- plot_function(oohoesmetrogeo,
			getlocalind(), getocc(), getstate(), getvar(),
			stateneighbors, getdorpplotlocal())
		print(localplotResults)
	}, width = 700, height = 600)
})
