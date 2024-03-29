\name{blockMult}
\alias{blockMult}
\title{Multiplication of Block Diagonal Matrix and Vector}
\usage{
  blockMult(mat, X, n.blocks = 1,
    block.sizes = rep(dim(mat)[1]/n.blocks, n.blocks))
}
\arguments{
  \item{mat}{A block diagonal, square matrix.}

  \item{X}{Vector or matrix to multiply by \code{mat};
  \code{length(X)} needs to be a multiple of
  \code{dim(mat)[1]}.}

  \item{n.blocks}{Number of diagonal blocks in \code{mat}
  (or \code{R}).  Defaults to 1 (i.e. a full matrix) if
  neither \code{n.blocks} nor \code{block.sizes} given,
  o.w. it defaults to \code{length(block.sizes)}).}

  \item{block.sizes}{A vector of length \code{n.blocks}
  with the size of each of the diagonal blocks. If not
  given it will assume equal-sized blocks.}
}
\value{
  Returns mat * X.
}
\description{
  Computes the matrix product between a block diagonal
  square matrix and a column vector (or matrix).
}
\examples{
#create a matrix
mat <- cbind(c(1,0,0), c(0,2,1), c(0,1,2))
#define the number of blocks and block sizes
block.sizes <- c(1,2)
n.blocks <- length(block.sizes)

#define a X vector
X <- matrix(c(1,2,3,1,1,1), 3, 2)

#compute mat \%*\% X
blockMult(mat, X, n.blocks, block.sizes)
#or the old fashioned way
mat \%*\% X
\dontshow{
  if( max(abs(blockMult(mat, X, n.blocks, block.sizes) -
              (mat \%*\% X))) > 1e-13 ){
    stop("blockMult: Results not equal")
  }
}

}
\author{
  Johan Lindstr�m
}
\seealso{
  Other basic linear algebra: \code{\link{crossDist}},
  \code{\link{dotProd}}, \code{\link{invCholBlock}},
  \code{\link{makeCholBlock}}, \code{\link{norm2}},
  \code{\link{solveTriBlock}}, \code{\link{sumLog}},
  \code{\link{sumLogDiag}}

  Other block matrix functions: \code{\link{calc.FX}},
  \code{\link{calc.FXtF2}}, \code{\link{calc.iS.X}},
  \code{\link{calc.mu.B}}, \code{\link{calc.tFX}},
  \code{\link{calc.tFXF}}, \code{\link{calc.X.iS.X}},
  \code{\link{invCholBlock}}, \code{\link{makeCholBlock}},
  \code{\link{makeSigmaB}}, \code{\link{makeSigmaNu}},
  \code{\link{solveTriBlock}}
}

