\name{removeSTcovarMean}
\alias{removeSTcovarMean}
\title{Mean-Centre the Spatio-Temporal Covariate}
\usage{
  removeSTcovarMean(STdata)
}
\arguments{
  \item{STdata}{A \code{STdata} object, see
  \code{\link{mesa.data.raw}}.}
}
\value{
  Returns a modfied version of the input, where the
  spatio-temporal covariates have been expanded to include
  covariates where the site by site temporal average has
  been removed. The averages are seen as geographic
  covariates and added to \code{STdata$covars}.
}
\description{
  Removes the temporal mean at each location for the
  spatio-temporal covariares. The means are added to the
  \code{covar} field in the returned object and can be used
  as geographic covariates.
}
\examples{
##load the data
data(mesa.data.raw)
##and create STdata-object
mesa.data <- createSTdata(mesa.data.raw$obs, mesa.data.raw$X, n.basis=2,
                          SpatioTemporal=mesa.data.raw["lax.conc.1500"])

mesa.data.mean0 <- removeSTcovarMean(mesa.data)

##compare the data structures
##geographic covariates
summary(mesa.data$covars)
summary(mesa.data.mean0$covars)

##mean of the spatio-temporal covariate, note that the new
##contains both mean-zero and original
cbind(colMeans(mesa.data$SpatioTemporal),
      colMeans(mesa.data.mean0$SpatioTemporal))

\dontshow{
  if( max(abs(colMeans(mesa.data.mean0$SpatioTemporal[,,2]))) > 1e-10 ){
    stop("remove.ST.mean 1: mean(centred ST) != 0")
  }
  if( max(abs(mesa.data.mean0$covars$mean.lax.conc.1500 - 
              colMeans(mesa.data$SpatioTemporal))) > 1e-10 ){
    stop("remove.ST.mean 2: extracted mean != mean(ST)")
  }
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
  \code{\link{updateSTdataTrend}},
  \code{\link{updateTrend}},
  \code{\link{updateTrend.STdata}},
  \code{\link{updateTrend.STmodel}}
}

