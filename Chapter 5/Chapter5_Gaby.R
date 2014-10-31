
# Chapter 5: Toolbox

library(ggplot2)

### Load the Gapminder data

gDat <- read.delim("gapminderDataFiveYear.txt")
str(gDat)
## 'data.frame':  1704 obs. of  6 variables:
##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
##  $ pop      : num  8425333 9240934 10267083 11537966 13079460 ...
##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
##  $ gdpPercap: num  779 821 853 836 740 ...
```

### Barplot
#Use a barplot to illustrate the GDP per capita per year for Afghanistan

afgDat<-subset(gDat,subset=country=="Afghanistan")

#A point 
qplot(year,gdpPercap,data=afgDat)

#A bar
qplot(year,gdpPercap,data=afgDat,geom="bar")
qplot(year,gdpPercap,data=afgDat,geom="bar",stat="identity")

barplotGDP<-ggplot(afgDat,aes(year,gdpPercap))
barplotGDP+geom_bar(stat="identity")

#Facet for countries starting with "A"
aCountry<-as.vector(unlist(unique(gDat$country[regexpr("A",gDat$country)==1])))
agDat<-subset(gDat,subset=country%in%aCountry)

barplotGDP<-ggplot(agDat,aes(year,gdpPercap))
barplotGDP+geom_bar(stat="identity")+facet_grid(country ~ .)

#
barplotGDP<-ggplot(agDat,aes(year,gdpPercap))
barplotGDP+geom_bar(fill="red",stat="identity")+facet_grid(country ~ .)
barplotGDP+geom_bar(fill="white",stat="identity")+facet_grid(country ~ .)
barplotGDP+geom_bar(fill="white",colour="black",stat="identity")+facet_grid(country ~ .)

#year as factor
barplotGDP+geom_bar(aes(fill=factor(year)),stat="identity")+facet_grid(country ~ .)

#year as continuous
barplotGDP+geom_bar(aes(fill=year),stat="identity")+facet_grid(country ~ .)

#Red-blue, blue for one year
p<-barplotGDP+geom_bar(aes(fill=year==1982),stat="identity")+
  facet_grid(country ~ .)+scale_fill_manual(values=c("red","blue"))

#Add the mean of GDP per capita
mean(gDat$gdpPercap)

#this adds the same line to all (overall mean)
p+geom_hline(aes(yintercept=mean(gdpPercap),facet=country))

p<-barplotGDP+geom_bar(aes(fill=year==1982),stat="identity")+
  geom_hline(aes(yintercept=mean(gdpPercap),facet=country))+
  facet_grid(country ~ .)+scale_fill_manual(values=c("red","blue"))

#we need to create a data.frame to add the corresponding mean of each country
library(plyr)
meanA<-ddply(agDat,~country,summarize,mean=mean(gdpPercap))
meanA

p<-barplotGDP+geom_bar(aes(fill=year==1982),stat="identity")+
  facet_grid(country ~ .,scales="free")+scale_fill_manual(values=c("red","blue"))+
  geom_hline(data=meanA,aes(yintercept=mean))

#+geom_text(data=meanA,aes(label=mean))

p
#color year "1982" in red
agDat<-subset(gDat,subset=country%in%aCountry)


#to do

#----------------



