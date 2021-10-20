#Class 05: Data Visualization

#Today we are going to use ggplot2 package

#First we need to load the package!
#install.packages("ggplot2") - this is a one-time only installation!
library(ggplot2)

#We will use this in-built "cars" dataset first
head(cars)

#All ggplots have at least 3 layers;
#data + aes + geoms
ggplot(data=cars) + 
  aes(x=speed, y=dist) +
  geom_point() +
  geom_smooth(method="lm") +
  labs(title="Stopping Distance of Old Cars",
       x="Speed (MPH)", 
       y="Stopping Distance (ft)")

#Grey area around line = SEM
#Side note: ggplot is not the only graphics system
#A very popular one is good old "base" R graphics
plot(cars)
plot(cars$speed, cars$speed)

#Follow this same process as directed in the worksheet for lab 5. Now, we will be looking at gene expression changes upon drug treatment
url <- "https://bioboot.github.io/bimm143_S20/class-material/up_down_expression.txt"
genes <- read.delim(url)
head(genes)

p <- ggplot(data=genes) +
  aes(x=Condition1, y=Condition2, col=State) +
  geom_point() + 
  scale_color_manual(values=c("blue", "gray", "red")) +
  labs(title="Gene Expression Changes Upon Drug Treatment",
       x="Control (No Drug)",
       y="Drug Treatment")
#Question: How many genes are in this dataset?
nrow(genes)
#Question: How many genes are "up"?
table(genes$State)
#Question: What % are up?
table(genes$State)/nrow(genes)
#Question: How do we report this as a percentage?
table(genes$State)/nrow(genes) * 100
#Question: How do we round off to a specific number of sig figs?
round(table(genes$State)/nrow(genes) * 100, 3)
#See lines 29-35 to make a figure

#General notes on making the figure:
p <- ggplot(genes) +
  aes(x=Condition1, y=Condition2, col=State) +
  geom_point()

p

# I like it but not the default colors, let's change them
p + scale_color_manual(values=c("blue", "gray", "red"))

#Section of lab: Going Further
library(gapminder)
library(dplyr)
gapminder_2007 <- gapminder %>% filter(year==2007)

#Let's make another figure - first, a scatterplot!
ggplot(gapminder_2007) +
  aes(x=gdpPercap, y=lifeExp) +
  geom_point(alpha=0.5)
#The "alpha" value will make the points on the scatterplot more transparent
#To add even more complexity to the plot, we will add the following to our calls:
ggplot(gapminder_2007) +
  aes(x=gdpPercap, y=lifeExp, color=continent, size=pop) +
  geom_point(alpha=0.5)
#Now try this...
ggplot(gapminder_2007) +
  aes(x=gdpPercap, y=lifeExp, color=pop) +
  geom_point(alpha=0.8)
#Now try this...
ggplot(gapminder_2007) +
  aes(x=gdpPercap, y=lifeExp, size=pop) +
  geom_point(alpha=0.5)
#To add scaling information:
ggplot(gapminder_2007) +
  aes(x=gdpPercap, y=lifeExp, size=pop) +
  geom_point(alpha=0.5) +
  scale_size_area(max_size = 10)

#Now, let's try putting this all together to generate a new figure:
gapminder_1957 <- gapminder %>% filter(year==1957)
ggplot(gapminder_1957)
ggplot(gapminder_1957) +
  aes(x=gdpPercap, y=lifeExp, color=continent) +
  geom_point()

ggplot(gapminder_1957) +
  aes(x=gdpPercap, y=lifeExp, color=continent, size=pop) +
  geom_point()

ggplot(gapminder_1957) +
  aes(x=gdpPercap, y=lifeExp, color=continent) +
  geom_point(alpha=0.7) +
  scale_size_area(max_size = 15)

ggplot(gapminder_1957) +
  aes(x=gdpPercap, y=lifeExp, color=continent) +
  geom_point(alpha=0.7) +
  scale_size_area(max_size = 15) +
  facet_wrap(~year)

#Let's make a new plot of year vs. lifeExp
ggplot(gapminder) +
  aes(x=year, y=lifeExp, col=continent) +
  geom_jitter(width=0.3,alpha=0.4) +
  geom_boxplot(aes(group=year, alpha=0.2))

ggplot(gapminder) +
  aes(x=year, y=lifeExp, col=continent) +
  geom_jitter(width=0.3,alpha=0.4) +
  geom_violin(aes(group=year), alpha=0.2,
                  draw_quantiles=0.5)

#Install the plotly
#Install.packages("plotly")
library(plotly)
#ggplotly()

