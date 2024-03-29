\name{makeCholBlock}
\alias{invCholBlock}
\alias{makeCholBlock}
\alias{solveTriBlock}
\title{Computations for Block Diagonal Matrices}
\usage{
  makeCholBlock(mat, n.blocks = 1,
    block.sizes = rep(dim(mat)[1]/n.blocks, n.blocks))

  invCholBlock(R, n.blocks = 1,
    block.sizes = rep(dim(R)[1]/n.blocks, n.blocks))

  solveTriBlock(R, B, n.blocks = 1,
    block.sizes = rep(dim(R)[1]/n.blocks, n.blocks),
    transpose = FALSE)
}
\arguments{
  \item{mat}{A block diagonal, square, positive definite
  matrix.}

  \item{R}{Upper right block diagonal Cholesky factor. The
  output from \code{\link[base:chol]{chol}} or \cr
  \code{makeCholBlock}.}

  \item{n.blocks}{Number of diagonal blocks in \code{mat}
  (or \code{R}).  Defaults to 1 (i.e. a full matrix) if
  neither \code{n.blocks} nor \code{block.sizes} given,
  o.w. it defaults to \code{length(block.sizes)}).}

  \item{block.sizes}{A vector of length \code{n.blocks}
  with the size of each of the diagonal blocks. If not
  given it will assume equal size blocks.}

  \item{B}{Vector or matrix containg the right hand side of
  the equations system to be solved; needs to be a multiple
  of \code{dim(R)[1]}.}

  \item{transpose}{Transpose \code{R} before solving the
  equation system.  Controls if we solve the equations
  system given by R*x = B or R'*x=B.}
}
\value{
  \code{makeCholBlock} gives the Cholesky factor and
  \code{invCholBlock} gives the inverse of the matrix
  \code{mat}.  \code{solveTriBlock} gives to answer to the
  equation system.
}
\description{
  Provides block diagonal version of the base package
  functions \code{\link[base:chol]{chol}},
  \code{\link[base:chol2inv]{chol2inv}}, and
  \code{\link[base:backsolve]{backsolve}}. \cr\cr Computes
  the Cholesky factor, the matrix inverse and solves matrix
  equation systems for block diagonal matrices.
}
\details{
  \code{makeCholBlock} computes the Cholesky factor of a
  block diagonal matrix using the block diagonal structure
  to speed up computations.

  \code{invCholBlock} uses the Cholesky factor from
  \code{makeCholBlock} to compute the inverse of
  \code{mat}.

  \code{solveTriBlock} solves equation systems based on the
  Cholesky factor, using the block diagonal structure to
  speed up computations (c.f. \code{\link{backsolve}}). The
  function solves equations of the form R*x = B, and R'*x =
  B with respect to x, where the transpose is controlled by
  the parameter \code{transpose}. Aplying the function
  twice solves mat*x=B, see the examples.

  For all three functions the block diagonal structure of
  the matrix is defined by two input variables, the number
  of blocks \code{n.blocks}, and the size of each block
  \code{block.sizes}. The size of the matrices must match
  the total number of blocks, i.e. \code{sum(block.sizes)}
  \emph{must} equal \code{dim(mat)}.

  The functions can be used for full matrices by setting
  the number of blocks to 1.
}
\examples{
##create a matrix
mat <- cbind(c(1,0,0),c(0,2,1),c(0,1,2))
##define the number of blocks and block sizes
block.sizes <- c(1,2)
n.blocks <- length(block.sizes)

##Compute the Cholesky factor
R <- makeCholBlock(mat, n.blocks, block.sizes)
##and the matrix inverse
i.mat <- invCholBlock(R, n.blocks, block.sizes)
##compare to the alternative
i.mat-solve(mat)
\dontshow{
  if( max(abs(R-chol(mat))) > 1e-10 ){
    stop("makeCholBlock: Results not equal")
  }
  if( max(abs(i.mat-solve(mat))) > 1e-10 ){
    stop("invCholBlock: Results not equal")
  }
}
##define a B vector
B <- c(1,2,3)
##solve the equation system (we need n.x since B is not a matrix)
x1 <- solveTriBlock(R, B, n.blocks, block.sizes, tr=TRUE)
x2 <- solveTriBlock(R, x1, n.blocks, block.sizes, tr=FALSE)
print(x2)
##compare to the alternative
print(solve(mat,B))
range(x2-solve(mat,B))
\dontshow{
  if( max(abs(x2-solve(mat,B))) > 1e-10 ){
    stop("solveTriBlock: Results not equal")
  }
}
##compute the quadratic form B'*i.mat*B
norm2(x1)
##compare to the alternative
t(B) \%*\% i.mat \%*\% B
\dontshow{
  if( abs(norm2(x1) - t(B) \%*\% i.mat \%*\% B) > 1e-10 ){
    stop("solveTriBlock: Results not equal for norm")
  }
}

}
\author{
  Johan Lindstr�m and Adam Szpiro
}
\seealso{
  Other basic linear algebra: \code{\link{blockMult}},
  \code{\link{crossDist}}, \code{\link{dotProd}},
  \code{\link{norm2}}, \code{\link{sumLog}},
  \code{\link{sumLogDiag}}

  Other block matrix functions: \code{\link{blockMult}},
  \code{\link{calc.FX}}, \code{\link{calc.FXtF2}},
  \code{\link{calc.iS.X}}, \code{\link{calc.mu.B}},
  \code{\link{calc.tFX}}, \code{\link{calc.tFXF}},
  \code{\link{calc.X.iS.X}}, \code{\link{makeSigmaB}},
  \code{\link{makeSigmaNu}}
}

