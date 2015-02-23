require(latticeExtra)
require(openair)
library(circular)

Sys.setenv(TZ='GMT')

testData <- selectByDate(mydata, start="1/7/1999", end="2/7/1999")

plt <- xyplot(pm10~date, data=testData, type="g", xlab="Date", ylab=quickText("pm10 (ug.m-3)"))

deltaX <- as.numeric(plt$x.limits[[2]]) - as.numeric(plt$x.limits[[1]])
deltaY <- as.numeric(plt$y.limits[[2]]) - as.numeric(plt$y.limits[[1]])

pltRatio <- plt$aspect.ratio
ratio <- deltaY/deltaX
factor = 3600
length = 0.05

#scale wind speed
scaleWS <- testData$ws/max(testData$ws, na.rm=TRUE)

testData$u <- sin(rad(testData$wd))  * factor * scaleWS
testData$v <- cos(rad(testData$wd)) *  factor * ratio/pltRatio * scaleWS

plt2 <- xyplot(pm10~date, data=testData, x0=testData$date + testData$u ,y0=testData$pm10 + testData$v, x1 = testData$date - testData$u,
               y1= testData$pm10 - testData$v, length=length, labels=testData$wd,
               panel=function(...) {
                 panel.arrows(...)
                 panel.grid(...)
                 #panel.text(...)
                 },
               xlab="Date", ylab=quickText("PM10 (ug.m-3)"),
               main=quickText("Winds by Date and PM10")
               )
plt2



