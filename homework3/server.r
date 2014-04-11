## Jeremy Gilmore
## MSAN 622

## Homework 3

library(ggplot2)
library(grid)
library(shiny)
library(lattice)
library(GGally)
library(reshape2)

df <- data.frame(state.x77,
	State = state.name,
	Abbrev = state.abb,
	Region = state.region,
	Division = state.division,
	Long = state.center$x,
	Lat = state.center$y
)

# Add New Variables
Pop.Density <- (df$Population/df$Area) # to get population density per state
df$Pop.Density <- Pop.Density
Pop.Nation <- sum(df$Population)
StatePercNatPop <- (df$Population/Pop.Nation)
df$StatePercNatPop <- StatePercNatPop
df$Illiteracy <- df$Illiteracy/100
NatIllRate <- (sum((df$Illiteracy/100)*df$Population)/Pop.Nation)
df$Murder <- df$Murder/100
NatMurderRate <- mean(df$Murder)
df$HS.Grad <- df$HS.Grad/100
NatHSGradRate <- mean(df$HS.Grad)

# Income Variables
GDP <- (sum((df$Population*df$Income)))
StateIncome <- df$Population*df$Income
df$StateIncome <- StateIncome
DivisionIncome <- rowsum(df$StateIncome, df$Division)
RegionIncome <- rowsum(df$StateIncome, df$Region)
df$StateIncGDP <- df$StateIncome/GDP

DivIncGDP <- DivisionIncome/GDP
RegIncGDP <- RegionIncome/GDP

# Apply Division Income to each row of dataset
df$DivisionIncome <- rep(NA, nrow(df))
levelsDivision <- levels(df$Division)
df$DivisionIncome[which(df$Division == "New England")] = DivisionIncome[1,]
df$DivisionIncome[which(df$Division == "Middle Atlantic")] = DivisionIncome[2,]
df$DivisionIncome[which(df$Division == "South Atlantic")] = DivisionIncome[3,]
df$DivisionIncome[which(df$Division == "East South Central")] = DivisionIncome[4,]
df$DivisionIncome[which(df$Division == "West South Central")] = DivisionIncome[5,]
df$DivisionIncome[which(df$Division == "East North Central")] = DivisionIncome[6,]
df$DivisionIncome[which(df$Division == "West North Central")] = DivisionIncome[7,]
df$DivisionIncome[which(df$Division == "Mountain")] = DivisionIncome[8,]
df$DivisionIncome[which(df$Division == "Pacific")] = DivisionIncome[9,]

# Assign Region Income to each row of dataset
df$RegionIncome <- rep(NA, nrow(df))
df$RegionIncome[which(df$Region == "Northeast")] = RegionIncome[1,]
df$RegionIncome[which(df$Region == "South")] = RegionIncome[2,]
df$RegionIncome[which(df$Region == "North Central")] = RegionIncome[3,]
df$RegionIncome[which(df$Region == "West")] = RegionIncome[4,]

df$StateIncDiv <- df$StateIncome/df$DivisionIncome
df$StateIncReg <- df$StateIncome/df$RegionIncome

#for percentage rank
perc.rank <- function(x) rank(x)/length(x)
df<- within(df, RankStateIncGDP <- perc.rank(StateIncGDP))

df$id <- rownames(df)

