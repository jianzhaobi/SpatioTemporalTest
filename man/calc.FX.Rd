\name{calc.FX}
\alias{calc.FX}
\title{Compute Matrix Product Bewteen Temporal Trends and a LUR components}
\usage{
  calc.FX(F, LUR, loc.ind)
}
\arguments{
  \item{F}{A (number of obs.) - by - (number of temporal
  trends) matrix containing the temporal trends. Usually
  \code{\link{mesa.model}$F}, where
  \code{\link{mesa.model}} is obtained from
  \code{\link{createSTmodel}}.}

  \item{LUR}{A list of matrices, usually
  \code{\link{mesa.model}$X}. Each matrix in the list
  should have the same number of rows, but the number of
  columns may vary.}

  \item{loc.ind}{A vector indicating which location each
  row in \code{F} corresponds to, usually \cr
  \code{\link{mesa.model}$obs$idx}.}
}
\value{
  Returns a matrix
}
\description{
  Computes the matrix products between a sparse matrix
  \code{F} containing the temporal trends and a list of
  land-use-regression components. \cr\cr See the examples
  for details.
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
##create a list of matrices
X <- list(matrix(1,3,1), matrix(runif(6),3,2))

##expand the F matrix to match the locations/times in idx/T.
F <- trend[T,]

##compute F \%*\% X
FX <- calc.FX(F, X, idx)

##alternatievly this can be computed as block matrix
##times each (expanded) temporal trend
Fexp <- expandF(F, idx)
##Fexp is a sparse 'Matrix', we need to use cBind.
FX.alt <- cBind(Fexp[,1:3] \%*\% X[[1]], Fexp[,4:6] \%*\% X[[2]])

##compare results
\dontshow{
  if( max(abs(FX-FX.alt)) > 1e-13 ){
    stop("calc.FX 1: Results not equal")
  }
}


##some examples using real data
data(mesa.model)

##Some information about the size(s) of the model.
dim <- loglikeSTdim(mesa.model)

##compute F \%*\% X
FX <- calc.FX(mesa.model$F, mesa.model$LUR, mesa.model$obs$idx)

##The resulting matrix is
##(number of time points) - by - (number of land use covariates)
##where the number of land use covariates are computed over all the
##two + intercept temporal trends.
##Each column contains the temporal trend for the observations
##multiplied by the corresponding LUR-covariate
par(mfrow=c(3,1))
plot(FX[,2])
points(mesa.model$LUR[[1]][mesa.model$obs$idx,2] * mesa.model$F[,1], col=2, pch=3)

plot(FX[,dim$p[1]+1])
points(mesa.model$LUR[[2]][mesa.model$obs$idx,1] *
       mesa.model$F[,2], col=2, pch=3)

plot(FX[,dim$p[1]+dim$p[2]+2])
points(mesa.model$LUR[[3]][mesa.model$obs$idx,2] *
       mesa.model$F[,3], col=2, pch=3)

##If the regression parameters, alpha, are known (or estimated)
##The intercept part of the model is given by FX \%*\% alpha
\dontshow{
  if( max(abs(FX[,2] - mesa.model$LUR[[1]][mesa.model$obs$idx,2] *
              mesa.model$F[,1])) > 1e-10){
    stop("calc.FX - real data 1: Results not equal")
  }
  if( max(abs(FX[,dim$p[1]+1] - mesa.model$F[,2] *
              mesa.model$LUR[[2]][mesa.model$obs$idx,1])) > 1e-10){
    stop("calc.FX - real data 2: Results not equal")
  }
  if( max(abs(FX[,dim$p[1]+dim$p[2]+2] - mesa.model$F[,3] *
              mesa.model$LUR[[3]][mesa.model$obs$idx,2])) > 1e-10){
    stop("calc.FX - real data 2: Results not equal")
  }
}
}
\author{
  Johan Lindstr�m and Adam Szpiro
}
\seealso{
  Other block matrix functions: \code{\link{blockMult}},
  \code{\link{calc.FXtF2}}, \code{\link{calc.iS.X}},
  \code{\link{calc.mu.B}}, \code{\link{calc.tFX}},
  \code{\link{calc.tFXF}}, \code{\link{calc.X.iS.X}},
  \code{\link{invCholBlock}}, \code{\link{makeCholBlock}},
  \code{\link{makeSigmaB}}, \code{\link{makeSigmaNu}},
  \code{\link{solveTriBlock}}

  Other temporal trend functions: \code{\link{calc.FXtF2}},
  \code{\link{calc.tFX}}, \code{\link{calc.tFXF}},
  \code{\link{expandF}}
}

