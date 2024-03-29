\name{coef.estimateSTmodel}
\alias{coef.estimateSTmodel}
\title{Returns estimated parameters (and uncertaintes)}
\usage{
  \method{coef}{estimateSTmodel} (object,
    pars = c("all", "cov", "reg"), ...)
}
\arguments{
  \item{object}{\code{estimateSTmodel} object from which to
  extract estimated parameters.}

  \item{pars}{One of "cov", "reg", "all"; which parameters
  to extract.}

  \item{...}{Ignored additional arguments.}
}
\value{
  Estimated parameters.
}
\description{
  \code{\link[stats:coef]{coef}} method for class
  \code{estimateSTmodel}.
}
\examples{
##load data
  data(est.mesa.model)
  ##extract all parameters
  coef(est.mesa.model)
  ##extract only covariance parameters
  coef(est.mesa.model, pars="cov")
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other estimateSTmodel methods: \code{\link{estimate}},
  \code{\link{estimate.STmodel}},
  \code{\link{print.estimateSTmodel}}
}

