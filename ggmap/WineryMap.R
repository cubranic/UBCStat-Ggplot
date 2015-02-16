# R Code based on: http://blog.revolutionanalytics.com/2012/07/making-beautiful-maps-in-r-with-ggmap.html 

library(ggmap)
library(mapproj)

################
# Reading data #
################

wine <- read.table("wineData.txt", header = TRUE)

# Define location
napa <- geocode("Napa Valley")
location <- c(lon = as.numeric(napa[1]),lat = as.numeric(napa[2]))

# Define map source, type, and color
map <- get_map(location = location, source = "stamen", maptype = "toner", zoom = 10)

ggmap(map) 


# Plotting maps and data
ggmap(map) + geom_point(data=wine, aes(x=lon, y=lat, colour=app)) +
  scale_colour_manual(values=c("dark blue","red")) +
  labs(colour="Appointment Required") + ylab("Latitude") + xlab("Longitude")
