\name{loglikeST}
\alias{loglikeST}
\alias{loglikeSTnaive}
\title{Compute the Log-likelihood for the Spatio-Temporal Model}
\usage{
  loglikeST(x = NULL, STmodel, type = "p", x.fixed = NULL)

  loglikeSTnaive(x = NULL, STmodel, type = "p",
    x.fixed = NULL)
}
\arguments{
  \item{x}{Point at which to compute the log-likelihood,
  should be only \emph{log}-covariance parameters if
  \code{type=c("p","r")} and regression parameters followed
  by \emph{log}-covariance parameters if \code{type="f"}.
  If \code{x=NULL} the function acts as an alias for
  \code{\link{loglikeSTnames}} returning the expected names
  of the input parameters.}

  \item{STmodel}{\code{STmodel} object with the model for
  which to compute the log-likelihood.}

  \item{type}{A single character indicating the type of
  log-likelihood to compute. Valid options are "f", "p",
  and "r", for \emph{full}, \emph{profile} or
  \emph{restricted maximum likelihood} (REML).}

  \item{x.fixed}{Parameters to keep fixed, \code{NA} values
  in this vector is replaced by values from \code{x} and
  the result is used as \code{x}, ie. \cr \code{ x.fixed[
  is.na(x.fixed) ] <- x} \cr \code{ x <- x.fixed }.}
}
\value{
  Returns the log-likelihood of the spatio temporal model.
}
\description{
  Computes the log-likelihood for the spatio-temporal
  model.  \code{loglikeST} uses an optimised version of the
  log-likelihood, while \code{loglikeSTnaive} uses the
  naive (slow) version and is included mainly for testing
  and speed checks.
}
\section{Warning}{
  \code{loglikeSTnaive} may take long to run. However for
  some problems with many locations and short time series
  \code{loglikeSTnaive} could be faster than
  \code{loglikeST}.
}
\examples{
##load the data
data(mesa.model)

##Compute dimensions for the data structure
dim <- loglikeSTdim(mesa.model)

##Find out in which order parameters should be given
loglikeST(NULL, mesa.model)

##Let's create random vectors of values
x <- runif( dim$nparam.cov )
x.all <- runif( dim$nparam )

##Evaluate the log-likelihood for these values
loglikeST(x.all, mesa.model, "f")
loglikeST(x, mesa.model, "p")

}
\author{
  Johan Lindstr�m
}
\seealso{
  Other likelihood functions: \code{\link{loglikeSTGrad}},
  \code{\link{loglikeSTHessian}},
  \code{\link{loglikeSTnaiveGrad}},
  \code{\link{loglikeSTnaiveHessian}}

  Other STmodel functions: \code{\link{createCV}},
  \code{\link{createDataMatrix}},
  \code{\link{createSTmodel}},
  \code{\link{dropObservations}},
  \code{\link{estimateBetaFields}},
  \code{\link{loglikeSTdim}}, \code{\link{predictNaive}},
  \code{\link{processLocation}}, \code{\link{processLUR}},
  \code{\link{processST}}, \code{\link{updateCovf}},
  \code{\link{updateSTdataTrend}},
  \code{\link{updateTrend}},
  \code{\link{updateTrend.STdata}},
  \code{\link{updateTrend.STmodel}}
}

