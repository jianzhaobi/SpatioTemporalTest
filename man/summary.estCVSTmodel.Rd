\name{summary.estCVSTmodel}
\alias{summary.estCVSTmodel}
\title{Computes summary details for \code{estCVSTmodel} object}
\usage{
  \method{summary}{estCVSTmodel} (object, ...)
}
\arguments{
  \item{object}{\code{estCVSTmodel} object to compute
  summary information for.}

  \item{...}{Ignored additional arguments.}
}
\value{
  A \code{summary.estCVSTmodel} object.
}
\description{
  \code{\link[base:summary]{summary}} method for class
  \code{estCVSTmodel}.
}
\examples{
##load some data
data(est.cv.mesa)
##print basic information for the CV-predictions
summary(est.cv.mesa)
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other estCVSTmodel methods:
  \code{\link{boxplot.estCVSTmodel}},
  \code{\link{coef.estCVSTmodel}},
  \code{\link{estimateCV}},
  \code{\link{estimateCV.STmodel}},
  \code{\link{predictCV}}, \code{\link{predictCV.STmodel}},
  \code{\link{print.estCVSTmodel}},
  \code{\link{print.summary.estCVSTmodel}}
}

