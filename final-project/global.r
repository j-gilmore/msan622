library(data.table)
library(ggplot2)
library(ggmap)
library(reshape2)
library(stringr)
library(shiny)
library(treemap)

oohoesnat <- read.csv("./oohoesnat.csv", stringsAsFactors=FALSE)
oohoesstate <- read.csv("./oohoesstate.csv", stringsAsFactors=FALSE)
oohoesmetrogeo <- read.csv("./oohoesmetrogeo.csv", stringsAsFactors=FALSE)
stateneighbors <- read.csv("./neighbors.csv")
statelatloncenter <- read.csv("./state_latlon.csv")
oesnatgroup <- read.csv("./oesnatgroup.csv", stringsAsFactors=FALSE)
oesstategroup <- read.csv("./oesstategroup.csv", stringsAsFactors=FALSE)

dataplot_function <- function(df, datatype, indclassvar, addstates, addprof) {	
	if(datatype=="Industry") {
		if(addstates=="Yes") {
			p <- treegraph(df, index=c("indclass", "OCC_CODE", "PRIM_STATE"),
			show.labels=FALSE)
		return(print(p))	
		}
		else {
			p <- treegraph(df, index=c("indclass", "OCC_CODE"),
				show.labels=FALSE)
		return(print(p))	
		}
	}
	if(datatype=="States") {
		if(addprof=="Yes") {
			p <- treegraph(df, index=c("PRIM_STATE", "indclass", "OCC_CODE"),
				show.labels=FALSE)
			return(print(p))	
		}
		else {
			p <- treegraph(df, index=c("PRIM_STATE", "indclass"),
				show.labels=FALSE)
			return(print(p))	
		}
	}
}

natplot_function <- function(df, indclassvar, dorp) {
	map<- get_googlemap(center = c(lon = -96.5795, lat = 30.8282),
		color = "bw", # bw, color
		source = "google", # google, stamen
		# maptype = "hybrid", # satellite, terrain, roadmap, hybrid,
		# watercolor, toner
		zoom = 4)
	
	if(indclassvar=="All Industries") {
		subsetdf <- df
		titlelab <- "All Industries"
	}
	else {
		subsetdf <- df[which(df$indclass==indclassvar),]
		titlelab <- subsetdf$indclass
	}

	assign("subsetdf", subsetdf, envir=globalenv())

	if(dorp=="density") {
		subtitlelab <- "Employment Density Map"
	p <- ggmap(map, extent = "panel", maprange=FALSE, xlim=c(-134,-54)) +
		geom_density2d(data=subsetdf, aes(x=longitude, y=latitude)) +
		stat_density2d(data=subsetdf, aes(x=longitude, y=latitude,
		fill = 0.01, alpha = .01),
		size = .01, bins = 16, geom = 'polygon') +
		scale_fill_gradient(low = "green", high = "red") +
		scale_alpha(range=c(0.00, 0.25), guide = FALSE) +
		scale_size_area(max_size=10, guide = "none") +
		theme(plot.title = element_text(size=18, face="bold")) +
		theme(plot.title = element_text(vjust=2)) +
		theme(axis.ticks.x = element_blank()) +
		theme(axis.ticks.y = element_blank()) +
		theme(axis.text.x = element_blank()) +
		theme(axis.text.y = element_blank()) +
		theme(legend.position = "none", axis.title=element_blank(), 
			text = element_text(size=12))
		
		return(print(p))
	}
	if(dorp=="points") {
		subtitlelab <- "sized by Total Employed"

	p <- ggmap(map, extent = "panel", maprange=FALSE) +
		geom_point(data=subsetdf, aes(x=longitude, y=latitude, 
		size = subsetdf$TOT_EMP),
		colour = "red",
		alpha = .7) +
		scale_size_area(max_size=10, guide = "none") +
		theme(plot.title = element_text(size=18, face="bold")) +
		theme(plot.title = element_text(vjust=2)) +
		theme(axis.ticks.x = element_blank()) +
		theme(axis.ticks.y = element_blank()) +
		theme(axis.text.x = element_blank()) +
		theme(axis.text.y = element_blank()) +
		theme(legend.position = "none", axis.title=element_blank(), 
			text = element_text(size=12))
		
		return(print(p))
	}
}

