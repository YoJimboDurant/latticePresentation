library(lattice)
library(latticeExtra)

p<-read.csv("./sampleData.csv")

#Age categories for x-axis.
name1<-c("","0-4","5-9","10-14","15-19",
         "20-24","25-29","30-34","35-39","40-44","45-49","50-54","55-59",
         "60-64","65-69","70-74","75-79","80-84","85+")

p$`Age Catagory` <- factor(name1, levels=name1)

bwtheme <- standard.theme("pdf", color=FALSE)


dCountPlot <- 
  barchart(deaths~`Age Catagory`, data=p, ylab="Deaths(n)\n", 
           par.settings = bwtheme, axis = axis.grid, 
           key=list(
             x=.05,y=.9,
             text=list(lab=c("Deaths","Death rate")),
             lines=list(
               pch=c(20,NA),
               col=c("dark grey", "black"),
               type=c("l","o"),
               lty=1:2,
               cex=1,
               lwd=c(10,1)),
             transparent=T,border=F,rep=F
           ),
           ylim=c(0,13000)
  )


dRatePlot <- xyplot(rate ~ `Age Catagory`, data=p, type="o", pch=16, lend=2, cex=1, ylab="Deaths per 100,000",
                    par.settings = bwtheme, axis = axis.grid, ylim=c(0,13))

doubleYScale(dCountPlot, dRatePlot, add.ylab2 = TRUE)
