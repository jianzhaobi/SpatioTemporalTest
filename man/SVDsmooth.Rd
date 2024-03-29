\name{SVDsmooth}
\alias{SVDsmooth}
\alias{SVDsmoothCV}
\title{Smooth Basis Functions for Data Matrix with Missing Values}
\usage{
  SVDsmooth(X, n.basis = min(2, dim(X)[2]),
    date.ind = NULL, scale = TRUE, niter = 100,
    conv.reldiff = 0.001, df = NULL, spar = NULL,
    fnc = FALSE)

  SVDsmoothCV(X, n.basis, ...)
}
\arguments{
  \item{X}{Data matrix, with missing values marked by
  \code{NA} (use \code{\link{createDataMatrix}}). Rows
  and/or columns that are completely missing will be
  dropped (with a message), for the rows the smooths will
  be interpolated using
  \code{\link[stats:predict.smooth.spline]{predict.smooth.spline}}.}

  \item{n.basis}{Number of smooth basis functions to
  compute, will be passed as \code{ncomp} to
  \code{\link{SVDmiss}}; for \code{SVDsmoothCV} a vector
  with the different number of basis functions to evaluate
  (including 0).}

  \item{date.ind}{Vector giving the observation time of
  each row in \code{X}, used as \code{x} in \cr
  \code{\link[stats:smooth.spline]{smooth.spline}} when
  computing the smooth basis functions. If missing
  \code{\link{convertCharToDate}} is used to coerce the
  \code{rownames(X)}.}

  \item{scale}{If \code{TRUE}, will use
  \code{\link[base:scale]{scale}} to scale \code{X} before
  calling \code{\link{SVDmiss}}.}

  \item{niter,conv.reldiff}{Controls convergence, passed to
  \code{\link{SVDmiss}}.}

  \item{df,spar}{The desired degrees of freedom/smoothing
  parameter for the spline, \cr see
  \code{\link[stats:smooth.spline]{smooth.spline}}}

  \item{fnc}{If \code{TRUE} return a function instead of
  the trend-matrix, see Value below.}

  \item{...}{Additional parameters passed to
  \code{SVDsmooth}; i.e. \code{date.ind}, \code{scale},
  \code{niter}, \code{conv.reldiff}, \code{df},
  \code{spar}, and/or \code{fnc}.}
}
\value{
  Depends on the function: \item{SVDsmooth}{A matrix (if
  \code{fnc==FALSE}) where each column is a smooth basis
  function based on the SVD of the completed data matrix.
  The left most column contains the smooth of the most
  important SVD. If \code{fnc==TRUE} a function that will
  create the data matrix if called as \code{fnc(date.ind)},
  \code{fnc(1:dim(X)[1])}, or \code{fnc(convertCharToDate(
  rownames(X) ))}.} \item{SVDsmoothCV}{A list of class
  \code{SVDcv} with components: \describe{
  \item{CV.stat,CV.sd}{\code{data.frame}s with mean and
  standard deviation of the CV statistics for each of the
  number of basis functions evaluated.}
  \item{MSE.all,R2.all,AIC.all,BIC.all}{\code{data.frame}s
  with the individual MSE, R2, AIC, and BIC values for each
  column in the data matrix and for each number of basis
  functions evaluated.} \item{smoothSVD}{A list with
  \code{length(n.basis)} components. If \code{fnc==FALSE}
  each component contains an array where
  \code{smoothSVD[[j]][,,i]} is the result of
  \code{SVDsmooth} applied to \code{X[,-i]} with
  \code{n.basis[j]} smooth functions; if \code{fnc==FALSE}
  each component contains a list of functions as
  \code{smoothSVD[[j]][[i]]}.} } }
}
\description{
  Function that computes smooth functions for a data matrix
  with missing values, as described in Fuentes et. al.
  (2006), or does cross validation to determine a suitable
  number of basis functions. The function uses
  \code{\link{SVDmiss}} to complete the matrix and then
  computes smooth basis functions by applying
  \code{\link[stats:smooth.spline]{smooth.spline}} to the
  SVD of the completed data matrix.
}
\details{
  \code{SVDsmoothCV} uses leave-one-column-out
  cross-validation; holding one column out from \code{X},
  calling \code{SVDsmooth}, and then regressing the held
  out column on the resulting smooth functions.
  Cross-validation statistics computed for each of these
  regressions include MSE, R-squared, AIC and BIC. The
  weighted average (weighted by number of observations in
  the colum) is then reported as CV-statistics.
}
\examples{
##create a data matrix
t <- seq(0,4*pi,len=50)
X.org <- cbind(cos(t),sin(2*t)) \%*\% matrix(rnorm(10),2,5)

##add some normal errors
X <- X.org + .25*rnorm(length(X.org))
##and mark some data as missing
X[runif(length(X))<.25] <- NA

##Ensure that we have complet columns/rows
while( any(rowSums(is.na(X))==dim(X)[2]) || any(colSums(is.na(X))==dim(X)[1]) ){
  X <- X.org + .25*rnorm(length(X.org))
  X[runif(length(X))<.25] <- NA
}

##compute two smooth basis functions
res <- SVDsmooth(X, n.basis=2, niter=100)

##or compute the function that gives the basis functions
res.fnc <- SVDsmooth(X, n.basis=2, niter=100, fnc=TRUE)

##and they are equal
summary( res.fnc()-res )
\dontshow{
  if( !isTRUE(all.equal(res.fnc(), res)) ){
    stop("SVDsmooth: Function and matrix NOT equal.")
  }
}

##plot the two smooth basis functions
par(mfcol=c(3,2), mar=c(4,4,.5,.5))
plot(t, res[,1], ylim=range(res), type="l")
lines(t, res[,2], col=2)
##and some of the data fitted to the smooths
for(i in 1:5){
  plot(t, X[,i])
  lines(t, predict.lm(lm(X[,i]~res), data.frame(res)) )
  lines(t, X.org[,i], col=2)
}

##compute cross-validation for 1 to 4 basis functions
res.cv <- SVDsmoothCV(X, n.basis=0:4, niter=100)

##study cross-validation results
print(res.cv)
summary(res.cv)

##plot cross-validation statistics
plot(res.cv, sd=TRUE)
##boxplot of CV statistics for each column
boxplot(res.cv)
##plot the BIC for each column
plot(res.cv, "BIC", pairs=TRUE)

\dontshow{
  res.cv.2 <- SVDsmoothCV(X, n.basis=0:4, niter=100, fnc=TRUE)
  if( !isTRUE(all.equal(res.cv[1:6], res.cv.2[1:6])) ){
    stop("SVDsmoothCV: Function and matrix NOT equal; stats!")
  }
  
  tmp <- lapply(res.cv.2$smoothSVD[[3]], function(x){x()})
  if( any(sapply(1:length(tmp),
                 function(i){max(abs(res.cv$smoothSVD[[3]][,,i] - tmp[[i]]))})
          >1e-14) ){
    stop("SVDsmoothCV: Function and matrix NOT equal; parts!")
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
  \code{\link{mesa.data.raw}}, \code{\link{SVDmiss}}

  Other SVD for missing data: \code{\link{boxplot.SVDcv}},
  \code{\link{calcSmoothTrends}}, \code{\link{plot.SVDcv}},
  \code{\link{print.SVDcv}}, \code{\link{summary.SVDcv}},
  \code{\link{SVDmiss}}, \code{\link{updateSTdataTrend}},
  \code{\link{updateTrend}},
  \code{\link{updateTrend.STdata}},
  \code{\link{updateTrend.STmodel}}

  Other SVDcv methods: \code{\link{boxplot.SVDcv}},
  \code{\link{plot.SVDcv}}, \code{\link{print.SVDcv}},
  \code{\link{summary.SVDcv}}
}