plotFunction <- function(plotType,xVar,yVar,subsetGeog,scale,perc,dataType,dType) {
	indices <- which(df$RankStateIncGDP >= perc[1]
					& df$RankStateIncGDP <= perc[2])
	dfsub <- df[indices,]

	if(plotType=="Bubble") {
		p <- ggplot(dfsub, aes_string(
			x = xVar,
			y = yVar,
			color = subsetGeog,
			size = scale
			))
		p <- p + geom_point(alpha=0.7, position = "jitter")
		p <- p + scale_size_area(max_size = 10, guide = "none")
		p <- p + ggtitle("State.x77 Bubble Plot")
		p <- p + theme(legend.title = element_blank())
		p <- p + theme(legend.justification = c(0,0))
		p <- p + theme(legend.background = element_blank())
		p <- p + theme(legend.key = element_blank())
		p <- p + theme(legend.text = element_text(size=14))
		p <- p + theme(legend.margin = unit(0, "pt"))
		p <- p + guides(colour = guide_legend(override.aes = list(size = 8)))
		
		return(print(p))
	}

	if(plotType=="Small Multiples") {
		if(subsetGeog=="Region" & dataType=="statestats") {
			dfsubsm <- dfsub[,c(3,5,6,7,11,24)]
			dfsubsm <- melt(dfsubsm, id.vars=c("id", "Region"))
			smr <- ggplot(dfsubsm, aes(
				x = value,
				group = variable,
				fill = Region)) +
				geom_density(aes(colour = Region)) +
				facet_grid(Region ~ variable,
				scales = "free_x")
			smr <- smr + theme(legend.position = "none")
			smr <- smr + theme(axis.title = element_blank())
			smr <- smr + theme(panel.grid.minor.x = element_blank())
			smr <- smr + theme(panel.grid.major.x = element_blank())
			smr <- smr + labs(title = "State.x77 Small Multiples")
			return(print(smr))
		}
		if(subsetGeog=="Region" & dataType=="incomeVars") {
			dfsubsm <- dfsub[,c(11,15,16,18,22,24)]
			dfsubsm <- melt(dfsubsm, id.vars=c("id", "Region"))
			smr <- ggplot(dfsubsm, aes(
				x = value,
				group = variable,
				fill = Region)) +
				geom_density(aes(colour = Region)) +
				facet_grid(Region ~ variable,
				scales = "free_x")
			smr <- smr + theme(legend.position = "none")
			smr <- smr + theme(axis.title = element_blank())
			smr <- smr + theme(panel.grid.minor.x = element_blank())
			smr <- smr + theme(panel.grid.major.x = element_blank())
			smr <- smr + labs(title = "State.x77 Small Multiples")
			return(print(smr))
		}
		if(subsetGeog=="Division" & dataType=="statestats") {
			dfsubsm <- dfsub[,c(3,5,6,7,12,24)]
			dfsubsm <- melt(dfsubsm, id.vars=c("id", "Division"))
			smd <- ggplot(dfsubsm, aes(
				x = value,
				group = variable,
				fill = Division)) +
				geom_density(aes(colour = Division)) +
				facet_grid(Division ~ variable,
				scales = "free_x")
			smd <- smd + theme(legend.position = "none")
			smd <- smd + theme(axis.title = element_blank())
			smd <- smd + theme(panel.grid.minor.x = element_blank())
			smd <- smd + theme(panel.grid.major.x = element_blank())
			smd <- smd + labs(title = "State.x77 Small Multiples")
			return(print(smd))
		}
		if(subsetGeog=="Division" & dataType=="incomeVars") {
			dfsubsm <- dfsub[,c(12,15,16,18,22,24)]
			dfsubsm <- melt(dfsubsm, id.vars=c("id", "Division"))
			smd <- ggplot(dfsubsm, aes(
				x = value,
				group = variable,
				fill = Division)) +
				geom_density(aes(colour = Division)) +
				facet_grid(Division ~ variable,
				scales = "free_x")
			smd <- smd + theme(legend.position = "none")
			smd <- smd + theme(axis.title = element_blank())
			smd <- smd + theme(panel.grid.minor.x = element_blank())
			smd <- smd + theme(panel.grid.major.x = element_blank())
			smd <- smd + labs(title = "State.x77 Small Multiples")
			return(print(smd))
		}
	}

	if(plotType=="Parallel") {
		if(subsetGeog=="Region" & dType=="sstats") {
			pplotr <- ggparcoord(data = dfsub,
				columns = c("Illiteracy", "Murder", "HS.Grad", "Frost"),
				groupColumn = "Region", # or column number
				order = "anyClass",
				showPoints = FALSE,
				alphaLines = 0.6,
				shadeBox = NULL,
				scale = "uniminmax")
			pplotr <- pplotr + theme_minimal()
			pplotr <- pplotr + theme(axis.ticks = element_blank())
			pplotr <- pplotr + theme(axis.title = element_blank())
			pplotr <- pplotr + theme(axis.text.y = element_blank())
			pplotr <- pplotr + theme(panel.grid.minor = element_blank())
			pplotr <- pplotr + theme(panel.grid.major.y = element_blank())
			pplotr <- pplotr + theme(panel.grid.major.x = element_line(color = 				"#bbbbbb"))
			pplotr <- pplotr + theme(legend.text = element_text(size=14))
			pplotr <- pplotr + theme(legend.margin = unit(0, "pt"))
			pplotr <- pplotr + guides(colour = guide_legend(override.aes = 				list(size = 8)))
			
			return(print(pplotr))
		}
		if(subsetGeog=="Region" & dType=="incVars") {
			pplotr <- ggparcoord(data = dfsub,
				columns = c("Pop.Density", "StatePercNatPop", "StateIncGDP", 				"StateIncReg"),
				groupColumn = "Region", # or column number
				order = "anyClass",
				showPoints = FALSE,
				alphaLines = 0.6,
				shadeBox = NULL,
				scale = "uniminmax")
			pplotr <- pplotr + theme_minimal()
			pplotr <- pplotr + theme(axis.ticks = element_blank())
			pplotr <- pplotr + theme(axis.title = element_blank())
			pplotr <- pplotr + theme(axis.text.y = element_blank())
			pplotr <- pplotr + theme(panel.grid.minor = element_blank())
			pplotr <- pplotr + theme(panel.grid.major.y = element_blank())
			pplotr <- pplotr + theme(panel.grid.major.x = element_line(color = 				"#bbbbbb"))
			pplotr <- pplotr + theme(legend.text = element_text(size=14))
			pplotr <- pplotr + theme(legend.margin = unit(0, "pt"))
			pplotr <- pplotr + guides(colour = guide_legend(override.aes = 				list(size = 8)))

			return(print(pplotr))
		}
		if(subsetGeog=="Division" & dType=="sstats") {
			pplotr <- ggparcoord(data = dfsub,
				columns = c("Illiteracy", "Murder", "HS.Grad", "Frost"),
				groupColumn = "Division", # or column number
				order = "anyClass",
				showPoints = FALSE,
				alphaLines = 0.6,
				shadeBox = NULL,
				scale = "uniminmax")
			pplotr <- pplotr + theme_minimal()
			pplotr <- pplotr + theme(axis.ticks = element_blank())
			pplotr <- pplotr + theme(axis.title = element_blank())
			pplotr <- pplotr + theme(axis.text.y = element_blank())
			pplotr <- pplotr + theme(panel.grid.minor = element_blank())
			pplotr <- pplotr + theme(panel.grid.major.y = element_blank())
			pplotr <- pplotr + theme(panel.grid.major.x = element_line(color = 				"#bbbbbb"))
			pplotr <- pplotr + theme(legend.text = element_text(size=14))
			pplotr <- pplotr + theme(legend.margin = unit(0, "pt"))
			pplotr <- pplotr + guides(colour = guide_legend(override.aes = 				list(size = 8)))

			return(print(pplotr))
		}
		if(subsetGeog=="Division" & dType=="incVars") {
			pplotr <- ggparcoord(data = dfsub,
				columns = c("Pop.Density", "StatePercNatPop", "StateIncGDP", 				"StateIncReg"),
				groupColumn = "Division", # or column number
				order = "anyClass",
				showPoints = FALSE,
				alphaLines = 0.6,
				shadeBox = NULL,
				scale = "uniminmax")
			pplotr <- pplotr + theme_minimal()
			pplotr <- pplotr + theme(axis.ticks = element_blank())
			pplotr <- pplotr + theme(axis.title = element_blank())
			pplotr <- pplotr + theme(axis.text.y = element_blank())
			pplotr <- pplotr + theme(panel.grid.minor = element_blank())
			pplotr <- pplotr + theme(panel.grid.major.y = element_blank())
			pplotr <- pplotr + theme(panel.grid.major.x = element_line(color = 				"#bbbbbb"))
			pplotr <- pplotr + theme(legend.text = element_text(size=14))
			pplotr <- pplotr + theme(legend.margin = unit(0, "pt"))
			pplotr <- pplotr + guides(colour = guide_legend(override.aes = 				list(size = 8)))

			return(print(pplotr))
		}
	}
}

