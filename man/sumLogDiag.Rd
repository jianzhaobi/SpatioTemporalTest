\name{sumLogDiag}
\alias{sumLog}
\alias{sumLogDiag}
\title{Sum the Logarithm of (Diagonal) Elements}
\usage{
  sumLogDiag(mat)

  sumLog(v)
}
\arguments{
  \item{mat}{A square matrix (preferably a Cholesky
  factor).}

  \item{v}{A vector}
}
\value{
  Sum of the logarithm of the (diagonal) elements.
}
\description{
  Computes the sum of the logarithm of the diagonal
  elements in a matrix, or of elements in a vector. This
  corresponds to the logarithm of the determinant for a
  Cholesky factor.  Behaviour is undefined for any elements
  that are <=0.
}
\examples{
## Create a covariance matrix
S <- cbind(c(2,1),c(1,2))
## compute Cholesky factor
R <- chol(S)
## compute determinant
log(det(R))
## compare with sum of the logarithm of diagonal elements
sumLogDiag(R)
##or using sumLog (usefull e.g. for the Matrix-class)
sumLog(diag(R))

\dontshow{
  if( abs(log(det(R)) - sumLogDiag(R)) > 1e-10 ){
    stop("sumLogDiag: Results not equal")
  }
  if( abs(sumLog(diag(R)) - sumLogDiag(R)) > 1e-10 ){
    stop("sumLog: Results not equal")
  }
}

}
\author{
  Johan Lindstr�m
}
\seealso{
  Other basic linear algebra: \code{\link{blockMult}},
  \code{\link{crossDist}}, \code{\link{dotProd}},
  \code{\link{invCholBlock}}, \code{\link{makeCholBlock}},
  \code{\link{norm2}}, \code{\link{solveTriBlock}}
}

