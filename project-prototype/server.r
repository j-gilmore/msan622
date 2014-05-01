library(data.table)
library(ggplot2)
library(ggmap)
library(shiny)
library(stringr)

oohoesnat <- read.csv("~/oohoesnat.csv", stringsAsFactors=FALSE)
oohoesstate <- read.csv("~/oohoesstate.csv", stringsAsFactors=FALSE)
oohoesmetrogeo <- read.csv("~/oohoesmetrogeo.csv", stringsAsFactors=FALSE)
stateneighbors <- read.csv("~/neighbors.csv")
statelatloncenter <- read.csv("~/state_latlon.csv")

text_function <- function(df, occ) {
	subset <- df[which(df$OCC_CODE==occ),]
	subset$description <- as.character(subset$description)
	textout <- subset$description[[1]][1]
	return(print(textout))
}

# text_function(oohoesmetrogeo, "11-1011")

table_function <- function(df, occ, statevar, tsort) {
	subset <- df[which(df$OCC_CODE==occ & df$PRIM_STATE==statevar),]
	subset <- subset[c(3,9,11,13,14)]
	subset$JOBS_1000 <- as.numeric(subset$JOBS_1000)
	subset$H_MEAN <- as.numeric(subset$H_MEAN)	
	if(tsort=="TOT_EMP") {
		subset <- subset[order(-subset$TOT_EMP),]	
	}
	if(tsort=="JOBS_1000") {
		subset <- subset[order(-subset$JOBS_1000),]	
	}
	if(tsort=="H_MEAN") {
		subset <- subset[order(-subset$H_MEAN),]	
	}
	if(tsort=="A_MEAN") {
		subset <- subset[order(-subset$A_MEAN),]	
	}	
	subset <- subset[1:10,]
	colnames(subset) <- c("City", "TotalEmployed", "JobsPer1000", "HourlyMean", "AnnualMean")
	describetable <- data.table(subset)
	return(describetable)
}

# table_function(oohoesmetrogeo, "11-1011", "CA", "TOT_EMP")

plot_function <- function(df, occ, statevar, var, zoomval, latnudge, lonnudge, stateneighbors) {
	statecenter<- statelatloncenter[which(statelatloncenter$state==statevar),]
	statecenter<- c(statecenter$longitude, statecenter$latitude)
	statezoom<- statelatloncenter[which(statelatloncenter$state==statevar),]
	statezoom<- statezoom$zoomval
	map<- get_map(statecenter, zoom=statezoom, color="bw")
	# maptype="satellite"
	# color = "bw"
	
	statensub<- stateneighbors[which(stateneighbors$state==statevar),]
	staten <- str_split(statensub$neighbors, ", ")
	staten <- staten[[1]]
	
	subsetdf <- df[which(df$OCC_CODE==occ & df$PRIM_STATE==statevar),]
	subsetn <- df[which(df$OCC_CODE==occ & df$PRIM_STATE==staten),]

	assign("subsetdf", subsetdf, envir=globalenv())
	assign("subsetn", subsetn, envir=globalenv())

	# if(var=="TOT_EMP") {
		# var_input <- subsetdf$TOT_EMP
		# return(var_input)
	# }

	titlelab <- paste(subsetdf$OCC_TITLE, ": sized by Total Employed", sep="")

	p <- ggmap(map, extent = "panel", maprange=FALSE) +
		geom_point(data=subsetdf, aes(x=longitude, y=latitude, 
		size = subsetdf$TOT_EMP),
		colour = "red",
		alpha = .7) +
		# geom_text(data = subsetdf, aes(x=longitude, y=latitude,
		# label = subsetdf$A_MEDIAN), size = 4) +
		geom_point(data=subsetn, aes(x=longitude, y=latitude),
		colour = "blue",
		alpha = 1, size = 4) +
		# geom_polygon(aes(x = long, y = lat, group = group), data = datam,
		# colour = "white", fill = "black", alpha = .4, size = .3) +
		scale_size_area(max_size=10, guide = "none") +
		ggtitle(titlelab) +
		theme(plot.title = element_text(size=18, face="bold")) +
		theme(plot.title = element_text(vjust=2)) +
		# annotate("text", y=max(subsetdf$latitude),
		# x=max(subsetdf$longitude), label=titlelab, hjust=1) +
		theme(axis.ticks.x = element_blank()) +
		theme(axis.ticks.y = element_blank()) +
		theme(axis.text.x = element_blank()) +
		theme(axis.text.y = element_blank()) +
		theme(legend.position = "none", axis.title=element_blank(), 
			text = element_text(size=12))
		
	return(print(p))
}

