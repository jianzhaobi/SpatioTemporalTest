\name{plot.predCVSTmodel}
\alias{plot.predCVSTmodel}
\alias{plot.predictSTmodel}
\title{Plots for \code{predictSTmodel} and \code{predCVSTmodel} Objects}
\usage{
  \method{plot}{predCVSTmodel} (x, y = "time",
    ID = colnames(x$pred.all$EX)[1],
    col = c("black", "red", "grey"), pch = c(NA, NA),
    cex = c(1, 1), lty = c(1, 1), lwd = c(1, 1), p = 0.95,
    pred.type = "EX", pred.var = TRUE, add = FALSE, ...)

  \method{plot}{predictSTmodel} (x, y = "time",
    STmodel = NULL, ID = x$I$ID[1],
    col = c("black", "red", "grey"), pch = c(NA, NA),
    cex = c(1, 1), lty = c(1, 1), lwd = c(1, 1), p = 0.95,
    pred.type = "EX", pred.var = FALSE, add = FALSE, ...)
}
\arguments{
  \item{x}{\code{predictSTmodel} or \code{predCVSTmodel}
  object to plot.}

  \item{y}{Plot predictions as a function of either
  \code{"time"} or \code{"obs"}ervations.}

  \item{STmodel}{\code{STdata}/\code{STmodel} object
  containing observations with which to compare the
  predictions (not used for \code{plot.predCVSTmodel}).}

  \item{ID}{The location for which we want to plot
  predictions. A string matching names in
  \code{colnames(x$EX)} (or \code{x$I$ID}, number(s) which
  are used as \code{ID = colnames(x$EX)[ID]}, or
  \code{"all"} in which case all predictions are used.  If
  several locations are given (or \code{"all"}) then
  \code{y} must be \code{"obs"}.}

  \item{col}{A vector of three colours: The first is the
  colour of the predictions, second for the observations
  and third for the polygon illustrating the confidence
  bands. \cr For \code{y="obs"} the colours are 1) colour
  of the points, 2) colour of the 1-1 line, and 3) colour
  of the polygon. If \code{ID="all"}, picking
  \code{col[1]="ID"} will colour code the
  observations-prediction points by site ID.}

  \item{pch,cex,lty,lwd}{Vectors with two elements giving
  the point type, size, line type and line width to use
  when plotting the predictions and observations
  respectively. Setting a value to \code{NA} will give no
  points/lines for the predictions/observations. \cr When
  plotting predictions as a function of observations
  \code{lty[2]} is used for the addition of
  \code{\link[graphics:abline]{abline}(0,1, lty=lty[2],
  col=col[2], lwd=lwd[2])}; \code{pch[2]} and \code{cex[2]}
  are ignored.}

  \item{p}{Width of the plotted confidence bands (as
  coverage percentage, used to find appropriate two-sided
  normal quantiles).}

  \item{pred.type}{Which type of prediction to plot, one of
  \code{"EX"}, \code{"EX.mu"}, \code{"EX.mu.beta"}, or
  \code{"EX.pred"}; see the output from
  \code{\link{predict.STmodel}}}

  \item{pred.var}{Should we plot confidence bands based on
  prediction (TRUE) or confidence intrevalls (FALSE), see
  \code{\link{predict.STmodel}}.  Only relevant if
  \code{pred.type="EX"} or \code{pred.type="EX.pred"}. \cr
  \strong{NOTE:} \emph{The default differs for
  \code{plot.predictSTmodel} and
  \code{plot.predCVSTmodel}!}}

  \item{add}{Add to existing plot?}

  \item{...}{Additional parameters passed to
  \code{\link[graphics:plot]{plot}}.}
}
\value{
  Nothing
}
\description{
  \code{\link[graphics:plot]{plot}} method for classes
  \code{predictSTmodel} and \code{predCVSTmodel}. Provides
  several different plots of the data.
}
\examples{
#######################################
## plot predictions for a given site ##
#######################################
##load data
data(mesa.model)
##load predictions
data(pred.mesa.model)

par(mfrow=c(2,1))
plot(pred.mesa.model)
##different site with data and prediction variances
plot(pred.mesa.model, STmodel=mesa.model, ID="L001",
     pred.var=TRUE)

##compare the different contributions to the predictions
plot(pred.mesa.model)
plot(pred.mesa.model, pred.type="EX.mu", col="red", add=TRUE)
plot(pred.mesa.model, pred.type="EX.mu.beta", col="green", add=TRUE)

##compare the two confidence and prediction intervalls
plot(pred.mesa.model, ID=3, pred.var=TRUE, col=c(0,0,"darkgrey"))
plot(pred.mesa.model, ID=3, STmodel=mesa.model,
     col=c("black","red","lightgrey"), add=TRUE)

##plot predictions as function of observations
par(mfrow=c(2,2))
plot(pred.mesa.model, y="obs", STmodel=mesa.model, pred.var=TRUE)

##all data, using points and colour coded by site
plot(pred.mesa.model, y="obs", STmodel=mesa.model, ID="all",
     lty=c(NA,1), pch=c(19,NA), col=c("ID", "red", "grey"),
     cex=.25, pred.var=TRUE)

##compare prediction methods, for one site only
plot(pred.mesa.model, y="obs", STmodel=mesa.model,
     lty=c(NA,1), pch=c(19,NA), cex=.25, pred.var=TRUE)
plot(pred.mesa.model, y="obs", STmodel=mesa.model, col="red",
     lty=NA, pch=c(19,NA), cex=.25, pred.type="EX.mu",
     add=TRUE)
plot(pred.mesa.model, y="obs", STmodel=mesa.model, col="green",
     lty=NA, pch=c(19,NA), cex=.25, pred.type="EX.mu.beta",
     add=TRUE)

####################################
## plot CV-pred. for a given site ##
####################################
##load CV-predictions
data(pred.cv.mesa)

par(mfcol=c(3,1),mar=c(2.5,2.5,2,.5))
plot(pred.cv.mesa, ID=1)
plot(pred.cv.mesa, ID=1, pred.type="EX.mu", col="green", add=TRUE)
plot(pred.cv.mesa, ID=1, pred.type="EX.mu.beta", col="blue", add=TRUE)

##different colours
plot(pred.cv.mesa, ID=10, col=c("blue","magenta","light blue"))

##points and lines for the observations
plot(pred.cv.mesa, ID=17, lty=c(1,NA), pch=c(NA,19), cex=.5)

##plot predictions as function of observations
par(mfrow=c(2,2))
plot(pred.cv.mesa, y="obs")

##all data, using points and colour coded by site
plot(pred.cv.mesa, y="obs", ID="all", lty=c(NA,1),
     pch=c(19,NA), cex=.25, col=c("ID", "red", "grey"))

##compare prediction methods, for one site only
plot(pred.cv.mesa, y="obs", lty=c(NA,1), pch=c(19,NA), cex=.25)
plot(pred.cv.mesa, y="obs", col="red", lty=NA, pch=c(19,NA),
     cex=.25, pred.type="EX.mu", add=TRUE)
plot(pred.cv.mesa, y="obs", col="green", lty=NA, pch=c(19,NA),
     cex=.25, pred.type="EX.mu.beta", add=TRUE)
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other predCVSTmodel methods: \code{\link{estimateCV}},
  \code{\link{estimateCV.STmodel}},
  \code{\link{predictCV}}, \code{\link{predictCV.STmodel}},
  \code{\link{print.predCVSTmodel}},
  \code{\link{print.summary.predCVSTmodel}},
  \code{\link{qqnorm.predCVSTmodel}},
  \code{\link{qqnorm.STdata}},
  \code{\link{qqnorm.STmodel}},
  \code{\link{scatterPlot.predCVSTmodel}},
  \code{\link{scatterPlot.STdata}},
  \code{\link{scatterPlot.STmodel}},
  \code{\link{summary.predCVSTmodel}}

  Other predictSTmodel methods:
  \code{\link{predict.STmodel}},
  \code{\link{print.predictSTmodel}}
}

