\name{parsCovFuns}
\alias{parsCovFuns}
\title{Parameter Names for Covariance Function(s)}
\usage{
  parsCovFuns(type = namesCovFuns(), list = FALSE)
}
\arguments{
  \item{type}{Name(s) of covariance functions, see
  \code{\link{namesCovFuns}}.}

  \item{list}{Always return a list (if FALSE returns a
  vector if possible)}
}
\value{
  Character vector with parameter names (excluding the
  nugget), \code{NULL} if the name is unknown. Returns a
  list if type contains more than one element.
}
\description{
  Provides a list of parameter names for the given
  covariance function(s), excluding the nugget which is
  added elsewhere.
}
\examples{
##all possible parameters
  parsCovFuns()
  ##just one covariance function
  parsCovFuns("exp")
  ##non existant covariance function
  parsCovFuns("bad.name")
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other covariance functions: \code{\link{crossDist}},
  \code{\link{evalCovFuns}}, \code{\link{makeSigmaB}},
  \code{\link{makeSigmaNu}}, \code{\link{namesCovFuns}},
  \code{\link{updateCovf}}
}

