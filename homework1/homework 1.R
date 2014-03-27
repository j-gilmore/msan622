## MSAN 622
## Jeremy Gilmore
## Homework 1

library(ggplot2)
data(movies)
data(EuStockMarkets)

## setwd("YOUR DIRECTORY HERE")

## modify data: movies
movies=movies[which(!movies$budget<=0),]
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
movies$genre<-genre
movies$budget<-(movies$budget/1000000)
movies$rndrating<-round(movies$rating/.1)*.1
movies$rndbudget<-round(movies$budget/.1)*.1

## modify data: EuStockMarkets
eu <- transform(data.frame(EuStockMarkets), time = time(EuStockMarkets))


## Plot 1: Scatterplot
p.scatter <- ggplot(movies, 
	aes(x= rndbudget, y= rndrating,
	colour=genre)) +
	geom_point(alpha=.5, shape=20) +
	scale_y_continuous(breaks=seq(0,10,1), labels=seq(0,10,1)) +
	ggtitle("IMDB Movies Data") +
	xlab("Budget in Millions of USD") +
	ylab("Movie Ratings") +
	labs(colour = "Genre")

print(p.scatter)
ggsave(p.scatter, file="hw1-scatter.png", width=6, height=6)


## Plot 2: Bar Chart
table.genre<-sort(table(genre))
genre.rank<-as.vector(table.genre)
genre.labels<-c("Animation", "Romance", "Documentary", "Short", "Action", "Comedy", "None", "Drama", "Mixed")
movies$genre2<- factor(movies$genre, levels=genre.labels)

p.bar <- ggplot(movies, 
	aes(x=genre2, fill=genre)) +
	geom_bar(width=.75) +
##	geom_text(aes(label=genre2, y=count)) + ## eventually add bar labels
	theme(axis.text.x=element_text(angle=45)) +
	ggtitle("IMDB Movies Data") +
	xlab("Film Genre") +
	ylab("Number of Films in Genre") +
	labs(colour = "Genre")

print(p.bar)
ggsave(p.bar, file="hw1-bar.png", width=6, height=6)


## Plot 3: Small Multiples
p.small <- ggplot(movies, 
	aes(x=budget, y=rating,
	group = genre,
	color = genre)) +
	geom_point(alpha=.6, shape=20) +
	scale_y_continuous(breaks=seq(0,10,1), labels=seq(0,10,1)) +
	ggtitle("IMDB Movies Data") +
	xlab("Film Budget in Millions of USD") +
	ylab("Ratings") +
	facet_wrap( ~genre2, ncol=3) +
	labs(colour = "Genre")

print(p.small)
ggsave(p.small, file="hw1-multiples.png", width=6, height=6)


## Plot 4: Multi-Line Chart
yeartext <- c("1991", "1992", "1993", "1994", "1995", "1996", "1997", "1998")
DAX<-eu[1]
SMI<-eu[2]
CAC<-eu[3]
FTSE<-eu[4]
##index<- data.frame(eu[,1:4]) ## I wasn't sure which data-type to use.
##eu$year<-trunc(eu$time, "day") ## The intent was to use for labels.

p.multi <- ggplot(eu, 
	aes(eu$time)) +
##	group = factor(index),
##	color = factor(index))) +
	geom_line(aes(y=DAX, colour = "DAX: Germany")) +
	geom_line(aes(y=SMI, colour = "SMI: Switzerland")) +
	geom_line(aes(y=CAC, colour = "CAC: France")) +
	geom_line(aes(y=FTSE, colour = "FSTE: UK")) +
	ggtitle("Daily EU Stock Market Performance (1991:1998)") +
	xlab("") +
	ylab("Performance") +
	scale_x_continuous(breaks=seq(1991,1998, 1), labels = yeartext) +
	scale_y_continuous(breaks=seq(2000,10000, 1000)) +
	theme(legend.position=c(.25,.75)) +
	labs(colour = "Index")

print(p.multi)
ggsave(p.multi, file="hw1-multiline.png", width=6, height=6)