rem_commas <- function(x) {
	x <- as.numeric(gsub(",", "", x, fixed=TRUE))
}

oesnatgroup$TOT_EMP <- rem_commas(oesnatgroup$TOT_EMP)
oesnatgroup$A_MEAN <- rem_commas(oesnatgroup$A_MEAN)
oesnatgroup$A_PCT10 <- rem_commas(oesnatgroup$A_PCT10)
oesnatgroup$A_PCT25 <- rem_commas(oesnatgroup$A_PCT25)
oesnatgroup$A_MEDIAN <- rem_commas(oesnatgroup$A_MEDIAN)
oesnatgroup$A_PCT75 <- rem_commas(oesnatgroup$A_PCT75)
oesnatgroup$A_PCT90 <- rem_commas(oesnatgroup$A_PCT90)

natwage_function <- function(df, OCC_CODEvar, wagetype) {
	subsetdf <- df[which(df$OCC_CODE==OCC_CODEvar),]
	subsetdf$H_PCT10 <- as.numeric(subsetdf$H_PCT10)	
	subsetdf$H_PCT25 <- as.numeric(subsetdf$H_PCT25)	
	subsetdf$H_MEDIAN <- as.numeric(subsetdf$H_MEDIAN)	
	subsetdf$H_PCT75 <- as.numeric(subsetdf$H_PCT75)	
	subsetdf$H_PCT90 <- as.numeric(subsetdf$H_PCT90)	
	subsetdf$A_PCT10 <- as.numeric(subsetdf$A_PCT10)	
	subsetdf$A_PCT25 <- as.numeric(subsetdf$A_PCT25)	
	subsetdf$A_MEDIAN <- as.numeric(subsetdf$A_MEDIAN)	
	subsetdf$A_PCT75 <- as.numeric(subsetdf$A_PCT75)	
	subsetdf$A_PCT90 <- as.numeric(subsetdf$A_PCT90)	

	if(wagetype=="Hourly") {
		dollar_formatter <- function(x) {
		return(sprintf("$%s", x)) }
		subsetdf <- subsetdf[c(4,11:15)]
		nmean <- 22.33
		nmeanlabel <- 23.5
		colnames(subsetdf) <- c("Industry", "10th Percentile",
		"25th Percentile", "Median", "75th Percentile", 
		"90th Percentile")
		subsetdfmelt <- melt(subsetdf, id.vars="Industry")
		titlelab <- str_c("Percentiles of ", wagetype, " Wage")
		subtitlelab <- subsetdf$Industry
	p <- ggplot(subsetdfmelt, aes(Industry, value)) +
		geom_bar(aes(fill=variable),
		position="dodge",
		stat="identity",
		width=.25) +
		theme(panel.grid.minor = element_blank(),
		axis.ticks = element_blank(),
		legend.title = element_blank(),
		legend.text = element_text(size=12)) +
		geom_hline(aes(yintercept=22.33), color="red",
		linetype="dashed") +
		annotate("text", x=.65, y=nmeanlabel, label="National Mean") +
		xlab("") +
		ylab("") + # "Hourly Wage"
		scale_x_discrete(breaks=NULL) +
		scale_y_discrete(breaks=seq(0,70,5), label=dollar_formatter) +
		scale_fill_brewer(palette="Set1") +
		ggtitle(bquote(atop(.(titlelab), 
		atop(italic(.(subtitlelab)),""))))
	return(print(p))

	}
	if(wagetype=="Annual") {
		thousand_formatter <- function(x) {
		return(sprintf("$%sK", round(x/1000))) }
		subsetdf <- subsetdf[c(4,16:20)]
		nmean <- 46440
		nmeanlabel <- 44000
		colnames(subsetdf) <- c("Industry", "10th Percentile", 
		"25th Percentile", "Median", "75th Percentile", 
		"90th Percentile")
		subsetdfmelt <- melt(subsetdf, id.vars="Industry")
		titlelab <- str_c("Percentiles of ", wagetype, " Wage")
		subtitlelab <- subsetdf$Industry
	p <- ggplot(subsetdfmelt, aes(Industry, value)) +
		geom_bar(aes(fill=variable),
		position="dodge",
		stat="identity",
		width=.25) +
		theme(panel.grid.minor = element_blank(),
		axis.ticks = element_blank(),
		legend.title = element_blank(),
		legend.text = element_text(size=12)) +
		geom_hline(aes(yintercept=46440), color="red",
		linetype="dashed") +
		annotate("text", x=.65, y=nmeanlabel, label="National Mean") +
		xlab("") +
		ylab("") +
		scale_x_discrete(breaks=NULL, expand=c(0,0)) +
		scale_y_continuous(breaks=seq(0,250000,10000),
		label=thousand_formatter) +
		scale_fill_brewer(palette="Set1") +
		ggtitle(bquote(atop(.(titlelab),
		atop(italic(.(subtitlelab)),""))))
	return(print(p))
	}
}

