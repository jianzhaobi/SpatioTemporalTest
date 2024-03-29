\name{c.STmodel}
\alias{c.STmodel}
\title{Combine Several STmodel/STdata Objects}
\usage{
  \method{c}{STmodel} (..., recursive = FALSE)
}
\arguments{
  \item{...}{\code{STmodel} and \code{STdata} objects to
  combine, the first object has to be a \code{STmodel}.}

  \item{recursive}{For S3 compatibility; the function will
  ALWAYS run recursively}
}
\value{
  An updated \code{STmodel} object.
}
\description{
  Combines several locations and covariates for several
  STmodel/STdata objects. Temporal trend, observations and
  covariance model (both spatial and spatio-temporal) are
  taken from the first object in the call. Any additional
  covariates/trends/observations not present in the first
  argument are dropped from the additional arguments
  \emph{without warning}. Locations and covariates (both
  spatial and spatio-temporal) from additional objects are
  added to those in the first object.
}
\details{
  For additional \code{STdata} objects the covariates are
  transformed according to \code{STmodel$scale.covars} of
  the first object, see \code{\link{createSTmodel}}.

  For \code{STmodel} objects \strong{can not} be combined
  if either has scaled covariates.
}
\examples{
##load the data
data(mesa.data.raw)
##and create STdata-object
mesa.data <- createSTdata(mesa.data.raw$obs, mesa.data.raw$X, n.basis=2,
                          SpatioTemporal=mesa.data.raw["lax.conc.1500"])

##keep only observations from the AQS sites
ID.AQS <- mesa.data$covars$ID[ mesa.data$covars$type=="AQS" ]
mesa.data$obs <- mesa.data$obs[mesa.data$obs$ID \%in\% ID.AQS,]

##model specification
LUR <- list(~log10.m.to.a1 + s2000.pop.div.10000 + km.to.coast,
            ~km.to.coast, ~km.to.coast)
locations <- list(coords=c("x","y"), long.lat=c("long","lat"), others="type")

##create reduced model, without and with a spatio-temporal covariate.
mesa.model <- createSTmodel(mesa.data, LUR=LUR, locations=locations,
                            strip=TRUE)
mesa.model.ST <- createSTmodel(mesa.data, LUR=LUR, ST=1,
                               locations=locations, strip=TRUE)
##and non stripped version
mesa.model.full <- createSTmodel(mesa.data, LUR=LUR, ST=1,
                                 locations=locations)

##combine, this adds the missing locations
mesa.model$locations$ID
c(mesa.model, mesa.data)$locations$ID

##or we could study the summary output
print(c(mesa.model.ST, mesa.data))

##no change since we're tryin to adding existing sites
mesa.model.full$locations$ID
c(mesa.model.full, mesa.data)$locations$ID

##We can also combine two STmodels
print(c(mesa.model, mesa.model.full))
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other STdata functions: \code{\link{createDataMatrix}},
  \code{\link{createSTdata}}, \code{\link{createSTmodel}},
  \code{\link{detrendSTdata}},
  \code{\link{estimateBetaFields}},
  \code{\link{removeSTcovarMean}},
  \code{\link{updateSTdataTrend}},
  \code{\link{updateTrend}},
  \code{\link{updateTrend.STdata}},
  \code{\link{updateTrend.STmodel}}

  Other STmodel methods: \code{\link{createSTmodel}},
  \code{\link{estimate}}, \code{\link{estimate.STmodel}},
  \code{\link{estimateCV}},
  \code{\link{estimateCV.STmodel}}, \code{\link{MCMC}},
  \code{\link{MCMC.STmodel}}, \code{\link{plot.STdata}},
  \code{\link{plot.STmodel}},
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

