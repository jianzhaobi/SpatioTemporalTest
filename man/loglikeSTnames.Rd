\name{loglikeSTnames}
\alias{loglikeSTnames}
\title{Create Names for Log-likelihood Parameters for STmodel objects}
\usage{
  loglikeSTnames(STmodel, all = TRUE)
}
\arguments{
  \item{STmodel}{\code{STmodel} object for which parmeter
  names are to be computed.}

  \item{all}{compute all parameter names (regression and
  covariance) or only covariance parameters.}
}
\value{
  Returns names of the parameters expected by the
  log-likelihood functions. Regerssion parameter names
  start with gamma/alpha (spatio-temporal/geographic
  covariate), followed by name of beta-field, and the name
  of covariate. The covariance parameters follow, log
  (reminder that parameter is log-scale), covariance
  parameter name, name of field, type of covariance
  function.
}
\description{
  Function that creates a character vector with names for
  the parameters expected by log-likelihood functions.
  Names are created by extracting names from the
  \code{STmodel} structure.
}
\examples{
##load the data
data(mesa.model)

##Find out in which order parameters should be given
loglikeSTnames(mesa.model)
##...and for only the covariance parameters.
loglikeSTnames(mesa.model, FALSE)
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other likelihood utility functions:
  \code{\link{calc.iS.X}}, \code{\link{calc.mu.B}},
  \code{\link{calc.X.iS.X}}, \code{\link{loglikeSTdim}},
  \code{\link{loglikeSTgetPars}}
}