overviewstats_function <- function(df, dfgroup, OCC_CODEvar) {
	natgrowth <- round(mean(df$qf_employment_outlook))
	natnumjobs <- round(mean(df$qf_number_of_jobs))
	natopenings <- round(mean(df$qf_employment_openings))
	
	subsetdf <- dfgroup[which(dfgroup$OCC_CODE==OCC_CODEvar),]
	subsetdf <- subsetdf[c(4)]
	colnames(subsetdf) <- ("Industry")
	ind <- str_sub(subsetdf$Industry, end=-13)
	if(ind=="All") {
		indtabledf <- data.frame(natgrowth, natnumjobs, natopenings)
		colnames(indtabledf) <- c("National Growth Rate", "National Avg. Employed", "National Ave. Openings")
	}
	else {
	subdf <- df[which(df$indclass==ind),]
	indgrowth <- round(mean(subdf$qf_employment_outlook))
	indnumjobs <- round(mean(subdf$qf_number_of_jobs))
	indopenings <- round(mean(subdf$qf_employment_openings))

	growth <- c(indgrowth, natgrowth)
	numjobs <- c(indnumjobs, natnumjobs)
	openings <- c(indopenings, natopenings)
	indtabledf <- data.frame(growth, numjobs, openings)
	colnames(indtabledf) <- c("Growth Rate", "Avg. Employment", "Avg. Openings")
	rownames(indtabledf) <- c("Industry", "National")
	}
	indtable <- data.table(indtabledf)
	return(print(indtabledf))
}

table_overviewfunction <- function(df, tsort) {
	
	subset <- df[2:23,]
	subset <- subset[c(4,6,8,9,13,18)] # 6 is TOT_EMP
	subset$TOT_EMP <- round(as.numeric(subset$TOT_EMP), digits=0)
	subset$H_MEAN <- as.numeric(subset$H_MEAN)	
	subset$A_MEAN <- round(as.numeric(subset$A_MEAN), digits=0)	
	subset$H_MEDIAN <- as.numeric(subset$H_MEDIAN)	
	subset$A_MEDIAN <- round(as.numeric(subset$A_MEDIAN), digits=0)	
	if(tsort=="TOT_EMP") {
		subset <- subset[order(-subset$TOT_EMP),]	
	}
	if(tsort=="H_MEAN") {
		subset <- subset[order(-subset$H_MEAN),]	
	}
	if(tsort=="A_MEAN") {
		subset <- subset[order(-subset$A_MEAN),]	
	}
	if(tsort=="H_MEDIAN") {
		subset <- subset[order(-subset$H_MEDIAN),]	
	}
		if(tsort=="A_MEDIAN") {
		subset <- subset[order(-subset$A_MEDIAN),]	
	}	
	# subset <- subset[1:10,]
	colnames(subset) <- c("Industry", "Total Employed", "Hourly Mean", "Annual Mean", "Hourly Median", "Annual Median")
	describetable <- data.table(subset)
	return(describetable)
}

