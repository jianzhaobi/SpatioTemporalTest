\name{plot.STdata}
\alias{plot.STdata}
\alias{plot.STmodel}
\title{Different Plots for \code{STdata}/\code{STmodel} object}
\usage{
  \method{plot}{STdata} (x,
    y = c("obs", "res", "acf", "pacf", "loc", "loc.obs"),
    ID = x$covars$ID[1], type = x$covars$type, col = NULL,
    pch = NULL, cex = NULL, lty = NULL,
    legend.loc = "topleft", legend.names = NULL,
    add = FALSE, ...)

  \method{plot}{STmodel} (x, y = "obs",
    ID = x$locations$ID[1], type = x$locations$type, ...)
}
\arguments{
  \item{x}{\code{STdata}/\code{STmodel} object to plot.}

  \item{y}{Type of plot, options are \code{"obs"},
  \code{"res"}, \code{"acf"}, \code{"pacf"}, \code{"loc"},
  or \code{"loc.obs"}, see details below.}

  \item{ID}{The location for which we want to plot
  observations. Either a string matching the names in
  \code{x$covars$ID} or an integer; if an integer the
  functions will plot data from \code{ID=x$covars$ID[ID]}.}

  \item{type}{Factorial of \code{length(x$covars$type)},
  used by \code{"loc"} and \code{"loc.obs"} to determine
  how many groups should be plotted and colour/type coded.}

  \item{col,pch,cex,lty}{Colour, type of points, size of
  points, and type of lines. Exact meaning depends on value
  of \code{y}, see Details.}

  \item{legend.loc}{The location of the legend, for
  \code{"loc"} and \code{"loc.obs"}. See
  \code{\link[graphics:legend]{legend}}.}

  \item{legend.names}{A vector of character strings to be
  used in the legend, for \code{"loc"} and for
  \code{"loc.obs"}}

  \item{add}{Add to existing plot, only relevant if
  \code{y} is \code{"obs"}, \code{"res"}, \code{"loc"}, or
  \code{"loc.obs"}.}

  \item{...}{Additional parameters passed to
  \code{\link[graphics:plot]{plot}} or
  \code{\link[stats:plot.acf]{plot.acf}}.}
}
\value{
  Nothing
}
\description{
  \code{\link[graphics:plot]{plot}} method for class
  \code{STdata} or \code{STmodel}. Provides several
  different plots of the data. When calles for
  \code{STmodel}, \code{STmodel$locations} acts as
  \code{STdata$covars}.
}
\details{
  Performs a variety of different plots determined by
  \code{y}: \describe{ \item{"obs"}{Plot observations for
  location \code{ID}, along with the fitted temporal
  trend.} \item{"res"}{Plot residuals for the fitted
  temporal trend at location \code{ID}; adds the \code{y=0}
  line for reference.} \item{"acf"}{Plot autocorrelation
  function for the residuals from the fitted temporal trend
  at location \code{ID}.} \item{"pacf"}{Plot partial
  autocorrelation function for the residuals from the
  fitted temporal trend at location \code{ID}.}
  \item{"loc"}{Plot the observation location index number
  as a function of the observation date, for all
  observations. Possibly coded by the \code{type} of
  observations locations.} \item{"loc.obs"}{Plot the
  observation value as a function of the observation date,
  for all observations. Possibly coded by the \code{type}
  of observations locations.} }

  For \code{y=c("obs","res")} the first element of
  \code{col,pch,cex,lty} is used to specify plotting of the
  observations, and the second element is used to specify
  plotting of the fitted temporal trend, or 0-line for
  \code{"res"}. Defaults: \code{col=1}, \code{pch=c(1,NA)},
  \code{cex=1}, \code{lty=c(NA,1)}. Elements of length one
  are repeated.

  For \code{y=c("acf","pacf")} \code{col,pch,cex,lty} are
  ignored.

  For \code{y=c("loc","loc.obs")} \code{col,pch,cex} are
  used to specify the points for each of the different
  levels in \code{type} and should be of length 1 or
  \code{length(levels(type))}. \code{lty} is ignored.
  Default: \code{col=1:length(levels(type))},
  \code{pch=19}, \code{cex=.1}

  For \code{y=c("loc","loc.obs")} a legend is added if
  \code{legend.loc!=NULL}. The vector \code{legend.names}
  should have length equal to the number of unique location
  types.  The default legend names are \code{levels(type)}.
}
\examples{
##load data
data(mesa.model)

##default plot
plot(mesa.model)

##plot monitor locations
plot(mesa.model, "loc")

##different names/colours/etc
plot(mesa.model, "loc", main="A nice plot", col=c("green","blue"),
    legend.names=c("Sites of one type", "..and of the other"),
    legend.loc="topleft")

##composite time-trend
plot(mesa.model, "loc.obs", legend.loc="bottomleft", cex=.5, pch=c(3,4))

##plot tim-series for the first site,
layout(matrix(c(1,2,3,1,2,4),3,2))
plot(mesa.model, "obs", ID=1, col=c("red", "black"))
##residuals from the temporal trends,
plot(mesa.model, "res", ID=1, col=c("black","grey"))
##afc 
plot(mesa.model, "acf", ID=1)
##... and pafc for the residuals
plot(mesa.model, "pacf", ID=1, ci.col="red")

##Different site and with no temporal trend.
mesa.model <- updateTrend(mesa.model, n.basis=0)
layout(matrix(c(1,2,3,1,2,4),3,2))
plot(mesa.model, "obs", ID="60370016")
plot(mesa.model, "res", ID="60370016")
plot(mesa.model, "acf", ID="60370016")
plot(mesa.model, "pacf", ID="60370016")
}
\author{
  Johan Lindstr�m and Assaf P. Oron
}
\seealso{
  Other STdata methods: \code{\link{createSTdata}},
  \code{\link{print.STdata}},
  \code{\link{print.summary.STdata}},
  \code{\link{qqnorm.predCVSTmodel}},
  \code{\link{qqnorm.STdata}},
  \code{\link{qqnorm.STmodel}},
  \code{\link{scatterPlot.predCVSTmodel}},
  \code{\link{scatterPlot.STdata}},
  \code{\link{scatterPlot.STmodel}},
  \code{\link{summary.STdata}}

  Other STmodel methods: \code{\link{c.STmodel}},
  \code{\link{createSTmodel}}, \code{\link{estimate}},
  \code{\link{estimate.STmodel}}, \code{\link{estimateCV}},
  \code{\link{estimateCV.STmodel}}, \code{\link{MCMC}},
  \code{\link{MCMC.STmodel}},
  \code{\link{predict.STmodel}}, \code{\link{predictCV}},
  \code{\link{predictCV.STmodel}},
  \code{\link{print.STmodel}},
  \code{\link{print.summary.STmodel}},
  \code{\link{qqnorm.predCVSTmodel}},
  \code{\link{qqnorm.STdata}},
  \code{\link{qqnorm.STmodel}},
  \code{\link{scatterPlot.predCVSTmodel}},
  \code{\link{scatterPlot.STdata}},
  \code{\link{scatterPlot.STmodel}},
  \code{\link{simulate.STmodel}},
  \code{\link{summary.STmodel}}
}

