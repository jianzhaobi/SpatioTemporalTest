\name{calcSmoothTrends}
\alias{calcSmoothTrends}
\title{Smooth Basis Functions for a STdata Object}
\usage{
  calcSmoothTrends(STdata = NULL, obs = STdata$obs$obs,
    date = STdata$obs$date, ID = STdata$obs$ID,
    subset = NULL, extra.dates = NULL, n.basis = 2,
    cv = FALSE, ...)
}
\arguments{
  \item{STdata}{A \code{STdata}/\code{STmodel} data
  structure containing observations, see
  \code{\link{mesa.data.raw}}. Use either this or the
  \code{obs}, \code{date}, and \code{ID} inputs.}

  \item{obs}{A vector of observations.}

  \item{date}{A vector of observation times.}

  \item{ID}{A vector of observation locations.}

  \item{subset}{A subset of locations to extract the data
  matrix for. A warning is given for each name not found in
  \code{ID}.}

  \item{extra.dates}{Additional dates for which smooth
  trends should be computed (any duplicates will be
  removed).}

  \item{n.basis}{Number of basis functions to compute, see
  \code{\link{SVDsmooth}}.}

  \item{cv}{Also compute smooth functions using leave one
  out cross-validation, \cr see \code{\link{SVDsmoothCV}}.}

  \item{...}{Additional parameters passed to
  \code{\link{SVDsmooth}} and \code{\link{SVDsmoothCV}};
  except \code{fnc}, which is always \code{TRUE}.}
}
\value{
  Returns a list with \item{trend}{A data.frame containing
  the smooth trends and the dates.  This can be used as the
  \code{trend} in \code{STdata$trend}.} \item{trend.cv}{If
  \code{cv==TRUE} a list of data.frames; each one
  containing the smooth trend obtained when leaving one
  site out.  Similar to \cr
  \code{SVDsmoothCV(data)$smoothSVD[[1]]}).}
  \item{trend.fnc,trend.fnc.cv}{Functions that produce the
  content of the above data.frames, see
  \code{\link{SVDsmooth}}.}
}
\description{
  A front end function for calling \code{\link{SVDsmooth}}
  (and \code{\link{SVDsmoothCV}}), with either a
  \code{STdata} object or vectors containing observations,
  dates and locations.
}
\details{
  The function uses \code{\link{createDataMatrix}} to
  create a data matrix which is passed to
  \code{\link{SVDsmooth}} (and \code{\link{SVDsmoothCV}}).
  The output can be used as \cr \code{STdata$trend =
  calcSmoothTrends(...)$trend}, or \cr \code{STdata$trend =
  calcSmoothTrends(...)$trend.cv[[i]]}. However, it is
  recommended to use \code{\link{updateTrend.STdata}}.
}
\examples{
##let's load some data
data(mesa.model)

##let's compute two smooth trend functions
trend <- calcSmoothTrends(mesa.model, n.basis=2)

##or with some other parameters for the splines
trend.alt <- calcSmoothTrends(mesa.model, n.basis=2, df=100)

##and study the trends
par(mfrow=c(2,1), mar=c(2.5,2.5,.5,.5))
plot(trend$trend$date, trend$trend$V1, type="l", ylab="", xlab="",
     ylim=range(c(trend$trend$V1, trend$trend$V2)))
lines(trend$trend$date, trend$trend$V2, col=2)
plot(trend.alt$trend$date, trend.alt$trend$V1,
     type="l", ylab="", xlab="",
     ylim=range(c(trend.alt$trend$V1, trend.alt$trend$V2)))
lines(trend.alt$trend$date, trend.alt$trend$V2, col=2)

##Let's exclude locations with fewer than 100 observations
IND <- names(which(table(mesa.model$obs$ID) >= 100))
##now we also compute the CV trends.
trend2 <- calcSmoothTrends(mesa.model, n.basis=2, subset=IND, cv=TRUE)

##Let's compare to the previous result
lines(trend2$trend$date, trend2$trend$V1, lty=2)
lines(trend2$trend$date, trend2$trend$V2, lty=2, col=2)

##we can also study the cross validated results to examine the
##possible variation in the estimated trends.
plot(trend$trend$date, trend2$trend$V1, type="n", ylab="", xlab="",
     ylim=range(c(trend2$trend$V1, trend2$trend$V2)))
for(i in 1:length(trend2$trend.cv)){
  lines(trend2$trend.cv[[i]]$date, trend2$trend.cv[[i]]$V1, col=1)
  lines(trend2$trend.cv[[i]]$date, trend2$trend.cv[[i]]$V2, col=2)
}

##trend functions for every week (mesa.model$obs$date is every 2-weekss)
trend.more <- calcSmoothTrends(mesa.model, n.basis=2,
                               extra.dates=seq(min(mesa.model$obs$date),
                                 max(mesa.model$obs$date), by=7))
##This results in a message detailing how many times that
##have hade interpolated trends (i.e. no data)

##compare to the earlier
plot(trend$trend$date, trend$trend$V1, pch=19,
     ylim=range(c(trend$trend$V1, trend.more$trend$V1)))
points(trend.more$trend$date, trend.more$trend$V1, col=2, pch=3)
}
\author{
  Johan Lindstr�m and Paul D. Sampson
}
\seealso{
  Other SVD for missing data: \code{\link{boxplot.SVDcv}},
  \code{\link{plot.SVDcv}}, \code{\link{print.SVDcv}},
  \code{\link{summary.SVDcv}}, \code{\link{SVDmiss}},
  \code{\link{SVDsmooth}}, \code{\link{SVDsmoothCV}},
  \code{\link{updateSTdataTrend}},
  \code{\link{updateTrend}},
  \code{\link{updateTrend.STdata}},
  \code{\link{updateTrend.STmodel}}
}

