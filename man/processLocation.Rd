\name{processLocation}
\alias{processLocation}
\title{Internal Function that Extracts Locations}
\usage{
  processLocation(STdata, locations)
}
\arguments{
  \item{STdata}{\code{STdata} object with observations,
  covariates, trends, etc; see
  \code{\link{mesa.data.raw}}.}

  \item{locations}{A list specifying which fields in
  \code{STdata$covars} that should be used for what in the
  location data.frame, see details.}
}
\value{
  A data.frame with location information for all the sites.
}
\description{
  Function that creates a data.frame of locations (and
  auxillirary information) from \code{STdata$covars}, used
  by \code{\link{createSTmodel}}.
}
\details{
  The \code{locations} list specifies what should go in the
  locations data.frame, in addition to thing listed below
  \code{STdata$covars$ID} is always added. Each of the
  fields below should contain names (as character) of
  columns in \code{STdata$covars} \describe{
  \item{coords}{The x,y-coordinates for monitors}
  \item{coords.beta,coords.nu}{Alternative x,y-coordinates
  for monitors, used when computing distance-matrices for
  the beta- and nu-fields. Allows the use of non-stationary
  covariance structures thourgh the deformation method of
  Damian (2003), given a precomputed deformation.}
  \item{long.lat}{The long,lat-coordinates for monitors}
  \item{others}{Additional fields in \code{STdata$covars}
  that should be added to the location data.frame} }
}
\examples{
##load the data
data(mesa.data.raw)
##and create STdata-object
mesa.data <- createSTdata(mesa.data.raw$obs, mesa.data.raw$X, n.basis=2,
                          SpatioTemporal=mesa.data.raw["lax.conc.1500"])

##specify locations, using x/y and specifying long/lat and picking
##type as an additional field
loc.spec <- list(coords=c("x","y"), long.lat=c("long","lat"), others="type")
##create the location data.frame
str( processLocation(mesa.data, loc.spec) )

##specify only locations
str( processLocation(mesa.data, list(coords=c("x","y"))) )

##different coordinates for beta and nu fields
loc.spec <- list(coords=c("x","y"), coords.nu=c("long","lat"))
str( processLocation(mesa.data, loc.spec) )
}
\author{
  Johan Lindstr�m
}
\references{
  D. Damian, P. D. Sampson, P. Guttorp. (2003) Variance
  modeling for nonstationary processes with temporal
  replications. J. Geophys. Res.: D24(108)
}
\seealso{
  Other STmodel functions: \code{\link{createCV}},
  \code{\link{createDataMatrix}},
  \code{\link{createSTmodel}},
  \code{\link{dropObservations}},
  \code{\link{estimateBetaFields}},
  \code{\link{loglikeST}}, \code{\link{loglikeSTdim}},
  \code{\link{loglikeSTnaive}}, \code{\link{predictNaive}},
  \code{\link{processLUR}}, \code{\link{processST}},
  \code{\link{updateCovf}},
  \code{\link{updateSTdataTrend}},
  \code{\link{updateTrend}},
  \code{\link{updateTrend.STdata}},
  \code{\link{updateTrend.STmodel}}
}

