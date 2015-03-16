library(lattice)
library(latticeExtra)

p<-read.csv("./sampleData.csv")

#Age categories for x-axis.
name1<-c("","0-4","5-9","10-14","15-19",
         "20-24","25-29","30-34","35-39","40-44","45-49","50-54","55-59",
         "60-64","65-69","70-74","75-79","80-84","85+")

p$`Age Catagory` <- factor(name1, levels=name1)

#create a theme from pdf device
bwtheme <- standard.theme("pdf", color=FALSE)

#create a Count barplot
dCountPlot <-   barchart(deaths~`Age Catagory`, data=p, ylab="Deaths(n)\n", 
           par.settings = bwtheme, axis = axis.grid, 
           key=list(
             x=.05,y=.9,
             text=list(lab="Deaths"),
             rectangles = list(
               col="dark grey"
               ),
             text=list(lab="Death Rate"),
             lines=list(
               pch=19,
               col="black",
               type="o",
               lty=2,
               cex=0.5,
               lwd=1),
             transparent=T,border=F,rep=F, columns=1
           ),
           ylim=c(0,13000)    # note that we get a relationship between y1 and y2 1000:1
  )


dRatePlot <- xyplot(rate ~ `Age Catagory`, data=p, 
                    type="o", 
                    pch=16, 
                    lend=2, 
                    cex=1, 
                    ylab="Deaths per 100,000",
                    par.settings = bwtheme, axis = axis.grid, ylim=c(0,13),
                    xlab="Age")

dblPlot <- doubleYScale(dCountPlot, dRatePlot, add.ylab2 = TRUE)
plot(dblPlot)
