library(ggplot2)
library(shiny)
require(reshape2)

data(Seatbelts)

times <- time(Seatbelts)
years <- floor(times)
years <- factor(years, ordered=TRUE)

months <- factor(month.abb[cycle(times)],
	levels = month.abb,
	ordered = TRUE)

seatbelts <- data.frame(
	year = years,
	month = months,
	time = as.numeric(times),
	dkilled = as.numeric(Seatbelts[,1]),
	ndrivers = as.numeric(Seatbelts[,2]),
	front = as.numeric(Seatbelts[,3]),
	rear = as.numeric(Seatbelts[,4]),
	kms = as.numeric(Seatbelts[,5]),
	petrolprice = as.numeric(Seatbelts[,6]),
	vkilled = as.numeric(Seatbelts[,7]),
	law = as.numeric(Seatbelts[,8]))

seatbelts$total <- (seatbelts$dkilled + seatbelts$front + seatbelts$rear)
molten <- melt(seatbelts, id = c("year", "month", "time"))

seatbeltsarea <- data.frame(seatbelts$year, seatbelts$month, seatbelts$time, seatbelts$dkilled, seatbelts$front, seatbelts$rear, seatbelts$total)
colnames(seatbeltsarea) <- c("year", "month", "time", "Drivers", "Front", "Rear", "total")
moltenarea <- melt(seatbeltsarea, id = c("year", "month", "time"))
