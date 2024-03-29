\name{expandF}
\alias{expandF}
\title{Expand F}
\usage{
  expandF(F, loc.ind, n.loc = max(loc.ind), sparse = TRUE)
}
\arguments{
  \item{F}{A (number of obs.) - by - (number of temporal
  trends) matrix containing the temporal trends. Usually
  \code{\link{mesa.model}$F}, where
  \code{\link{mesa.model}} is obtained from
  \code{\link{createSTmodel}}.}

  \item{loc.ind}{A vector indicating which location each
  row in \code{F} corresponds to, usually \cr
  \code{\link{mesa.model}$obs$idx}.}

  \item{n.loc}{Number of locations.}

  \item{sparse}{Should the returned matrix be sparse (uses
  the Matrix-package, see
  \code{\link[Matrix:sparseMatrix]{sparseMatrix}})}
}
\value{
  Returns the expanded F, a
  \code{dim(F)[1]}-by-\code{n.loc*dim(F)[2]} matrix
}
\description{
  Expands the temporal trends in F to a full matrix (with
  lots of zeros). Mainly used for testing, and illustration
  in examples.
}
\examples{
##create a trend
trend <- cbind(1:5,sin(1:5))
##an index of locations
idx <- c(rep(1:3,3),1:2,2:3)
##a list of time points for each location/observation
T <- c(rep(1:3,each=3),4,4,5,5)

##expand the F matrix to match the locations/times in idx/T.
F <- trend[T,]

##compute the expanded matrix
expandF(F, idx)

##compute the expanded matrix, assuming additional locations
expandF(F, idx, 5)

##or as a full matrix
expandF(F, idx, 5, sparse=FALSE)

\dontshow{
  if( abs(max(expandF(F, idx)-expandF(F, idx, sparse=FALSE)))>1e-13 ){
    stop("Error in 'expandF', full not equal")
  }
  if( abs(max(expandF(F, idx, 5)-expandF(F, idx, 5, sparse=FALSE)))>1e-13 ){
    stop("Error in 'expandF', expanded full not equal")
  }
}
}
\author{
  Johan Lindstr�m and Adam Szpiro
}
\seealso{
  Other temporal trend functions: \code{\link{calc.FX}},
  \code{\link{calc.FXtF2}}, \code{\link{calc.tFX}},
  \code{\link{calc.tFXF}}
}

