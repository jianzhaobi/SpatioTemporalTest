\name{norm2}
\alias{dotProd}
\alias{norm2}
\title{Computes Inner Product and Squared 2-norm}
\usage{
  norm2(v1)

  dotProd(v1, v2)
}
\arguments{
  \item{v1,v2}{Two vectors}
}
\value{
  \code{dotProd} returns the inner product of v1 and v2.
  \code{norm2} returns the squared 2-norm of all elements
  in v1.
}
\description{
  \code{dotProd} computes the inner (or dot/scalar) product
  between two vectors. \cr\cr \code{norm2} computes the
  squared 2-norm of all the elements in a matrix or vector.
  \cr\cr If the vectors are of unequal length
  \code{dotProd} will give a warning and then truncates the
  longer vector, discarding any excess elements before the
  computations.
}
\examples{
##Create two vectors of equal length
v1 <- rnorm(10)
v2 <- rnorm(10)

##compute the inner product between the vectors
dotProd(v1,v2)
##or
sum(v1*v2)

##compute the square 2-norm of v1
norm2(v1)
##or
dotProd(v1,v1)
##or
sum(v1*v1)

##If the vectors are of unequal length the longer vector
##gets truncated (with a warning). 
dotProd(v1,c(v2,2))
\dontshow{
  if( abs(dotProd(v1,v2)-sum(v1*v2)) > 1e-10 ){
    stop("dotProd: Results not equal")
  }
  if( (abs(norm2(v1) - dotProd(v1,v1)) > 1e-10) ||
     (abs(norm2(v1) - sum(v1*v1)) > 1e-10) ){
    stop("norm2: Results not equal")
  }
}
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other basic linear algebra: \code{\link{blockMult}},
  \code{\link{crossDist}}, \code{\link{invCholBlock}},
  \code{\link{makeCholBlock}}, \code{\link{solveTriBlock}},
  \code{\link{sumLog}}, \code{\link{sumLogDiag}}
}

