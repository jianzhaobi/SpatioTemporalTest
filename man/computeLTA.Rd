\name{computeLTA}
\alias{computeLTA}
\title{Computes the Long Term Average for Each Sites.}
\usage{
  computeLTA(object, transform = function(x) {
        return(x) })
}
\arguments{
  \item{object}{A \code{predCVSTmodel} object, the result
  of \code{\link{predictCV.STmodel}}.}

  \item{transform}{Transform observations (\emph{without}
  bias correction) and predictions \emph{before} computing
  averages; e.g. \code{transform=exp} gives the long term
  averages as \code{mean( exp(obs) )} and \code{mean(
  exp(pred) )}.}
}
\value{
  Returns a (number of locations) - by - 4 matrix with the
  observed and predicted value (using the three different
  model parts) for each location.
}
\description{
  Computes the long term average of observations and
  cross-validated predictions for each of the sites in
  \code{object}. The long term averages are computed using
  \emph{only} timepoints that have observations, this
  applies to both the observed and predicted. Also the
  function allows for a transformation: if requested the
  transformation is applied \emph{before} the averaging.
}
\examples{
##load data
data(pred.cv.mesa)

##compute long term averages of predictions and observations
pred.lta <- computeLTA(pred.cv.mesa)

##we can now compare observed and predicted averages at each site
plot(pred.lta[,"obs"], pred.lta[,"EX.mu"], pch=1,
     xlim=range(pred.lta), ylim=range(pred.lta),
     xlab="obs", ylab="predictions")
##for the different model components
points(pred.lta[,"obs"], pred.lta[,"EX.mu.beta"], pch=3, col=2)
points(pred.lta[,"obs"], pred.lta[,"EX"], pch=4, col=3)
abline(0,1)

##we could also try computaitons on the original scale
pred.lta <- computeLTA(pred.cv.mesa, exp)

##compare observed and predicted averages
plot(pred.lta[,"obs"], pred.lta[,"EX.mu"], pch=1,
     xlim=range(pred.lta), ylim=range(pred.lta),
     xlab="obs", ylab="predictions")
points(pred.lta[,"obs"], pred.lta[,"EX.mu.beta"], pch=3, col=2)
points(pred.lta[,"obs"], pred.lta[,"EX"], pch=4, col=3)
abline(0,1)
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other cross-validation functions: \code{\link{createCV}},
  \code{\link{dropObservations}}, \code{\link{estimateCV}},
  \code{\link{estimateCV.STmodel}},
  \code{\link{predictCV}}, \code{\link{predictCV.STmodel}},
  \code{\link{predictNaive}}

  Other predCVSTmodel functions: \code{\link{estimateCV}},
  \code{\link{estimateCV.STmodel}},
  \code{\link{predictCV}}, \code{\link{predictCV.STmodel}}
}

