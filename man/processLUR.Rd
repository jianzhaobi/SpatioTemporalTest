\name{processLUR}
\alias{processLUR}
\alias{processST}
\title{Internal Function that do Covariate Selection}
\usage{
  processLUR(STdata, LUR.in)

  processST(STdata, ST.in)
}
\arguments{
  \item{STdata}{\code{STdata} object with observations,
  covariates, trends, etc; see
  \code{\link{mesa.data.raw}}.}

  \item{LUR.in}{A vector or list indicating which
  geographic covariates to use.}

  \item{ST.in}{A vector indicating which spatio-temporal
  covariates to use.}
}
\value{
  A list of LUR specifications, as
  \code{\link[stats:formula]{formula}}; or a ST
  specification as a character vector.
}
\description{
  Function that create covariate specifications for
  \code{\link{createSTmodel}}, and compare the covariates
  requested (both geographic and spatio-temporal) with
  those available in \code{STdata}.
}
\details{
  Several options exist for \code{LUR.in} \describe{
  \item{\code{LUR.in=NULL}}{Only an intercept for all
  beta-fields.} \item{\code{LUR.in="all"}}{Use all elements
  in \code{STdata$covars}, \emph{NOT} recommended.}
  \item{\code{LUR.in=list(...)}}{Use different covariates
  for each, specified by the different components of the
  list.} \item{\code{LUR.in=vector}}{Use the same
  covariates for all beta-field.} } For the two last
  options the vector/list-elements can contain either:
  \describe{ \item{integer}{This will be used as
  \code{names(STdata$covars)[int]} to extract a character
  vector (see below) of covariates.} \item{character}{The
  character vector will be used to create a
  \code{\link[stats:formula]{formula}} (see below),
  through: \cr \code{as.formula(paste("~",
  paste(unique(chars), collapse="+")), env=.GlobalEnv)} }
  \item{\code{\link[stats:formula]{formula}}}{The formula
  will be used as \code{
  \link[stats:model.matrix]{model.matrix}(formula,
  STdata$covars) } to create a covariate matrix.} } Setting
  any element(s) of the list to \code{NULL} implies
  \emph{only an intercept} for the corresponding temporal
  trend(s).

  \code{ST.in} should be a vector specifying the
  spatio-temporal covariates to use; the vector either give
  names or layers in \code{STdata$SpatioTemporal} to use,
  compare \code{character} and \code{integer} options for
  \code{LUR.in} above.

  If covariates are specified using names these should
  match \cr \code{dimnames(STdata$SpatioTemporal)[[3]]},
  unmatched elements are dropped with a warning.
}
\examples{
##load the data
data(mesa.data.raw)
##and create STdata-object
mesa.data <- createSTdata(mesa.data.raw$obs, mesa.data.raw$X, n.basis=2,
                          SpatioTemporal=mesa.data.raw["lax.conc.1500"])

##create a simple set of covariates
processLUR(mesa.data, list(c(7:9),7,8))

##or a structure with the same covariates for all
##temporal trends
processLUR(mesa.data, c(7,11))

##or a structure with only intercept for the temporal trends
processLUR(mesa.data, list(c(7:9),NULL,NULL))

##Ask for covariates by name
processLUR(mesa.data, list(c("log10.m.to.a1","log10.m.to.a2"),
                           "log10.m.to.a1","log10.m.to.a1"))
##use formula for part of it
processLUR(mesa.data, list(~log10.m.to.a1+log10.m.to.a2+log10.m.to.a1*km.to.coast,
                           "log10.m.to.a1", "log10.m.to.a1"))

##Ask for non-existent covariate by name or formula, or location
##for each temporal trend)
try(processLUR(mesa.data, list("log10.m.to.a4",~log10.m.to.a1+log10.m.to.a4, 25)))

##create a simple set of spatio-temporal covariates
processST(mesa.data, 1)
##or create a empty set of spatio-temporal covariates
processST(mesa.data, NULL)
##by name
processST(mesa.data, "lax.conc.1500")

}
\author{
  Johan Lindstr�m
}
\seealso{
  Other STmodel functions: \code{\link{createCV}},
  \code{\link{createDataMatrix}},
  \code{\link{createSTmodel}},
  \code{\link{dropObservations}},
  \code{\link{estimateBetaFields}},
  \code{\link{loglikeST}}, \code{\link{loglikeSTdim}},
  \code{\link{loglikeSTnaive}}, \code{\link{predictNaive}},
  \code{\link{processLocation}}, \code{\link{updateCovf}},
  \code{\link{updateSTdataTrend}},
  \code{\link{updateTrend}},
  \code{\link{updateTrend.STdata}},
  \code{\link{updateTrend.STmodel}}
}

