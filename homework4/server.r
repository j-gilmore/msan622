library(wordcloud)
library(ggplot2)
library(reshape2)
library(grid)
library(shiny)

source("dante.r")

corp_df <- data.frame(
    Inferno = dante_matrix[, "danteinferno.txt"],
    Purgatory = dante_matrix[, "dantepurgatory.txt"],
    Paradise = dante_matrix[, "danteparadise.txt"],
    stringsAsFactors = FALSE)

corp_matrix <- as.matrix(corp_df)

common_corp_df <- corp_df
common_corp_df[corp_df==0] <- NA
common_corp_df <- common_corp_df[!is.na(common_corp_df[1]) & !is.na(common_corp_df[2]) & !is.na(common_corp_df[3]),]

common_corp_df$wordsums <- rowSums(common_corp_df)
common_corp_df <- common_corp_df[with(common_corp_df, order(-wordsums)),]

common_corp_df <- common_corp_df[1:3]

plot_list <- list()

plot_function <- function(data, plot_type, cloudtype, books, wordcount, colorScheme, bg) {
	palette <- rev(brewer.pal(3,colorScheme))
	corp_m <- as.matrix(data)
	par(mfrow=c(1,1), bg=bg)
	if(plot_type=="bar") {
		bar_df <- head(data[books], wordcount)
		bar_df$word <- rownames(bar_df)
		bar_df <- melt(bar_df, id.vars = "word")
		for(i in bar_df$word) {
			p <- ggplot(bar_df, aes("i", value)) +
			geom_bar(aes(fill=variable),
			position ="dodge",
			stat="identity",
			width=.25) +
			theme(panel.grid.major = element_blank(),
			panel.grid.minor = element_blank(),
			panel.background = element_rect(fill="white"),
			plot.background = element_blank(),
			axis.ticks = element_blank(),
			axis.text.x = element_blank(),
			axis.text.y = element_blank(),
			axis.title.x = element_blank(),
			axis.title.y = element_blank(),
			legend.title = element_blank(),
			legend.text = element_text(size=14, face="bold")) +
			ggtitle(expression(bold("Frequent Word Stems\n"))) +
			scale_fill_manual(values=palette[books]) + # or [1:3]
			facet_wrap( ~ word, ncol=3) +
			theme(strip.background = element_rect(fill = "white"),
			panel.margin = unit(2,"lines"),
			strip.text = element_text(size = 12, face="bold")) 

			plot_list<- p
			return(plot_list)
		}
	}
	if(cloudtype=="comparison") {
		comparison.cloud(corp_m, max.words=200,
		random.order=FALSE,colors=palette,
		title.size = .001,
		main="Differences Between Inferno, Purgatory and Paradise")
	}
	if(cloudtype=="commonality") {
		commonality.cloud(corp_m, max.words=200, 
		random.order=FALSE, color=palette,
		main="Commonality Between Inferno, Purgatory, and Paradise")
	}
	if(cloudtype=="inferno") {
		inferno_df <- corp_df[1]
		inferno_matrix <- as.matrix(inferno_df)
		commonality.cloud(inferno_matrix, max.words=100,
		random.order=FALSE,color=palette[1],main="Inferno")
	}
	if(cloudtype=="purgatory") {
		purgatory_df <- corp_df[2]
		purgatory_matrix <- as.matrix(purgatory_df)
		commonality.cloud(purgatory_matrix, max.words=100,
		random.order=FALSE,color=palette[2],main="Purgatory")
	}
	if(cloudtype=="paradise") {
		paradise_df <- corp_df[3]
		paradise_matrix <- as.matrix(paradise_df)
		commonality.cloud(paradise_matrix, max.words=100,
		random.order=FALSE,color=palette[3],main="Paradise")
	}
	if(plot_type=="manyeyes") {
		commonality.cloud(corp_m, max.words=100, 
		random.order=TRUE, color=palette,
		main="Commonality Between Inferno, Purgatory, and Paradise")
	}
}

##

shinyServer(function(input, output) {
	
	cat("Press \"ESC\" to exit...\n")

	output$ui <- renderUI({
		if (is.null(input$input_type))
			return()
		
		switch(input$input_type,
			"Word Use" = fluidRow(
				column(6, h5("Books"),
					checkboxInput("Inferno", "Inferno",
									value = TRUE
					),
					checkboxInput("Purgatory", "Purgatory",
									value = TRUE
					),
					checkboxInput("Paradise", "Paradise",
									value = TRUE
					)
					),
				column(6,
					sliderInput(inputId = "wordcount", 
						label = h5("Number of Words"), 
						min = 1, max = 24, value = 12, step = 1
					)),
					br(),
					br(),
					includeHTML("aboutwordstems.html")
				),
			"Word Cloud" = fluidRow(
				column(12, "Please be patient.  Some plots load slowly.",
					br(),
					radioButtons("cloudtype", h5("Type of Cloud"),
						choices = c("Commonality Cloud" = "commonality",
									"Comparison Cloud" = "comparison",
									"Inferno Only" = "inferno",
									"Purgatory Only" = "purgatory",
									"Paradise Only" = "paradise"),
						selected = "commonality"
					),
					includeHTML("aboutclouds.html")
				)
			),
			"Many Eyes" = fluidRow(
				column(12,
					includeHTML("aboutmanyeyes.html"),

					h5("Click below to go to Many Eyes:"),
					helpText( a("Phrase Net of The Divine Comedy", href="http://www.manyeyes.com/software/analytics/manyeyes/visualizations/dantes-the-divine-comedy-phrase-ne", target="_blank")),
					helpText( a("Word Tree of The Divine Comedy", href="http://www.manyeyes.com/software/analytics/manyeyes/visualizations/dantes-the-divine-comedy-word-tree", target="_blank"))

				)
				)
		)
	})
	getdata <- reactive({
		if(input$input_type=="Word Use") {
			return(common_corp_df)
		}
		if(input$input_type=="Word Cloud") {
			return(corp_df)
		}
		if(input$input_type=="Many Eyes") {
			return(corp_df)
		}
	})
	getplottype <- reactive({
		if(input$input_type=="Word Use") {
			return("bar")
		}
		if(input$input_type=="Word Cloud") {
			return("wordcloud")
		}
		if(input$input_type=="Many Eyes") {
			return("manyeyes")
		}
	})
	getbooks <- reactive ({
		results <- c(input$Inferno, input$Purgatory, input$Paradise)
		return(results)
	})
	getcolor <- reactive({
		return(input$colorScheme)
	})
	getcloudtype <- reactive({
		return(input$cloudtype)
	})
	getimagetype <- reactive({
		return(input$image)
	})
	

	output$plotResults <- renderPlot ({
		plotResults <- plot_function(getdata(), getplottype(), 
		getcloudtype(), getbooks(), input$wordcount, getcolor(), "black")
		print(plotResults)
	}, width = 700, height = 600)
	
})