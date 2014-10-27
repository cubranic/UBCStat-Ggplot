library(ggplot2)
X <- read.delim("http://www.stat.ubc.ca/~rickw/gapminderDataFiveYear.txt")

# 'data.frame':  1704 obs. of  6 variables:
#   $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
# $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
# $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
# $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
# $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
# $ gdpPercap: num  779 821 853 836 740 ...

# 5.7 Maps
qplot() + borders("state")
qplot() + borders("world", "c")
qplot() + xlim(-100, -60) + ylim(75, 83) + geom_polygon(aes(x=long, y=lat, group = group),
                    data = subset(map_data("world")), alpha=0.5)
qplot() + geom_path(aes(x=long, y=lat, group = group),
                       data = subset(map_data("world"), region=="Canada"))
qplot() + xlim(-100, -60) + ylim(75, 83) + geom_path(aes(x=long, y=lat, group = group),
                    data = subset(map_data("world"), region=="Canada"))



library(maps)
data(us.cities)
str(us.cities)
big_cities <- subset(us.cities, pop > 500000)
head(big_cities)
p <- qplot(long, lat, data = big_cities)
p
p + borders("state", size = 0.5)

ca <- map_data("county", "california")
head(ca, 50)
ggplot(ca, aes(long, lat)) + 
  geom_polygon(aes(fill = subregion))


# 5.8 & 5.9 Statistical summaries
m1 <- ggplot(X, aes(y=lifeExp, x=factor(year))) + geom_point() 
m1

m1 + stat_summary(fun.y = mean, fun.ymin = min, fun.ymax = max,
                  colour = "red", size=1)

m1 + stat_summary(fun.y = mean, colour = "red", geom = "line")

m2 <- m1 + stat_summary(fun.y = mean, aes(colour = "mean"), geom = "line") + 
  stat_summary(fun.y = median, aes(colour = "median"), geom = "line")
m2

midm <- function(x) mean(x, trim = 0.25)
m2 + stat_summary(fun.y = midm, aes(colour = "midm"), geom = "line")

library(Hmisc)
m1 + stat_summary(fun.data = "mean_cl_boot", colour = "red", geom = "smooth")
m1 + stat_summary(fun.data = "mean_cl_boot", colour = "red", geom = "errorbar")
# m1 + stat_summary(fun.data = "mean_cl_boot", colour = "red", aes(group = year),
#                  geom = "crossbar")
m1 + stat_summary(fun.data = "mean_cl_boot", colour = "red", geom = "pointrange")
m1 + stat_summary(fun.data = "mean_cl_boot", colour = "red", geom = "crossbar")



iqr <- function(x, ...) {
  qs <- quantile(as.numeric(x), c(0.25, 0.75), na.rm = T)
  names(qs) <- c("ymin", "ymax")
  qs
}

m1 + stat_summary(fun.data = "iqr", geom="ribbon", 
                  fill = "red", alpha = 0.4)
m1 + stat_summary(fun.data = "iqr", geom="errorbar", color = "red")
m1 + stat_summary(fun.data = "iqr", geom="linerange", color = "red")


# 5.10 Annotation
unemp <- qplot(date, unemploy, data=economics, geom="line")
unemp
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



# 5.11 Weighted data
qplot(lifeExp, gdpPercap, data = X) +
  geom_smooth()

qplot(lifeExp, gdpPercap, data = X, size = pop, weight = pop) +
  geom_smooth()

qplot(lifeExp, gdpPercap, data = X, size = pop) +
  geom_smooth(aes(weight = pop))

qplot(lifeExp, data = X) 
qplot(lifeExp, data = X, weight = pop) 


# =====
d <- qplot(factor(cyl), mpg, data=mtcars)
d
stat_sum_df <- function(fun, geom="crossbar", ...) {
  stat_summary(fun.data=fun, colour="red", geom=geom, width=0.2, ...)
}
d + stat_sum_df("mean_cl_boot")

