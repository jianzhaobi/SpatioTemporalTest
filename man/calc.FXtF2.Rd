\name{calc.FXtF2}
\alias{calc.FXtF2}
\title{Compute Quadratic Form Bewteen Temporal Trends and Sigma B}
\usage{
  calc.FXtF2(F, mat, loc.ind, F2 = F, loc.ind2 = loc.ind)
}
\arguments{
  \item{F,F2}{(number of obs.) - by - (number of temporal
  trends) matrices containing the temporal trends. Usually
  \code{\link{mesa.model}$F}, where
  \code{\link{mesa.model}} is obtained from
  \code{\link{createSTmodel}}.}

  \item{mat}{A block diagonal, with equal size blocks. The
  number of blocks need to equal \code{dim(F)[2]}}

  \item{loc.ind,loc.ind2}{A vector indicating which
  location each row in \code{F} corresponds to, usually \cr
  \code{\link{mesa.model}$obs$idx}.}
}
\value{
  Returns a square matrix with side \code{dim(F)[1]}
}
\description{
  Computes the quadratic form between a sparse matrix
  \code{F} containing the temporal trends and the
  covariance matrix for the beta fields (Sigma_B). Or
  possibly the product between two different \code{F}'s and
  a cross-covariance matrix. \cr\cr See the examples for
  details.
}
\examples{
##create a trend
trend <- cbind(1:5,sin(1:5))
##an index of locations
idx <- c(rep(1:3,3),1:2,2:3)
idx2 <- c(rep(1:2,3),2,2)
##a list of time points for each location/observation
T <- c(rep(1:3,each=3),4,4,5,5)
T2 <- c(rep(1:3,each=2),4,5)

##expand the F matrix to match the locations/times in idx/T.
F <- trend[T,]
F2 <- trend[T2,]

##first column gives time and second location for each observation
cbind(T, idx)
##...and for the second set
cbind(T2, idx2)

##create a cross covariance matrix
C <- makeSigmaB(list(c(1,1),c(1,.5)), crossDist(1:max(idx),1:max(idx2)))

##compute F \%*\% X \%*\% F2'
FXtF2 <- calc.FXtF2(F, C, loc.ind=idx, F2=F2, loc.ind2=idx2)

##which is equivalent to
FXtF2.alt <- expandF(F, idx) \%*\% C \%*\% t( expandF(F2, idx2) )

range(FXtF2 - FXtF2.alt)
\dontshow{
  if( max(abs(FXtF2 - FXtF2.alt)) > 1e-13 ){
    stop("calc.FXtF2: Results not equal")
  }
}
}
\author{
  Johan Lindstr�m and Adam Szpiro
}
\seealso{
  Other block matrix functions: \code{\link{blockMult}},
  \code{\link{calc.FX}}, \code{\link{calc.iS.X}},
  \code{\link{calc.mu.B}}, \code{\link{calc.tFX}},
  \code{\link{calc.tFXF}}, \code{\link{calc.X.iS.X}},
  \code{\link{invCholBlock}}, \code{\link{makeCholBlock}},
  \code{\link{makeSigmaB}}, \code{\link{makeSigmaNu}},
  \code{\link{solveTriBlock}}

  Other temporal trend functions: \code{\link{calc.FX}},
  \code{\link{calc.tFX}}, \code{\link{calc.tFXF}},
  \code{\link{expandF}}
}

