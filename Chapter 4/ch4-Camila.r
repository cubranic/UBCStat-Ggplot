library(ggplot2)

# Density histogram of carat from the diamonds dataset

ggplot(diamonds, aes(carat)) +
  geom_histogram(aes(y = ..density..), binwidth = 0.1, stat = "identity")

ggplot(diamonds, aes(carat)) + stat_bin(aes(y = ..density..), binwidth = 0.1)

qplot(carat, ..density.., data = diamonds, geom="histogram", binwidth = 0.1)

# Use same stats underlying a histogram but different geoms

d <- ggplot(diamonds, aes(carat)) + xlim(0, 3)

# Point geom
d + stat_bin(
aes(size = ..density..), binwidth = 0.1,
geom = "point", position="identity")

# Area geom
d + stat_bin(aes(ymax = ..count..), binwidth = 0.1, geom = "area")


# Varying aesthetics and data


# Mixed effect model
# Oxboys data: heights of boys in Oxford
# Contains: subject id, standardized age, height in cm

library(nlme)

model <- lme(height ~ age, data = Oxboys, random = ~ 1 + age | Subject)

oplot <- ggplot(Oxboys, aes(age, height, group = Subject)) + geom_line(size = 0.5)

oplot

# Predictions

age_grid <- seq(-1, 1, length = 10)
subjects <- unique(Oxboys$Subject)

preds <- expand.grid(age = age_grid, Subject = subjects)
preds$height <- predict(model, preds)

# Add predictions to the oplot

oplot + geom_line(data = preds, colour = "blue", size = 0.5)

# Residual plot with a smoothing for all observations

Oxboys$fitted <- predict(model)
Oxboys$resid <- with(Oxboys, fitted - height)

# Note the usage of %+% to update the default data
# group = 1, so smoothing based on all the data

oplot %+% Oxboys + aes(y = resid) + geom_smooth(aes(group = 1))
