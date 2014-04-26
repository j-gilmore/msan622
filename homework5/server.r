require(ggplot2)
require(grid)
require(scales)
library(RColorBrewer)

source("data.r")
source("handsome.r")

## h = heatmap
## a = area plot
## m = multi-line

plot_function <- function(plottype, colorscheme, heattype, areatype, smtype, yearrange) {

	indices <- which(seatbelts$year>=yearrange[1] & seatbelts$year <=yearrange[2])
	seatbeltssub <- seatbelts[indices,]
	moltensub <- melt(seatbeltssub, id = c("year", "month", "time"))

	indicesarea <- which(seatbeltsarea$year>=yearrange[1] & seatbeltsarea$year <=yearrange[2])
	seatbeltssubarea <- seatbeltsarea[indices,]
	moltensubarea <- melt(seatbeltssubarea, id = c("year", "month", "time"))

	if(plottype=="Heatmaps") {
		h <- ggplot(
			subset(moltensub, variable == "dkilled"),
			aes(x = month, y = year))

		h <- h + geom_tile(
			aes(fill = value),
			colour = "white")
			
		h <- h + scale_clr(colorscheme)
		h <- h + scale_y_discrete(expand = c(0, 0))
		h <- h + theme(axis.text.x=element_text(face="bold"))
		h <- h + theme(axis.text.y=element_text(face="bold"))
		h <- h + theme(plot.title = element_text(face="bold"))
		h <- h + theme_heatmap()
		if(heattype=="heatfixedcoord") {
			h <- h + coord_fixed(ratio = 1)
			h <- h + ggtitle("Traditional Heatmap")
		}
		if(heattype=="heatpolarcoord") {
			h <- h + coord_polar()
			h <- h + theme(axis.text.y=element_text(angle=0))
			h <- h + ggtitle("Polar Coordinates Heatmap")
		}
		return(print(h))
	}
	if(plottype=="Area Chart") {
		a <- ggplot(moltensubarea, aes(x = time, y = value))
		a <- a + geom_area(
    		data = subset(moltensubarea, variable != "total"),
    		aes(
        	group = variable,
        	fill = variable,
        	# not really necessary
        	color = variable,
        	# swap stacking order
			order = -as.numeric(variable)
    		)
		)
		# make it handsome
		a <- a + scale_year(yearrange)
		a <- a + scale_deathsarea()		
		a <- a + theme_legend()
		a <- a + theme(axis.text.x=element_text(face="bold"))
		a <- a + theme(axis.text.y=element_text(face="bold"))
		a <- a + theme(legend.text=element_text(face="bold"))
		a <- a + theme(plot.title = element_text(face="bold"))
		a <- a + theme(axis.title.x=element_blank())
		a <- a + scale_colour_brewer(palette=colorscheme)
		a <- a + scale_fill_brewer(palette=colorscheme)
		if(areatype=="areafixed") {
		# squarify grid (1 year to 1000 deaths)
			a <- a + coord_fixed(ratio = 1 / 500)
			a <- a + ggtitle("Area Chart")
		}
		if(areatype=="areapolar") {
			# CREATE STAR-LIKE PLOT ###############
			a <- a + coord_polar()
			a <- a + ggtitle("Polar Coordinates 'Star' Chart")
		}
		return(a)
	}
	if(plottype=="Multi-Line") {
		m <- ggplot(moltensubarea, aes(x = month, y = value))
		m <- m + geom_line(
    		data = subset(moltensubarea, variable != "total"),
    		aes(
        	group = variable,
        	# fill = variable,
        	# not really necessary
        	color = variable,
        	# swap stacking order
			order = -as.numeric(variable)
    		)
		)
		# make it handsome
		m <- m + scale_months()
		m <- m + scale_deathsmulti()
		m <- m + theme_legend()
		m <- m + theme(axis.text.x=element_text(face="bold"))
		m <- m + theme(axis.text.y=element_text(face="bold"))
		m <- m + theme(legend.text=element_text(face="bold"))
		m <- m + theme(axis.title.x=element_blank())
		m <- m + scale_colour_brewer(palette=colorscheme)
		m <- m + scale_fill_brewer(palette=colorscheme)
		m <- m + theme(plot.title = element_text(face="bold"))

 		if(smtype=="smfacet") {
			# CREATE FACET PLOT ###################
		m <- m + facet_wrap(~ year, ncol = 2)
		m <- m + theme(legend.position = "right")
		m <- m + theme(legend.direction="vertical")
		m <- m + ggtitle("Small Multiples Line Plot")
		}
 		if(smtype=="smpolar") {
			# CREATE FACET PLOT ###################
		m <- m + coord_polar()
		m <- m + ggtitle("Polar Coordinates 'Star' Plot")
		}
		return(print(m))
	}
}

shinyServer(function(input, output) {
	
	cat("Press \"ESC\" to exit...\n")

	output$ui <- renderUI({
		if (is.null(input$input_type))
			return()
		
		switch(input$input_type,
			"Heatmaps" = fluidRow(
				column(12,
					br(),
					radioButtons("heattype", h5("Type of Heatmap"),
						choices = c("Fixed Coordinates" = "heatfixedcoord",
									"Polar Coordinates" = "heatpolarcoord"),
						selected = "heatfixedcoord"
					),
					includeHTML("aboutheatmaps.html")
				)),
			"Area Chart" = fluidRow(
				column(12, "Please be patient.  Some plots load slowly.",
					br(),
					radioButtons("areatype", h5("Type of Area Chart"),
						choices = c("Fixed Coordinates" = "areafixed",
									"Polar Coordinates" = "areapolar"),
						selected = "areafixed"
					),
					includeHTML("aboutareacharts.html")
				)
			),
			"Multi-Line" = fluidRow(
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
	getplot <- reactive({
		results <- input$input_type
		return(results)
	})
	getcolor <- reactive({
		if(input$input_type=="Heatmaps") {
			results <- "RdBu"
		}
		else {
			results <- "Set1"
		}
		return(results)
	})

	getheat <- reactive ({
		results <- input$heattype
		return(results)
	})
	getarea <- reactive ({
		results <- input$areatype
		return(results)
	})
	getsm <- reactive ({
		results <- input$smtype
		return(results)
	})

	output$plotResults <- renderPlot ({
		plotResults <- plot_function(getplot(), getcolor(), getheat(), 
		getarea(), getsm(), input$yearrange)
		print(plotResults)
	}, width = 700, height = 600)
})