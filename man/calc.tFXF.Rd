\name{calc.tFXF}
\alias{calc.tFXF}
\title{Compute Quadratic Form Bewteen Temporal Trends and Sigma nu}
\usage{
  calc.tFXF(F, mat, loc.ind, n.blocks = 1,
    block.sizes = rep(dim(mat)[1]/n.blocks, n.blocks),
    n.loc = max(loc.ind))
}
\arguments{
  \item{F}{A (number of obs.) - by - (number of temporal
  trends) matrix containing the temporal trends. Usually
  \code{\link{mesa.model}$F}, where
  \code{\link{mesa.model}} is obtained from
  \code{\link{createSTmodel}}.}

  \item{mat}{A block diagonal, square matrix.}

  \item{loc.ind}{A vector indicating which location each
  row in \code{F} corresponds to, usually \cr
  \code{\link{mesa.model}$obs$idx}.}

  \item{n.blocks}{Number of diagonal blocks in \code{mat}
  (or \code{R}).  Defaults to 1 (i.e. a full matrix) if
  neither \code{n.blocks} nor \code{block.sizes} given,
  o.w. it defaults to \code{length(block.sizes)}).}

  \item{block.sizes}{A vector of length \code{n.blocks}
  with the size of each of the diagonal blocks. If not
  given it will assume equal size blocks.}

  \item{n.loc}{Number of locations.}
}
\value{
  Returns a square matrix with side \code{dim(F)[2]*n.loc}
}
\description{
  Computes the quadratic form between a sparse matrix
  \code{F} containing the temporal trends and the
  covariance matrix for the residual fields (Sigma_nu)
  \cr\cr See the examples for details.
}
\examples{
##create a trend
trend <- cbind(1:5,sin(1:5))
##an index of locations
idx <- c(rep(1:3,3),1:2,2:3)
##a list of time points for each location/observation
T <- c(rep(1:3,each=3),4,4,5,5)

##expand the F matrix to match the locations/times in idx/T.
F <- trend[T,]

##create a covariance matrix for locations and each of 
C <- makeSigmaNu(c(1,1), as.matrix(dist(1:max(idx))),
            blocks1=c(3,3,3,2,2), ind1=idx)

##compute F' \%*\% C \%*\% F
tFmatF <- calc.tFXF(F, C, idx, block.sizes = c(3,3,3,2,2),
                    n.blocks = 5)
##which is equivalent of
tFmatF.alt <- calc.tFX(F, t(calc.tFX(F, C, idx)), idx)

range(tFmatF-tFmatF.alt)
\dontshow{
  if( max(abs(tFmatF-tFmatF.alt)) > 1e-13 ){
    stop("calc.tFXF 2: Results not equal")
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
  \code{\link{calc.tFX}}, \code{\link{calc.X.iS.X}},
  \code{\link{invCholBlock}}, \code{\link{makeCholBlock}},
  \code{\link{makeSigmaB}}, \code{\link{makeSigmaNu}},
  \code{\link{solveTriBlock}}

  Other temporal trend functions: \code{\link{calc.FX}},
  \code{\link{calc.FXtF2}}, \code{\link{calc.tFX}},
  \code{\link{expandF}}
}