# plot_function(oohoesmetrogeo, "Chief Executives", "NY", "TOT_EMP", 6, 0, 0, stateneighbors)

shinyServer(function(input, output) {
	
	cat("Press \"ESC\" to exit...\n")

	output$ui <- renderUI({
		if (is.null(input$input_type))
			return()
		
		switch(input$input_type,
			"Management" = fluidRow(
				column(12,
					# br(),
					selectInput("occ", h5("Select Profession"),
						choices = c("Chief Executives" = "11-1011",
							"Advertising and Promotions" = "11-2011",
							"Sales Managers" = "11-2022",
							"Public Relations and Fund Raising" = "11-2031",
							"Administrative Service Managers" = "11-3011",
							"Computer and Info Systems Management" = "11-3021",
							"Financial Managers" = "11-3031",
							"Industrial Production Managers" = "11=3051",
							"Purchasing Managers" = "11-3061",
							"Compensation and Benefits Managers" = "11-3111",
							"Human Resource Managers" = "11-3121",
							"Training and Development Managers" = "11-3131",
							"Farmers, Ranchers, and Other Agg Managers" = "11-9013",
							"Construction Managers" = "11-9021",
							"Education Administrators, Preschool and Childcare" = "11-9031",
							"Education Administrators, Elementary and Secondary Ed." = "11-9032",
							"Education Administrators, Postsecondary" = "11-9033",
							"Architectural and Engineering Managers" = "11-9041",
							"Food Service Managers" = "11-9051",
							"Gaming Managers" = "11-9071",
							"Lodging Managers" = "11-9081",
							"Medical and Health Services Managers" = "11-9111",
							"Natural Sciences Managers" = "11-9121",
							"Property, Real Estate, and Community Association Managers" = "11-9141",
							"Social and Community Service Managers" = "11-9151"
							),
						selected = "11-1011"
					)
				)),
			"Additional Industry" = fluidRow(
				column(12,
					br(),
					radioButtons("areatype", h5("Type of Area Chart"),
						choices = c("Fixed Coordinates" = "areafixed",
									"Polar Coordinates" = "areapolar"),
						selected = "areafixed"
					),
					includeHTML("aboutareacharts.html")
				)
			),
			"Additional Industry" = fluidRow(
				column(12,
					br(),
					radioButtons("smtype", h5("Type of Multiples Plot"),
						choices = c("Small Multiples" = "smfacet",
									"Polar Coordinates" = "smpolar"),
						selected = "smfacet"
					),
					includeHTML("aboutmultiline.html")
				)
				)
		)
	})
	getindustry <- reactive({
		results <- input$input_type
		return(results)
	})
	getheat <- reactive({
		if(input$input_type=="Heatmaps") {
			results <- "RdBu"
		}
		else {
			results <- "Set1"
		}
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
	getlon <- reactive ({
		results <- input$lonnudge
		return(results)
	})
	getlat <- reactive ({
		results <- input$latnudge
		return(results)
	})

	output$textResults <- renderText ({
		textResults <- text_function(oohoesmetrogeo, getocc())
	})
	
	output$tableResults <- renderTable ({
		tableResults <- table_function(oohoesmetrogeo, getocc(), getstate(),
			gettsort())
	})

	output$plotResults <- renderPlot ({
		plotResults <- plot_function(oohoesmetrogeo, getocc(), getstate(), 
		getvar(), 6, getlat(), getlon(), stateneighbors)
		print(plotResults)
	}, width = 700, height = 600)
})