shinyServer(function(input, output) {
	
	cat("Press \"ESC\" to exit...\n")

	output$ui <- renderUI({
		if (is.null(input$input_type))
			return()
		
		switch(input$input_type,
			"Bubble" = fluidRow(
				column(4,
					radioButtons("xVar", "X Variable",
						choices = c("Population" = "Population",
								"Income" = "Income",
								"Murder Rate" = "Murder",
								"Illiteracy Rate" = "Illiteracy",
								"HS Grad Rate" = "HS.Grad"),
						selected = "Income"
					)
				),
				column(4,
					radioButtons("yVar", "Y Variable",
						choices = c("Population" = "Population",
									"Income" = "Income",
									"Murder Rate" = "Murder",
									"Illiteracy Rate" = "Illiteracy",
									"HS Grad Rate" = "HS.Grad"),
						selected = "Illiteracy"
					)
				),
				column(4,
					radioButtons("scale", "Scale",
						choices = c("Pop. Density" = "Pop.Density",
									"State Perc Nat Pop " = "StatePercNatPop",
									"State Inc. of GDP" = "StateIncGDP"),
						selected = "Pop.Density"
					)
				)
			),
			"Small Multiples" = fluidRow(
				column(6,
					radioButtons("dataType", "Type of Data",
						choices = c("State Stats" = "statestats",
									"Income Variables" = "incomeVars"),
						selected = "statestats"
						))
			),
			"Parallel" = fluidRow(
				column(6,
					radioButtons("dType", "Type of Data",
						choices = c("State Stats" = "sstats",
									"Income Variables" = "incVars"),
						selected = "sstats"
						))
			)
			)
	})

	getperc <- reactive({
		return(input$perc)
	})

	output$plotResults <- renderPlot ({
		plotResults <- plotFunction(input$input_type, input$xVar, input$yVar, 
		input$subsetGeog, input$scale, getperc(),input$dataType,input$dType)
		print(plotResults)
	}, width = 700, height = 600)
})