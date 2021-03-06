#import the data

mov <- file.choose()
#data exploration
head(mov)
summary(mov)
str(mov)

#activate ggplot2
#install.packages("ggplot2")
library(ggplot2)

#cool insight:
ggplot(data=mov, aes(x=Day.of.Week)) + geom_bar()

#filter #1 for data frame (this filter is BOOLEAN)
filt <- (mov$Genre=="action" | mov$Genre=="adventure" | mov$Genre=="animation" | 
           mov$Genre=="comedy" | mov$Genre=="drama")

#filter #2 (this filter is BOOLEAN)
filt2 <- mov$Studio %in% c("Buena Vista Studios", "WB", "Fox",
                           "Universal", "Sony", "Paramount Pictures")
filt
filt2

#combining filters
mov2 <- mov[filt & filt2,]
mov2

#prepare the plot's data and aes layers:
p <- ggplot(data=mov2, aes(x=Genre, y=Gross...US))


#add geometries
q <- p + geom_jitter(aes(size=Budget...mill., colour=Studio)) + 
  geom_boxplot(alpha=0.7, outlier.color = NA) 

#non-data ink
q <- q +
  xlab("Genre") + 
  ylab("Gross % US") +
  ggtitle("Domestic Gross % by Genre")
q

#theme
q <- q +
  theme(
    axis.title.x=element_text(colour="Blue", size=30),
    axis.title.y=element_text(colour="Blue", size=30), 
    axis.text.x=element_text(size=20),
    axis.text.y=element_text(size=20),
    
    plot.title = element_text(size=40),
    
    legend.title = element_text(size=20),
    legend.text = element_text(size=20),
    
    text = element_text(family="Comic Sans MS")
  )
q

#Final touch:
q$labels$size <- "Budget $M"
