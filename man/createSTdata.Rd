\name{createSTdata}
\alias{createSTdata}
\title{Construct STdata Object}
\usage{
  createSTdata(obs, covars, SpatioTemporal = NULL,
    transform.obs = function(x) {     return(x) },
    mean.0.ST = FALSE, n.basis = 0, extra.dates = NULL,
    ..., detrend = FALSE, region = NULL, method = NULL)
}
\arguments{
  \item{obs}{Either a data.frame with fields \code{obs},
  \code{date}, \code{ID} giving obsevations, time-points
  and location names; or a matrix, e.g. output from
  \code{\link{createDataMatrix}}.}

  \item{covars}{matrix/data.frame of covariates; should
  include both geographic covariates and coordinates of all
  locations, see \code{\link{stCheckCovars}}.}

  \item{SpatioTemporal}{possible spatio-temporal covariate,
  see \code{\link{stCheckSTcovars}}.}

  \item{transform.obs}{function to apply to the
  observations, defaults to an identity transform. Possible
  options are \code{\link[base:log]{log}},
  \code{\link[base:sqrt]{sqrt}}, and
  \code{\link[base:exp]{exp}}.}

  \item{mean.0.ST}{Call \code{\link{removeSTcovarMean}} to
  produce a mean-zero spatio-temporal covariate?}

  \item{n.basis}{Number of temporal components in the
  smooth trends computed by
  \code{\link{updateTrend.STdata}}, if \code{NULL} no trend
  is computed (implies only a constant).}

  \item{extra.dates}{Additional dates for which smooth
  trends should be computed, used by
  \code{\link{updateTrend.STdata}}. If \code{n.basis=NULL}
  this will force n.basis=0; since the dates are stored in
  the trend..}

  \item{...}{Additional parameters passed to
  \code{\link{updateTrend.STdata}}.}

  \item{detrend}{Use \code{\link{detrendSTdata}} to remove
  a termporal trend from the observations; requires
  \code{n.basis!=NULL}.}

  \item{region,method}{Additional parameters passed to
  \code{\link{detrendSTdata}}.}
}
\value{
  A \code{STdata} object with, some or all of, the
  following elements: \item{covars}{Geographic covariates,
  locations and names of the observation locations (the
  later in \code{covars$ID}), \code{\link{createSTmodel}}
  will extract covariates (land use regressors),
  observations locations, etc from this data.frame when
  constructing the model specification.} \item{trend}{The
  temporal trends with \emph{one of the} columns being
  named \code{date}, preferably of class
  \code{\link[base:Date]{Date}} providing the time
  alignment for the temporal trends.} \item{obs}{A
  data.frame with columns: \describe{ \item{obs}{The value
  of each observation.} \item{date}{The observations time,
  preferably of class \code{\link[base:Date]{Date}}.}
  \item{ID}{A \code{character}-class giving observation
  locations; should match elements in \code{locations$ID}.}
  } } \item{SpatioTemporal}{A 3D-array of spatio-temporal
  covariates, or \code{NULL} if no covariates exist. The
  array should be (number of timepoints) - by - (number of
  locations) - by - (number of covariates) and provide
  spatio-temporal covariates for \emph{all} space-time
  locations, even unobserved ones (needed for prediction).
  The \code{rownames} of the array should represent
  dates/times and \code{colnames} should match the
  observation location names in \code{covars$ID}.}
  \item{old.trend,fit.trend}{Additional components added if
  the observations have been detrended, see
  \code{\link{detrendSTdata}}.}
}
\description{
  Creates a \code{STdata} object that can be used as input
  for \code{\link{createSTmodel}}. Names and dates are
  derived from the input data, either using predefined
  fields or \code{rownames} / \code{colnames}; for details
  see the sub-functions linked under the relevant
  Arguments.
}
\examples{
##load the raw data
data(mesa.data.raw)

##extract observations and covariates
obs <- mesa.data.raw$obs
covars <- mesa.data.raw$X

##list with the spatio-temporal covariates
ST.list <- list(lax.conc.1500=mesa.data.raw$lax.conc.1500)

##create STdata object
mesa.data <- createSTdata(obs, covars, SpatioTemporal=ST.list)
print(mesa.data)

##create object with mean 0 spatio temporal covariate
mesa.data.2 <- createSTdata(obs, covars, SpatioTemporal=ST.list,
                            mean.0.ST=TRUE)
print(mesa.data.2)

##create object with mean 0 spatio temporal covariate, and
##trend with two components, and additional dates (every seventh day)
extra.dates <- seq(min(as.Date(rownames(obs))),
                   max(as.Date(rownames(obs))), by=7)
mesa.data.3 <- createSTdata(obs, covars, n.basis=2, extra.dates=extra.dates)
print(mesa.data.3)
}
\author{
  Johan Lindstr�m and Assaf P. Oron
}
\seealso{
  Other STdata functions: \code{\link{c.STmodel}},
  \code{\link{createDataMatrix}},
  \code{\link{createSTmodel}}, \code{\link{detrendSTdata}},
  \code{\link{estimateBetaFields}},
  \code{\link{removeSTcovarMean}},
  \code{\link{updateSTdataTrend}},
  \code{\link{updateTrend}},
  \code{\link{updateTrend.STdata}},
  \code{\link{updateTrend.STmodel}}

  Other STdata methods: \code{\link{plot.STdata}},
  \code{\link{plot.STmodel}}, \code{\link{print.STdata}},
  \code{\link{print.summary.STdata}},
  \code{\link{qqnorm.predCVSTmodel}},
  \code{\link{qqnorm.STdata}},
  \code{\link{qqnorm.STmodel}},
  \code{\link{scatterPlot.predCVSTmodel}},
  \code{\link{scatterPlot.STdata}},
  \code{\link{scatterPlot.STmodel}},
  \code{\link{summary.STdata}}
}

