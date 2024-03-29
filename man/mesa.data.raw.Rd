\docType{data}
\name{mesa.data.raw}
\alias{mesa.data.raw}
\title{Data used in the examples}
\format{The structure contains observations, temporal trends, locations,
  geographic covariates, and spatio-temporal covariates. The data is
  stored as a list with elements:
  \describe{
    \item{X}{A data.frame containing names, locations, and (geographic)
             covariates for all the (observation) locations.}
    \item{obs}{A time-by-location matrix for the observed data, missing data
               marked as \code{NA}}
    \item{lax.conc.1500}{A time-by-location matrix of a spatio-temporal
                         covariate based on output from Caline3QHC.}
  }}
\source{
  Contains monitoring data from the \strong{MESA Air}
  project, see Cohen et.al. (2009) for details.
}
\description{
  The raw data that was used to create the
  \code{\link{mesa.model}} structures. \cr The data
  structure contains raw data from the \strong{MESA Air}
  project. The example below describes how to create the
  \code{\link{mesa.model}} structure from raw data.
}
\examples{
##load the data
data(mesa.data.raw)

##extract matrix of observations (missing marked by NA)
obs.mat <- mesa.data.raw$obs
head(obs.mat)

##optionally observations can be given as a data.frame
obs <- data.frame(obs=c(obs.mat),
                  date=rep(rownames(obs.mat), dim(obs.mat)[2]),
                  ID=rep(colnames(obs.mat), each=dim(obs.mat)[1]))
##force date-format
obs$date <- as.Date(obs$date)

##drop unobserved
obs <- obs[!is.na(obs$obs),,drop=FALSE]

##create a 3D-array for the spatio-temporal covariate
ST <- array(mesa.data.raw$lax.conc.1500, dim =
            c(dim(mesa.data.raw$lax.conc.1500),1))
dimnames(ST) <- list(rownames(mesa.data.raw$lax.conc),
                     colnames(mesa.data.raw$lax.conc),
                     "lax.conc.1500")
##or use a list of matrices
ST.list <- list(lax.conc.1500=mesa.data.raw$lax.conc.1500)

###########################
## create STdata object ##
###########################
##Create the data-object
mesa.data <- createSTdata(obs.mat, mesa.data.raw$X, n.basis=2,
                          SpatioTemporal=ST)
mesa.data.2 <- createSTdata(obs, mesa.data.raw$X, n.basis=2,
                            SpatioTemporal=ST.list)

##This should yield equal structures,
##which are also the same as data(mesa.data)
all.equal(mesa.data, mesa.data.2)

###########################
## create STmodel object ##
###########################
##define land-use covariates, for intercept and trends
LUR <- list(~log10.m.to.a1+s2000.pop.div.10000+km.to.coast,
  ~km.to.coast, ~km.to.coast)
##and covariance model
cov.beta <- list(covf="exp", nugget=FALSE)
cov.nu <- list(covf="exp", nugget=~type, random.effect=FALSE)
##which locations to use
locations <- list(coords=c("x","y"), long.lat=c("long","lat"), others="type")
##create object
mesa.model <- createSTmodel(mesa.data, LUR=LUR, ST="lax.conc.1500",
                            cov.beta=cov.beta, cov.nu=cov.nu,
                            locations=locations)

##This should be the same as the data in data(mesa.model)
}
\references{
  M. A. Cohen, S. D. Adar, R. W. Allen, E. Avol, C. L.
  Curl, T.  Gould, D. Hardie, A. Ho, P. Kinney, T. V.
  Larson, P. D. Sampson, L.  Sheppard, K. D. Stukovsky, S.
  S. Swan, L. S. Liu, J. D. Kaufman. (2009) Approach to
  Estimating Participant Pollutant Exposures in the
  Multi-Ethnic Study of Atherosclerosis and Air Pollution
  (MESA Air). Environmental Science & Technology: 43(13),
  4687-4693.
}
\seealso{
  \code{\link{createSTdata}} for creation of \code{STdata}
  objects.

  Other data matrix: \code{\link{createDataMatrix}},
  \code{\link{estimateBetaFields}}, \code{\link{SVDmiss}},
  \code{\link{SVDsmooth}}, \code{\link{SVDsmoothCV}}

  Other example data: \code{\link{est.cv.mesa}},
  \code{\link{est.mesa.model}},
  \code{\link{MCMC.mesa.model}}, \code{\link{mesa.model}},
  \code{\link{pred.mesa.model}}
}
\keyword{datasets}

