\name{loglikeSTdim}
\alias{loglikeSTdim}
\title{Dimensions of the STmodel Structure}
\usage{
  loglikeSTdim(STmodel)
}
\arguments{
  \item{STmodel}{\code{STmodel} object for which dimensions
  are to be computed.}
}
\value{
  list containing: \item{T}{Number of observation times.}
  \item{m}{Number of temporal basis functions, including
  the intercept.} \item{n}{Number of distinct locations in
  the data.} \item{n.obs}{Number of observed locations.}
  \item{p}{vector of length \code{m}; number of geographic
  covariates for each temporal basis functions.}
  \item{L}{Number of spatio-temporal covariates}
  \item{npars.beta.covf}{vector of length \code{m}; number
  of parameters for each covariance-function for the
  beta-fields.} \item{npars.beta.tot}{vector of length
  \code{m}; total number of parameters for each
  beta-fields, including nugget(s).}
  \item{npars.nu.covf,npars.nu.tot}{number of parameters
  for the nu-field, same distinction as above.}
  \item{nparam}{Total number of parameters, including
  regression parameters.} \item{nparam.cov}{Number of
  covariance parameters.}
}
\description{
  Function that computes the dimension of several objects
  in a \code{STmodel} object.
}
\examples{
##load the data
data(mesa.model)

##compute dimensions for the data structure
loglikeSTdim(mesa.model)
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other likelihood utility functions:
  \code{\link{calc.iS.X}}, \code{\link{calc.mu.B}},
  \code{\link{calc.X.iS.X}},
  \code{\link{loglikeSTgetPars}},
  \code{\link{loglikeSTnames}}

  Other STmodel functions: \code{\link{createCV}},
  \code{\link{createDataMatrix}},
  \code{\link{createSTmodel}},
  \code{\link{dropObservations}},
  \code{\link{estimateBetaFields}},
  \code{\link{loglikeST}}, \code{\link{loglikeSTnaive}},
  \code{\link{predictNaive}},
  \code{\link{processLocation}}, \code{\link{processLUR}},
  \code{\link{processST}}, \code{\link{updateCovf}},
  \code{\link{updateSTdataTrend}},
  \code{\link{updateTrend}},
  \code{\link{updateTrend.STdata}},
  \code{\link{updateTrend.STmodel}}
}

