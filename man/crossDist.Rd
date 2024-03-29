\name{crossDist}
\alias{crossDist}
\title{Computed the Euclidian Distance Matrix}
\usage{
  crossDist(coord1, coord2 = coord1)
}
\arguments{
  \item{coord1,coord2}{Matrices with the coordinates of
  locations, between which distances are to be computed.}
}
\value{
  A \code{dim(coord1)[1]}-by-\code{dim(coord2)[1]} distance
  matrix.
}
\description{
  Computed the Euclidian distance matrix between to sets of
  points.
}
\examples{
##First create some random locations
x <- rnorm(5)
y <- rnorm(5)

##compute distance matrix
D <- crossDist( cbind(x,y) )

##or distance between different locations
X <- matrix(rnorm(6),3,2)
Y <- rbind(X, matrix(rnorm(8),4,2))
Dcross <- crossDist(X, Y)

##or distances between coordinates in R3
C1 <- matrix(rnorm(9),3,3)
C2 <- matrix(rnorm(12),4,3)
Dcross.R3 <- crossDist(C1, C2)


\dontshow{
  D.alt <- as.matrix(dist(cbind(x,y)))
  if( max(abs(D-D.alt)) > 1e-13 ){
    stop("In 'crossDist', distance matrix not equal")
  }
  if( max(abs(Dcross-as.matrix(dist(Y))[1:3,])) > 1e-13 ){
    stop("In 'crossDist', cross-distance matrix not equal")
  }
  D.alt <- sqrt(rowSums( (matrix(C1[1,], dim(C2)[1], dim(C2)[2], byrow=TRUE) -
                          C2)^2 ))
  if( max(abs(D.alt-Dcross.R3[1,])) > 1e-13 ){
    stop("In 'crossDist', cross-distance, R3, matrix not equal")
  }
}


}
\author{
  Johan Lindstr�m
}
\seealso{
  Other basic linear algebra: \code{\link{blockMult}},
  \code{\link{dotProd}}, \code{\link{invCholBlock}},
  \code{\link{makeCholBlock}}, \code{\link{norm2}},
  \code{\link{solveTriBlock}}, \code{\link{sumLog}},
  \code{\link{sumLogDiag}}

  Other covariance functions: \code{\link{evalCovFuns}},
  \code{\link{makeSigmaB}}, \code{\link{makeSigmaNu}},
  \code{\link{namesCovFuns}}, \code{\link{parsCovFuns}},
  \code{\link{updateCovf}}
}