tree_function <- function(df, treetype, indclassvar, state, treevar, treescale, treeocc) {
	if(treevar=="TOT_EMP") {
		maptitle <- "Total Employment"
	}
	else {
		maptitle <- "Mean Annual Salary"
	}
	if(treescale=="TOT_EMP") {
		legendtitle <- "Total Employment"
	}
	else {
		legendtitle <- "Mean Annual Salary"
	}
	if(treetype=="National") {
		if(indclassvar=="All Industries") {
			subsetdf <- df
		}
		else {
			subsetdf <- df[which(df$indclass==indclassvar),]		
		}

		p <- treemap(subsetdf,
			index=c("indclass", "OCC_TITLE"),
			vSize = treevar,
			vColor = treescale,
			type = "value",
			palette = "RdBu",
			title = maptitle,
			title.legend=legendtitle)
		return(print(p))
	}
	if(treetype=="State") {
		if(indclassvar=="All Industries") {
			subsetdf <- df[which(df$ST==state),]
		}
		else {
			subsetdf <- df[which(df$indclass==indclassvar & 
				df$ST==state),]
		}
		p <- treemap(subsetdf,
			index=c("indclass", "OCC_TITLE"),
			vSize = treevar,
			vColor = treescale,
			type = "value",
			palette = "RdBu",
			title = maptitle,
			title.legend=legendtitle)

		return(print(p))		
	}
	if(treetype=="Industry") {
		if(indclassvar=="All Industries") {
			subsetdf <- df
		}
		else {
			subsetdf <- df[which(df$indclass==indclassvar),]
			if(treeocc=="99-9999") { # All Professions
				subsetdf <- subsetdf
			}
			else {
			subsetdf <- subsetdf[which(subsetdf$OCC_CODE==treeocc),]
			}
		}

		p <- treemap(subsetdf,
			index=c("ST", "OCC_TITLE"),
			vSize = treevar,
			vColor = treescale,
			type = "value",
			palette = "RdBu",
			title = maptitle,
			title.legend=legendtitle)

		return(print(p))		
	}
}

text_function <- function(df, occ) {
	subset <- df[which(df$OCC_CODE==occ),]
	subset$description <- as.character(subset$description)
	textout <- subset$description[[1]][1]
	return(print(textout))
}

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

plot_function <- function(df, indclassvar, occ, statevar, var, stateneighbors, dorpplot) {
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

	if(dorpplot=="points") {
	titlelab <- paste(subsetdf$OCC_TITLE, ": sized by Total Employed", sep="")

	p <- ggmap(map, extent = "panel", maprange=FALSE) +
		geom_point(data=subsetdf, aes(x=longitude, y=latitude, 
		size = subsetdf$TOT_EMP),
		colour = "red",
		alpha = .7) +
		geom_point(data=subsetn, aes(x=longitude, y=latitude),
		colour = "blue",
		alpha = 1, size = 4) +
		scale_size_area(max_size=10, guide = "none") +
		ggtitle(titlelab) +
		theme(plot.title = element_text(size=18, face="bold")) +
		theme(plot.title = element_text(vjust=2)) +
		theme(axis.ticks.x = element_blank()) +
		theme(axis.ticks.y = element_blank()) +
		theme(axis.text.x = element_blank()) +
		theme(axis.text.y = element_blank()) +
		theme(legend.position = "none", axis.title=element_blank(), 
			text = element_text(size=12))
		
	return(print(p))
	}
	
	if(dorpplot=="density") {
		titlelab <- paste(subsetdf$OCC_TITLE, ": Employment Density Map", sep="")

	p <- ggmap(map, extent = "panel", maprange=FALSE) +
		geom_density2d(data=subsetdf, aes(x=longitude, y=latitude)) +
		stat_density2d(data=subsetdf, aes(x=longitude, y=latitude,
		fill = 0.01, alpha = .01),
		size = .01, bins = 12, geom = 'polygon') +
		scale_fill_gradient(low = "green", high = "red") +
		scale_alpha(range=c(0.00, 0.25), guide = FALSE) +
		geom_point(data=subsetn, aes(x=longitude, y=latitude),
		colour = "blue",
		alpha = 1, size = 4) +
		scale_size_area(max_size=10, guide = "none") +
		ggtitle(titlelab) +
		theme(plot.title = element_text(size=18, face="bold")) +
		theme(plot.title = element_text(vjust=2)) +
		theme(axis.ticks.x = element_blank()) +
		theme(axis.ticks.y = element_blank()) +
		theme(axis.text.x = element_blank()) +
		theme(axis.text.y = element_blank()) +
		theme(legend.position = "none", axis.title=element_blank(), 
			text = element_text(size=12))
		
		return(print(p))

	}
}
