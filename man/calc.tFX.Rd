\name{calc.tFX}
\alias{calc.tFX}
\title{Compute Matrix Product Bewteen Temporal Trends and a Matrix}
\usage{
  calc.tFX(F, X, loc.ind, n.loc = max(loc.ind))
}
\arguments{
  \item{F}{A (number of obs.) - by - (number of temporal
  trends) matrix containing the temporal trends. Usually
  \code{\link{mesa.model}$F}, where
  \code{\link{mesa.model}} is obtained from
  \code{\link{createSTmodel}}.}

  \item{X}{A vector or matrix; needs to be a multiple of
  \code{dim(F)[1]}.}

  \item{loc.ind}{A vector indicating which location each
  row in \code{F} corresponds to, usually \cr
  \code{\link{mesa.model}$obs$idx}.}

  \item{n.loc}{Number of locations.}
}
\value{
  Returns a matrix of size
  \code{n.loc*dim(F)[2]}-by-code{n.x}.
}
\description{
  Computes the matrix products between the transpose of a
  sparse matrix \code{F} containing temporal trends the and
  a vector/matrix. \cr\cr See the examples for details.
}
\examples{
##This starts with a couple of simple examples, more elaborate examples
##with real data can be found further down.

##create a trend
trend <- cbind(1:5,sin(1:5))
##an index of locations
idx <- c(rep(1:3,3),1:2,2:3)
##a list of time points for each location/observation
T <- c(rep(1:3,each=3),4,4,5,5)
##create a random observations matrix
obs <- rnorm(length(T))

##expand the F matrix to match the locations/times in idx/T.
F <- trend[T,]
F
##compute tF \%*\% obs
tFobs <- calc.tFX(F, obs, idx)
##or posibly expanded if we have unobserved, trailing locations
tFobs.exp <- calc.tFX(F, obs, idx, 5)

##alternatievly this can be computed as observtions for each location
##multiplied by the trend function at the corresponding time points.
tFobs.alt <- t(expandF(F, idx)) \%*\% obs

##compare results
print( cbind(tFobs,tFobs.alt) )
\dontshow{
  if( max(abs(tFobs-tFobs.alt)) > 1e-13 ){
    stop("calc.tFX 1a: Results not equal")
  }
  if( length(tFobs.exp)!=(dim(F)[2]*5) ){
    stop("calc.tFX 1b: Dimension missmatch")
  }
}

##some examples using real data
data(mesa.model)

##Some information about the size(s) of the model.
dim <- loglikeSTdim(mesa.model)

##compute F' \%*\% obs
tFobs <- calc.tFX(mesa.model$F, mesa.model$obs$obs, mesa.model$obs$idx)

##The resulting matrix contains 75 elements (3 temporal trend at 25
##sites). The first element are the observations at the first site
##multiplied by the constant temporal trend, e.g.
print( tFobs[1] )
print( sum(mesa.model$obs$obs[mesa.model$obs$idx==1]) )
\dontshow{
  if( abs(sum(mesa.model$obs$obs[mesa.model$obs$idx==1]) - tFobs[1]) > 1e-10 ){
    stop("calc.tFX - real data 1: Results not equal")
  }
}

##The 27:th element are the observations at the second site (27-25)
##multiplied by the first temporal trend (second element in F)
print( tFobs[dim$n.obs+2] )
print( sum(mesa.model$obs$obs[mesa.model$obs$idx==2] *
           mesa.model$F[mesa.model$obs$idx==2,2]))
\dontshow{
  if( abs(sum(mesa.model$obs$obs[mesa.model$obs$idx==2] *
              mesa.model$F[mesa.model$obs$idx==2,2]) -
          tFobs[dim$n.obs+2]) > 1e-10 ){
    stop("calc.tFX - real data 2: Results not equal")
  }
}
}
\author{
  Johan Lindstr�m and Adam Szpiro
}
\seealso{
  Other block matrix functions: \code{\link{blockMult}},
  \code{\link{calc.FX}}, \code{\link{calc.FXtF2}},
  \code{\link{calc.iS.X}}, \code{\link{calc.mu.B}},
  \code{\link{calc.tFXF}}, \code{\link{calc.X.iS.X}},
  \code{\link{invCholBlock}}, \code{\link{makeCholBlock}},
  \code{\link{makeSigmaB}}, \code{\link{makeSigmaNu}},
  \code{\link{solveTriBlock}}

  Other temporal trend functions: \code{\link{calc.FX}},
  \code{\link{calc.FXtF2}}, \code{\link{calc.tFXF}},
  \code{\link{expandF}}
}

