\name{SVDmiss}
\alias{SVDmiss}
\title{Missing Data SVD}
\usage{
  SVDmiss(X, niter = 25, ncomp = min(4, dim(X)[2]),
    conv.reldiff = 0.001)
}
\arguments{
  \item{X}{Data matrix, with missing values marked by
  \code{NA}.}

  \item{niter}{Maximum number of iterations to run before
  exiting, \code{Inf} will run until the
  \code{conv.reldiff} criteria is met.}

  \item{ncomp}{Number of SVD components to use in the
  reconstruction (>0).}

  \item{conv.reldiff}{Assume the iterative procedure has
  converged when the relative difference between two
  consecutive iterations is less than \code{conv.reldiff}.}
}
\value{
  A list with the following components: \item{Xfill}{The
  completed data matrix with missing values replaced by
  fitting the data to the \code{ncomp} most important svd
  components} \item{svd}{The result of svd on the completed
  data matrix, i.e.  \code{svd(Xfill)}} \item{status}{A
  vector of status variables: \code{diff}, the absolute
  difference between the two last iterations;
  \code{rel.diff}, the relative difference; \code{n.iter},
  the number of iterations; and \code{max.iter}, the
  requested maximum number of iterations.}
}
\description{
  Function that completes a data matrix using iterative svd
  as described in Fuentes et. al. (2006). The function
  iterates between computing the svd for the matrix and
  replacing the missing values by linear regression of the
  columns onto the first \code{ncomp} svd components. As
  initial replacement for the missing values regression on
  the column averages are used. The function \emph{will
  fail} if entire rows and/or columns are missing from the
  data matrix.
}
\examples{
##create a data matrix
t <- seq(0,4*pi,len=50)
X.org <- cbind(cos(t),sin(2*t)) \%*\% matrix(rnorm(20),2,10)

##add some normal errors
X <- X.org + .25*rnorm(length(X.org))
##and mark some data as missing
X[runif(length(X))<.25] <- NA

##Ensure that we have complet columns/rows
while( any(rowSums(is.na(X))==dim(X)[2]) || any(colSums(is.na(X))==dim(X)[1]) ){
  X <- X.org + .25*rnorm(length(X.org))
  X[runif(length(X))<.25] <- NA
}

#run the missing data svd
res <- SVDmiss(X, niter=100, ncomp=2)
#look at the status
res$status
#plot the first four columns of the data matrix
par(mfrow=c(2,2))
for(i in 1:4){
  plot(t, X[,i])
  lines(t, res$Xfill[,i])
  lines(t, X.org[,i], col=2)
}
\dontshow{
  if( max(abs(res$Xfill-X),na.rm=TRUE) > 1e-10 ){
    stop("SVD.miss: Points not interpolated")
  }
}
}
\author{
  Paul D. Sampson and Johan Lindström
}
\references{
  M. Fuentes, P. Guttorp, and P. D. Sampson. (2006) Using
  Transforms to Analyze Space-Time Processes in Statistical
  methods for spatio-temporal systems (B. Finkenstädt, L.
  Held, V. Isham eds.) 77-150
}
\seealso{
  Other data matrix: \code{\link{createDataMatrix}},
  \code{\link{estimateBetaFields}},
  \code{\link{mesa.data.raw}}, \code{\link{SVDsmooth}},
  \code{\link{SVDsmoothCV}}

  Other SVD for missing data: \code{\link{boxplot.SVDcv}},
  \code{\link{calcSmoothTrends}}, \code{\link{plot.SVDcv}},
  \code{\link{print.SVDcv}}, \code{\link{summary.SVDcv}},
  \code{\link{SVDsmooth}}, \code{\link{SVDsmoothCV}},
  \code{\link{updateSTdataTrend}},
  \code{\link{updateTrend}},
  \code{\link{updateTrend.STdata}},
  \code{\link{updateTrend.STmodel}}
}

