require(latticeExtra)
require(openair)
library(circular)
testData <- selectByDate(mydata, day = 1, month=1, year=2000)
testData$u <- sin(rad(testData$wd))  * testData$ws
testData$v <- cos(rad(testData$wd)) * testData$ws

plt <- xyplot(nox~date, data=testData, type="g", aspect="xy")
plt <- plt + layer(panel.arrows(x0=testData$date,y0=testData$nox, x1 = testData$date + testData$u,
                                y1= testData$nox + testData$v, length=0.1))
plt + layer(panel.text(x=testData$date,y=testData$nox, labels=testData$wd))


plt2 <- xyplot(nox ~ date, data=testData, type="g", labels=testData$wd)
update(plt2, panel=function(...) panel.text(...))
