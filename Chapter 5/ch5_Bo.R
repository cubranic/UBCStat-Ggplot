library(ggplot2)

# 5.7 Maps
qplot() + borders("state")
qplot() + borders("state", "california")
qplot() + borders("italy")

library(maps)
data(us.cities)
big_cities <- subset(us.cities, pop > 500000)
head(big_cities)
p <- qplot(long, lat, data = big_cities)
p
p + borders("state", size = 0.5)

ia <- map_data("county", "iowa")
head(ia, 10)
ggplot(ia, aes(long, lat)) + 
  geom_polygon(aes(group = group, colour = subregion), fill = NA)


# 5.9 Statistical summaries
m1 <- ggplot(movies, aes(y=rating, x=year))
m1 + stat_summary(fun.y = "median", colour = "red", geom = "line")

library(Hmisc)
m1 + stat_summary(fun.data = "mean_cl_boot", colour = "red", geom = "smooth")


midm <- function(x) mean(x, trim = 0.5)

m <- ggplot(movies, aes(y=log10(votes), x=round(rating)))
m + stat_summary(aes(colour = "trimmed"), fun.y = midm, geom = "point") +
  stat_summary(aes(colour = "raw"), fun.y = mean, geom = "point")

iqr <- function(x, ...) {
  qs <- quantile(as.numeric(x), c(0.25, 0.75), na.rm = T)
  names(qs) <- c("ymin", "ymax")
  qs
}

m1 + stat_summary(fun.data = "iqr", geom="ribbon")

# 5.10 Annotation
unemp <- qplot(date, unemploy, data=economics, geom="line")
xrng <- range(economics$date)
yrng <- range(economics$unemploy)

unemp + geom_vline(aes(xintercept = as.numeric(start)), 
                   data = presidential[-(1:3), ])

unemp + geom_text(aes(x = start, y = yrng[1], label = name), 
                  data = presidential[-(1:3), ], size = 5)

unemp + geom_text(aes(x, y, label = "Unemployment rates\n1967-2007"),
                  data = data.frame(x = xrng[2], y = yrng[2]),
                  hjust = 1, vjust = 1, size = 8)

unemp + geom_rect(aes(NULL, NULL, xmin = start, xmax = end, fill = party), 
                  ymin = yrng[1], ymax = yrng[2],
                  data = presidential[-(1:3), ], alpha = 0.3)



