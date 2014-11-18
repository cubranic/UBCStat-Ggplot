# 7.3 Coordinate systems

library(ggplot2)
gDat <- read.delim("http://www.stat.ubc.ca/~rickw/gapminderDataFiveYear.txt")
qplot(gdpPercap, lifeExp, data = gDat) + geom_smooth() 

# coord_cartesian()

# When setting coordinate system limits we still use all the data, 
# but we only display a small region of the plot.

qplot(gdpPercap, lifeExp, data = gDat) +
  geom_smooth() + coord_cartesian(xlim = c(0, 60000))

# scale_x_continuous()

# When setting scale limits, 
# any data outside the limits is thrown away.

qplot(gdpPercap, lifeExp, data = gDat) +
  geom_smooth() + scale_x_continuous(limits = c(0, 60000))

# coord_flip()

qplot(gdpPercap, lifeExp, data = gDat) + geom_smooth() + coord_flip()

# Exchange the variables mapped to x and y

qplot(y=gdpPercap, x=lifeExp, data = gDat) + geom_smooth()

# coord_trans()
  
qplot(gdpPercap, lifeExp, data = gDat) +
  geom_smooth() + 
  coord_trans(x = "log10")

# Question: How about scale_x_log10()?

# scale_x_log10()
  
qplot(gdpPercap, lifeExp, data = gDat) +
  geom_smooth() + 
  scale_x_log10()

# coord_fixed() or coord_equal()

qplot(gdpPercap, lifeExp, data = gDat) + coord_fixed(ratio = 1000)
qplot(gdpPercap, lifeExp, data = gDat) + coord_fixed(ratio = 500)

# ratio = 1 by default 

qplot(gdpPercap, lifeExp, data = gDat) + coord_fixed()

# coord_polar()
  
qplot(x=continent, data = gDat, fill=continent) + geom_bar()
qplot(x=continent, data = gDat, fill=continent) + 
  geom_bar() + coord_polar()

qplot(x=continent, data = gDat, fill=continent) + 
  geom_bar(width=1) + coord_polar()

qplot(x=continent, data = gDat, fill=continent) + 
  geom_bar(width=1) + coord_polar(theta="y")


# Question: draw a pie chart of 
# populations in different continents in 2002
# 
# 
# 
# 
# 
# 
# 
# 

subset2002 <- 
  aggregate(pop ~ ., data=subset(gDat, year==2002, select=c(pop, continent)), sum)

ggplot(aes(y=pop, x="", fill=continent), data=subset2002) + 
  geom_bar(stat = "identity", width=1) + 
  coord_polar(theta="y")




