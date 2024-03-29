\name{makeSigmaNu}
\alias{makeSigmaNu}
\title{Create Block Covariance Matrix (Unequal Block Sizes)}
\usage{
  makeSigmaNu(pars, dist, type = "exp", nugget = 0,
    random.effect = 0,
    symmetry = dim(dist)[1] == dim(dist)[2],
    blocks1 = dim(dist)[1], blocks2 = dim(dist)[2],
    ind1 = 1:dim(dist)[1], ind2 = 1:dim(dist)[2],
    ind2.to.1 = 1:dim(dist)[2], sparse = FALSE)
}
\arguments{
  \item{pars}{Vector of parameters, as suggested by
  \code{parsCovFuns}.}

  \item{dist}{Distance matrix.}

  \item{type}{Name of the covariance function to use, see
  \code{\link{namesCovFuns}}.}

  \item{nugget}{A value of the nugget or a vector of length
  \code{dim(dist)[1]} giving (possibly) location specific
  nuggets.}

  \item{random.effect}{A constant variance to add to the
  covariance matrix, can be interpereted as either and
  partial sill with infinite range or as a random effect
  with variance given by \code{random.effect} for the mean
  value.}

  \item{symmetry}{\code{TRUE}/\code{FALSE} flag if the
  \code{dist} matrix is symmetric. If also
  \code{ind1==ind2} and \code{blocks1==blocks2} the
  resulting covariance matrix will be symmetric.}

  \item{blocks1,blocks2}{Vectors with the size(s) of each
  of the diagonal blocks, usually
  \code{\link{mesa.model}$nt}. If \code{symmetry=TRUE} and
  then \code{blocks2} defaults to \code{blocks1} if
  missing.}

  \item{ind1,ind2}{Vectors indicating the location of each
  element in the covariance matrix, used to index the
  \code{dist}-matrix to determine the distance between
  locations, usually \code{\link{mesa.model}$obs$idx}. If
  \code{symmetry=TRUE} and then \code{ind2} defaults to
  \code{ind1} if missing.}

  \item{ind2.to.1}{Vectors, that for each index along the
  second dimension, \code{ind2}, gives a first dimension
  index, \code{ind1}, used only if \code{symmetry=FALSE} to
  determine which covariances should have an added nugget
  (collocated sites).}

  \item{sparse}{If \code{TRUE}, return a block diagonal
  sparse matrix, see \code{\link[Matrix:bdiag]{bdiag}}.}
}
\value{
  Block covariance matrix of size
  \code{length(ind1)}-by-\code{length(ind2)}.
}
\description{
  Function that creates a block covariance matrix with
  unequally sized blocks. Used to construct the Sigma_nu
  matrix.
}
\examples{
##First create some random locations
x <- rnorm(5)
y <- rnorm(5)

##compute distance matrix
D <- crossDist( cbind(x,y) )

#a vector of locations
I <- c(1,2,3,1,4,4,3,2,1,1)
T <- c(1,1,1,2,2,3,3,3,3,4)

##create a block diagonal matrix consisting of four parts with
##exponential covariance.
sigma.nu <- makeSigmaNu(c(.4,2), D, "exp", nugget=0.1,
                        blocks1 = c(3,2,4,1), ind1 = I)
##and cross covariance
sigma.nu.c <- makeSigmaNu(c(.4,2), D, "exp", nugget=0.1,
                          blocks1 = c(3,2,4,1), ind1 = I, 
                          blocks2 = c(0,0,3,1), ind2 = I[7:10])

##compare the cross-covariance with the relevant part of sigma.nu
range(sigma.nu.c-sigma.nu[,7:10])
\dontshow{
  if( max(abs(sigma.nu.c-sigma.nu[,7:10])) > 1e-13 ){
    stop("make.sigma.nu.cross.cov 1: Results not equal")
  }
  sigma.nu.s <- makeSigmaNu(c(.4,2), D, "exp", nugget=0.1,
                            blocks1 = c(3,2,4,1), ind1 = I,
                            sparse=TRUE)
  sigma.nu.c.s <- makeSigmaNu(c(.4,2), D, "exp", nugget=0.1,
                              blocks1 = c(3,2,4,1), ind1 = I, 
                              blocks2 = c(0,0,3,1), ind2 = I[7:10],
                              sparse=TRUE)
  if( max(abs(sigma.nu.s-sigma.nu)) > 1e-13 ){
    stop("make.sigma.nu sparse not equal")
  }
  if( max(abs(sigma.nu.c.s-sigma.nu.c)) > 1e-13 ){
    stop("make.sigma.nu sparse/cross not equal")
  }
}
##an alternative showing the use of loc.ind2.to.1
sigma.nu.c <- makeSigmaNu(c(.4,2), D[,4:3], "exp", nugget=0.1,
                          blocks1 = c(3,2,4,1), ind1 = I, 
                          blocks2 = c(0,0,2,0), ind2 = 1:2,
                          ind2.to.1=4:3)
##compare the cross-covariance with the relevant part of sigma.nu
range(sigma.nu.c-sigma.nu[,6:7])
\dontshow{
  if( max(abs(sigma.nu.c-sigma.nu[,6:7])) > 1e-13 ){
    stop("make.sigma.nu.cross.cov 2: Results not equal")
  }
}
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other block matrix functions: \code{\link{blockMult}},
  \code{\link{calc.FX}}, \code{\link{calc.FXtF2}},
  \code{\link{calc.iS.X}}, \code{\link{calc.mu.B}},
  \code{\link{calc.tFX}}, \code{\link{calc.tFXF}},
  \code{\link{calc.X.iS.X}}, \code{\link{invCholBlock}},
  \code{\link{makeCholBlock}}, \code{\link{makeSigmaB}},
  \code{\link{solveTriBlock}}

  Other covariance functions: \code{\link{crossDist}},
  \code{\link{evalCovFuns}}, \code{\link{makeSigmaB}},
  \code{\link{namesCovFuns}}, \code{\link{parsCovFuns}},
  \code{\link{updateCovf}}
}

