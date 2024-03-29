\name{detrendSTdata}
\alias{detrendSTdata}
\title{Removes Temporal Trend from Observations in a \code{STdata} Object}
\usage{
  detrendSTdata(STdata, region = NULL, method = lm, ...)
}
\arguments{
  \item{STdata}{A \code{STdata} object, see
  \code{\link{mesa.data.raw}}.}

  \item{region}{Vector of the same length and order as
  \code{STdata$covars$ID}.  Indicates region(s) in which
  different trends are to be fitted and removed.}

  \item{method}{Method for fitting the trend (set to
  \code{method=lm} if \code{is.null(method)}); should
  produce output that allows the use of
  \code{\link[stats:predict]{predict}}. Possible options
  include \code{\link[stats:lm]{lm}},
  \code{\link[MASS:rlm]{rlm}}, or
  \code{\link[MASS:lqs]{lqs}}.}

  \item{...}{Additional parameters passed to
  \code{method}.}
}
\value{
  Returns a modfied version of the input, with detrended
  observations and some changes: \item{STdata$obs}{Has an
  additional column, \code{removed.trend}, with the amount
  subtracted per observation.} \item{STdata$trend}{Is
  reduced to only the \code{date} column, indicating a
  constant trend.} \item{STdata$old.trend}{The previous
  \code{STdata$trend}, which was used for detrending.}
  \item{STdata$fit.trend}{The result of \code{method}; the
  trend component removed for each observations can be
  obtained as \code{predict(STdata$fit.trend)}. NOTE:
  Aditional functions, such as \code{\link{createSTmodel}},
  might reorder \code{STdata$obs} implying that\cr
  \code{STdata$obs$removed.trend !=
  predict(STdata$fit.trend)}.}
}
\description{
  Removes an estimated time-trend from the observations in
  a \code{STdata} object. Returns a modifed \code{STdata}
  object with no trend; the new object can be used to fit a
  simpler model.
}
\details{
  Sometimes there is no apparent spatial structure to the
  time-trend amplitude, or there is not enough
  identifiability in the data to properly model the
  structure. In that case, it is possible, at least as a
  sensitivity analysis, to de-trend the observations and
  run a model with a spatial field for the intercept only
  (apart from the spatio-temporal residual field).

  \code{detrendSTdata} will remove the trends from the
  observations, using \code{STdata$trend}. 'method' is
  applied as \cr \code{metod(STdata$obs$obs ~ F,...)} \cr
  where \code{F} is the temporal trend from
  \code{STdata$trend} for each observation; or as \cr
  \code{metod(STdata$obs$obs ~ F*obs.region,...)} \cr where
  \cr \code{obs.region = factor(region[
  match(STdata$obs$ID, STdata$covars$ID)])}. allowing for
  different trends in different region (i.e. interaction
  between the time trend(s) and region identifiers). \cr
  \code{ predict( method(...) )} is then subtracted from
  \code{STdata$obs$obs}, detrending the data.
}
\examples{
##load the data
data(mesa.data.raw)
##and create STdata-object
mesa.data <- createSTdata(mesa.data.raw$obs, mesa.data.raw$X, n.basis=2,
                          SpatioTemporal=mesa.data.raw["lax.conc.1500"])

##plot time-series for the first site,
par(mfrow=c(3,2),mar=c(2.5,2.5,3,1))
plot(mesa.data, "obs", ID=1)
##And combined for all sites
plot(mesa.data, "loc.obs", legend.loc="bottomleft")

##attempt to detrend
mesa.data.detrend <- detrendSTdata(mesa.data)
##examine object, note the trends
mesa.data.detrend

##plot detrended time-series for the first site,
plot(mesa.data.detrend, "obs", ID=1)
##And combined for all sites
plot(mesa.data.detrend, "loc.obs", legend.loc="bottomleft")

##use different detrending for different types of locations
mesa.data.detrend2 <- detrendSTdata(mesa.data, region=mesa.data$covars$type)
##examine object, note the trends
mesa.data.detrend2
##plot for the first site,
plot(mesa.data.detrend2, "obs", ID=1)
plot(mesa.data.detrend2, "loc.obs", legend.loc="bottomleft")

##compare the two fitted and removed trends
print(mesa.data.detrend$fit.trend)
print(mesa.data.detrend2$fit.trend)
}
\author{
  Assaf P. Oron and Johan Lindstr�m
}
\seealso{
  Other STdata functions: \code{\link{c.STmodel}},
  \code{\link{createDataMatrix}},
  \code{\link{createSTdata}}, \code{\link{createSTmodel}},
  \code{\link{estimateBetaFields}},
  \code{\link{removeSTcovarMean}},
  \code{\link{updateSTdataTrend}},
  \code{\link{updateTrend}},
  \code{\link{updateTrend.STdata}},
  \code{\link{updateTrend.STmodel}}
}

