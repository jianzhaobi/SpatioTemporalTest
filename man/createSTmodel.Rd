\name{createSTmodel}
\alias{createSTmodel}
\title{Construct STmodel Object}
\usage{
  createSTmodel(STdata, LUR = NULL, ST = NULL,
    cov.beta = list(covf = "exp", nugget = FALSE),
    cov.nu = list(covf = "exp", nugget = TRUE, random.effect = FALSE),
    locations = list(coords = c("x", "y"), long.lat = NULL, coords.beta = NULL,
                     coords.nu = NULL, others = NULL),
    strip = FALSE, scale = FALSE, scale.covars = NULL)
}
\arguments{
  \item{STdata}{\code{STdata} object with observations,
  covariates, trends, etc; see \code{\link{createSTdata}}
  or \code{\link{mesa.data.raw}} for an example.}

  \item{LUR}{Specification of covariates for the
  beta-fields, see \code{\link{processLUR}}.}

  \item{ST}{Specification of spatio-temporal covariates,
  see \code{\link{processST}}.}

  \item{cov.beta,cov.nu}{Specification of the covariance
  functions, see \code{\link{updateCovf}}.}

  \item{locations}{Specification of the sites (both
  monitored and un-monitored), see
  \code{\link{processLocation}}.}

  \item{strip}{Should unobserved locations be dropped?}

  \item{scale}{Scale the covariates? If \code{TRUE} all
  non-factor covariates are scaled \emph{after} the
  locations have been extracted but before constructing the
  covariate matrix for the beta-fields. (NOTE: If set to
  \code{TRUE} this scales the \code{LUR.all} elements to
  mean=0, sd=1).}

  \item{scale.covars}{list with elements \code{mean} and
  \code{sd} giving the mean and standard deviation to use
  when scaling the covariates. Computed from
  \code{STdata$covars} if not given.}
}
\value{
  A \code{STmodel} object, see \code{\link{mesa.model}} for
  an example.
}
\description{
  Creates a \code{STmodel} object that can be for
  estimation and prediction. For details see the
  sub-functions linked under the relevant Arguments.
}
\details{
  The object holds observations, trends, geographic, and
  spatio-temporal covariates, as well as a number of
  precomputed fields that speed up log-likelihood
  evaluations. To improve performance the locations are
  also \strong{reorder} so that observed locations come
  before unobserved.
}
\examples{
##load the data
data(mesa.data.raw)
##and create STdata-object
mesa.data <- createSTdata(mesa.data.raw$obs, mesa.data.raw$X, n.basis=2,
                          SpatioTemporal=mesa.data.raw["lax.conc.1500"])

##define land-use covariates
LUR <-  list(~log10.m.to.a1+s2000.pop.div.10000+km.to.coast,
             ~km.to.coast, ~km.to.coast)
##and covariance model
cov.beta <- list(covf="exp", nugget=FALSE)
cov.nu <- list(covf="exp", nugget=TRUE, random.effect=FALSE)
##which locations to use
locations <- list(coords=c("x","y"), long.lat=c("long","lat"), others="type")

##create object
mesa.model <- createSTmodel(mesa.data, LUR=LUR, ST="lax.conc.1500",
                            cov.beta=cov.beta, cov.nu=cov.nu,
                            locations=locations)
print(mesa.model)
##This is the same as data(mesa.model)

##lets try some alternatives:
model.none <- createSTmodel(mesa.data, LUR=NULL, ST=NULL)
print(model.none)

##Specify LUR:s using numbers
names(mesa.data$covars)
model.diff <- createSTmodel(mesa.data, LUR=list(c(7,10,11,12),11:12,11:12),
                            ST=1)
print(model.diff)

##Same covariates for all temporal trends, calling by name
##but with different covariance models for each trend, and nugget that depends
##on monitor type
model.same <- createSTmodel(mesa.data, LUR=c("log10.m.to.a1", "log10.m.to.road",
                                         "km.to.coast","s2000.pop.div.10000"),
                            ST="lax.conc.1500", cov.nu=list(nugget="type"),
                            cov.beta=list(covf=c("exp","exp2","iid"),
                              nugget=c(FALSE, FALSE, TRUE)) )
print(model.same)
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other STdata functions: \code{\link{c.STmodel}},
  \code{\link{createDataMatrix}},
  \code{\link{createSTdata}}, \code{\link{detrendSTdata}},
  \code{\link{estimateBetaFields}},
  \code{\link{removeSTcovarMean}},
  \code{\link{updateSTdataTrend}},
  \code{\link{updateTrend}},
  \code{\link{updateTrend.STdata}},
  \code{\link{updateTrend.STmodel}}

  Other STmodel functions: \code{\link{createCV}},
  \code{\link{createDataMatrix}},
  \code{\link{dropObservations}},
  \code{\link{estimateBetaFields}},
  \code{\link{loglikeST}}, \code{\link{loglikeSTdim}},
  \code{\link{loglikeSTnaive}}, \code{\link{predictNaive}},
  \code{\link{processLocation}}, \code{\link{processLUR}},
  \code{\link{processST}}, \code{\link{updateCovf}},
  \code{\link{updateSTdataTrend}},
  \code{\link{updateTrend}},
  \code{\link{updateTrend.STdata}},
  \code{\link{updateTrend.STmodel}}

  Other STmodel methods: \code{\link{c.STmodel}},
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

