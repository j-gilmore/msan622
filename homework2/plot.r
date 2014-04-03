## Jeremy Gilmore
## MSAN 622

## Homework 2

library(ggplot2)
library(scales)
data(movies)

#setwd("[Set Your Working Directory]")

## modify data: movies
movies=movies[which(!movies$budget<=0 & !movies$mpaa==""),]
genre <- rep(NA, nrow(movies))
count <- rowSums(movies[, 18:24])
genre[which(count > 1)] = "Mixed"
genre[which(count < 1)] = "None"
genre[which(count == 1 & movies$Action == 1)] = "Action"
genre[which(count == 1 & movies$Animation == 1)] = "Animation"
genre[which(count == 1 & movies$Comedy == 1)] = "Comedy"
genre[which(count == 1 & movies$Drama == 1)] = "Drama"
genre[which(count == 1 & movies$Documentary == 1)] = "Documentary"
genre[which(count == 1 & movies$Romance == 1)] = "Romance"
genre[which(count == 1 & movies$Short == 1)] = "Short"
movies$Genre<-genre

million_formatter <- function(x) {
	#label <- round(x / 1000000)
	return(sprintf("$%sM", round(x / 1000000)))
}

plotchar <- function(alphaVal,genreVal,mpaaVal,pointVal,colorScheme,jitterVal) {
	subMovies <- subset(movies, (movies$Genre %in% genreVal) & (movies$mpaa %in% mpaaVal), c(budget, mpaa, rating))
	
	MPAA <- factor(subMovies$mpaa, levels=c("PG", "PG-13", "R", "NC-17"))

	assign("subMovies", subMovies, envir=globalenv())
	assign("MPAA", MPAA, envir=globalenv())
	
	p <- ggplot(subMovies,
		aes(x= subMovies$budget, y= subMovies$rating,
		colour=MPAA)) +
		geom_point(alpha=alphaVal, shape=20, size=pointVal, position = jitterVal) +
		scale_y_continuous(breaks=seq(0,10,1), labels=seq(0,10,1)) +
		scale_x_continuous(label = million_formatter) +
		theme(legend.position="bottom") +
		ggtitle("IMDB Ratings and Budget") +
		theme(plot.title = element_text(face="bold")) +
		xlab("Budget in Millions of USD") +
		ylab("IMDB Ratings")

	if (colorScheme == "Default") {
		p <- p
	}
	else {
		p <- p + scale_color_brewer(palette = colorScheme)
	}
	return(print(p))
}

plotchar(1,c("Action", "Animation", "Comedy", "Drama", "Documentary", "Romance", "Short"), c("PG", "PG-13", "R", "NC-17"),5,"Default","identity")
