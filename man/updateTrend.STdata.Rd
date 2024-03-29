\name{updateTrend.STdata}
\alias{updateSTdataTrend}
\alias{updateTrend}
\alias{updateTrend.STdata}
\alias{updateTrend.STmodel}
\title{Update Trend in \code{STdata} or \code{STmodel} Object}
\usage{
  \method{updateTrend}{STdata} (object, n.basis = 0,
    fnc = NULL, extra.dates = NULL, ...)

  \method{updateTrend}{STmodel} (object, n.basis = 0,
    fnc = NULL, ...)

  updateTrend(object, n.basis = 0, fnc = NULL, ...)

  updateSTdataTrend(object, n.basis = 0,
    extra.dates = NULL, fnc = NULL, ...)
}
\arguments{
  \item{object}{A \code{STdata} or \code{STmodel} object,
  see \code{\link{mesa.data.raw}}.}

  \item{n.basis}{number of basis functions for the temporal
  trend}

  \item{extra.dates}{Additional dates for which smooth
  trends should be computed (otherwise only those in
  \code{object$obs$date} are used); \emph{only} for
  \code{STdata}.}

  \item{fnc}{Function that defines the trend, see Details
  and Example.}

  \item{...}{Additional parameters passed to
  \code{\link{calcSmoothTrends}}.}
}
\value{
  Returns a modfied version of the input, with an
  added/altered trend.
}
\description{
  Updates/sets the temporal trend for \code{STdata} or
  \code{STmodel} objects. It also checks that the
  spatio-temporal covariate exists for all dates in the
  trend, mainly an issue if \code{extra.dates!=NULL} adds
  additional times at which to do predictions.
}
\details{
  If \code{n.basis} is given this will use
  \code{\link{calcSmoothTrends}} to compute smoothed SVDs
  of data for use as temporal trends. If \code{fnc} is
  given, \code{n.basis} is ignored and \code{fnc} should be
  a function that, given a vector of dates, returns an
  object that can be coerced to a data.frame with
  \emph{numeric} temporal trends; recall that an intercept
  is \strong{always} added.

  For a \code{STmodel} object the new trend \emph{must have
  no more} components than the existing trend; if a
  function is given \code{colnames} of the new trend
  \emph{must match} those of the existing trend. In both
  cases the returned \code{STdata} or \code{STmodel} object
  will have both a \code{$trend} and \code{$trend.fnc}
  field.

  Function \code{updateSTdataTrend} is deprecated and will
  be removed in future versions of the package.
}
\examples{
##load data
data(mesa.model)

##default data and time trend for one location
par(mfrow=c(3,1), mar=c(2.5,2.5,3,1))
plot(mesa.model)

##let's try with no trend
mesa.model.0 <- updateTrend(mesa.model, n.basis=0)
plot(mesa.model.0)

##...and two basis functions, based on only AQS sites and much less smooth
subset <- mesa.model$locations$ID[mesa.model$locations$type=="AQS"]
mesa.model.2 <- updateTrend(mesa.model, n.basis=2, subset=subset, df=100)
plot(mesa.model.2)

##Compute trends based on only 10 sites (and compute the cross-validated
##trends leaving each of the sites out
smooth.trend <- calcSmoothTrends(mesa.model, n.basis=2, cv=TRUE,
                                 subset=subset[1:10])

##update trends using the function definition
mesa.model <- updateTrend(mesa.model, fnc=smooth.trend$trend.fnc)

##and create objects with each of the trends.
mesa.model.cv <- vector("list", length(smooth.trend$trend.fnc.cv))
for(i in 1:length(mesa.model.cv)){
  suppressMessages(mesa.model.cv[[i]] <- updateTrend(mesa.model, 
                   fnc=smooth.trend$trend.fnc.cv[[i]]))
}

##plot
par(mfrow=c(1,1),mar=c(2.5,2.5,3,1))
plot(mesa.model)
for(i in 1:length(mesa.model.cv)){
  plot(mesa.model.cv[[i]], add=TRUE, col=i, pch=NA, lty=c(NA,2))
}
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other STdata functions: \code{\link{c.STmodel}},
  \code{\link{createDataMatrix}},
  \code{\link{createSTdata}}, \code{\link{createSTmodel}},
  \code{\link{detrendSTdata}},
  \code{\link{estimateBetaFields}},
  \code{\link{removeSTcovarMean}}

  Other STmodel functions: \code{\link{createCV}},
  \code{\link{createDataMatrix}},
  \code{\link{createSTmodel}},
  \code{\link{dropObservations}},
  \code{\link{estimateBetaFields}},
  \code{\link{loglikeST}}, \code{\link{loglikeSTdim}},
  \code{\link{loglikeSTnaive}}, \code{\link{predictNaive}},
  \code{\link{processLocation}}, \code{\link{processLUR}},
  \code{\link{processST}}, \code{\link{updateCovf}}

  Other SVD for missing data: \code{\link{boxplot.SVDcv}},
  \code{\link{calcSmoothTrends}}, \code{\link{plot.SVDcv}},
  \code{\link{print.SVDcv}}, \code{\link{summary.SVDcv}},
  \code{\link{SVDmiss}}, \code{\link{SVDsmooth}},
  \code{\link{SVDsmoothCV}}
}

