\name{calc.mu.B}
\alias{calc.iS.X}
\alias{calc.mu.B}
\alias{calc.X.iS.X}
\title{Matrix Multiplication with Block Matrices}
\usage{
  calc.mu.B(X, alpha)

  calc.iS.X(X, iS)

  calc.X.iS.X(X, iS.X)
}
\arguments{
  \item{X}{A list of \code{m} matrices with which to form
  the block matrix; each matrix should be \code{p[i]} - by
  - \code{n}.}

  \item{alpha}{A list of \code{m} vectors, with the i:th
  vector being of length \code{p[i]}.}

  \item{iS}{A block diagonal, square matrix, with \code{dm}
  blocks each of size \code{n} - by - \code{dn}.}

  \item{iS.X}{Matrix containing the product of \code{iS}
  and \code{X}. Output from \code{calc.iS.X}.}
}
\value{
  matrix containing iS*X, X'*iS*X, or X*alpha.
}
\description{
  Computes either the product between a block diagonal,
  square matrix \code{iS} and a block matrix \code{X}; the
  quadratic form of a block diagonal, square matrix,
  \code{t(X)*iS*X}; or a block matrix multiplied by a
  vector, \code{X*alpha}.
}
\examples{
## Create a block diagonal matrix, ...
iS <- rbind(c(2,1,0,0), c(1,3,0,0),
            c(0,0,3,2), c(0,0,2,4))
## ... a block matrix ...
X <- list(matrix(c(1,2)), matrix(c(2,2,3,4),2,2))
## ... with alternative form, ...
Xt <- rbind(cbind(X[[1]], matrix(0,2,2)),
            cbind(matrix(0,2,1), X[[2]]))
## ... and a vector alpha.
alpha <- list(c(1), c(-2,1))

## Compute iS * X
iS.X <- calc.iS.X(X, iS)
## or
iS \%*\% Xt
\dontshow{
  if( max(abs(iS.X - (iS \%*\% Xt))) > 1e-13 ){
    stop("calc.iS.X: Results not equal")
  }
}
## Compute X'* iS * X
calc.X.iS.X(X, iS.X)
## or
t(Xt) \%*\% iS \%*\% Xt
\dontshow{
  if( max(abs(calc.X.iS.X(X, iS.X) - (t(Xt) \%*\% iS \%*\% Xt))) > 1e-13 ){
    stop("calc.X.iS.X: Results not equal")
  }
}
## Compute X* alpha
calc.mu.B(X, alpha)
## or
cbind(X[[1]] \%*\% alpha[[1]], X[[2]] \%*\% alpha[[2]])
\dontshow{
  if( max(abs(cbind(X[[1]] \%*\% alpha[[1]], X[[2]] \%*\% alpha[[2]]) -
              calc.mu.B(X, alpha))) > 1e-13 ){
    stop("calc.mu.B: Results not equal")
  }
}
}
\author{
  Johan Lindstr�m and Adam Szpiro
}
\seealso{
  Other block matrix functions: \code{\link{blockMult}},
  \code{\link{calc.FX}}, \code{\link{calc.FXtF2}},
  \code{\link{calc.tFX}}, \code{\link{calc.tFXF}},
  \code{\link{invCholBlock}}, \code{\link{makeCholBlock}},
  \code{\link{makeSigmaB}}, \code{\link{makeSigmaNu}},
  \code{\link{solveTriBlock}}

  Other likelihood utility functions:
  \code{\link{loglikeSTdim}},
  \code{\link{loglikeSTgetPars}},
  \code{\link{loglikeSTnames}}
}

