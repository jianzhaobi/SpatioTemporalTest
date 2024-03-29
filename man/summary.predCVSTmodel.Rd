\name{summary.predCVSTmodel}
\alias{summary.predCVSTmodel}
\title{Computes summary details for \code{predCVSTmodel} object}
\usage{
  \method{summary}{predCVSTmodel} (object,
    pred.naive = NULL, by.date = FALSE, p = 0.95,
    transform = function(x) {     return(x) }, LTA = FALSE,
    ...)
}
\arguments{
  \item{object}{\code{predCVSTmodel} object to compute
  summary information for; the output from
  \code{\link{predictCV.STmodel}}.}

  \item{pred.naive}{Result of naive prediction; used to
  compute modified R2 values. The output from
  \code{\link{predictNaive}}.}

  \item{by.date}{Compute individual cross-validation
  statistics for each time-point. May lead to \emph{very
  many} statistics.}

  \item{p}{Approximate coverage of the computed confidence
  bands; the confidence bands are used when computing
  coverage of the cross-validated predictions.}

  \item{transform}{Transform observations and predictions
  (\emph{without} bias correction) \emph{before} computing
  statistics; see also \code{\link{computeLTA}}.
  \emph{Redundant} if option \code{transform} was used in
  \code{\link{predictCV.STmodel}} (as pass through argument
  to \code{\link{predict.STmodel}})}

  \item{LTA}{Compute cross-validation statistics for the
  long term averages at each site, uses
  \code{\link{computeLTA}} to compute the averages.
  \code{transform} is passed to \code{\link{computeLTA}}.
  This is \emph{redundant} if option \code{LTA=TRUE} was
  uses in \code{\link{predictCV.STmodel}}.}

  \item{...}{Ignored additional arguments.}
}
\value{
  A \code{summary.predCVSTmodel} object.
}
\description{
  \code{\link[base:summary]{summary}} method for class
  \code{predCVSTmodel}.
}
\details{
  Computes summary statistics for cross validation.
  Statistics that are computed include RMSE, R2, and
  coverage of CI:s; both for all observations and
  (possibly) stratified by date.
}
\examples{
##load some data
data(pred.cv.mesa)

##basic summary statistics
summary(pred.cv.mesa)
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other predCVSTmodel methods: \code{\link{estimateCV}},
  \code{\link{estimateCV.STmodel}},
  \code{\link{plot.predCVSTmodel}},
  \code{\link{plot.predictSTmodel}},
  \code{\link{predictCV}}, \code{\link{predictCV.STmodel}},
  \code{\link{print.predCVSTmodel}},
  \code{\link{print.summary.predCVSTmodel}},
  \code{\link{qqnorm.predCVSTmodel}},
  \code{\link{qqnorm.STdata}},
  \code{\link{qqnorm.STmodel}},
  \code{\link{scatterPlot.predCVSTmodel}},
  \code{\link{scatterPlot.STdata}},
  \code{\link{scatterPlot.STmodel}}
}

