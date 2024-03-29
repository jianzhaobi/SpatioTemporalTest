\name{print.STmodel}
\alias{print.STmodel}
\title{Print details for \code{STmodel} object}
\usage{
  \method{print}{STmodel} (x, type = x$locations$type, ...)
}
\arguments{
  \item{x}{\code{STmodel} object to print information for.}

  \item{type}{Factorial of \code{length(x$locations$ID)},
  if not \code{NULL} the output also presents summaries of
  number of sites and observations as well as time periods
  per type of site.}

  \item{...}{Ignored additional arguments.}
}
\value{
  Nothing
}
\description{
  \code{\link[base:print]{print}} method for class
  \code{STmodel}.
}
\examples{
##load some data
data(mesa.model)
##print basic information regarding obs, locations, dates, etc
print(mesa.model)
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other STmodel methods: \code{\link{c.STmodel}},
  \code{\link{createSTmodel}}, \code{\link{estimate}},
  \code{\link{estimate.STmodel}}, \code{\link{estimateCV}},
  \code{\link{estimateCV.STmodel}}, \code{\link{MCMC}},
  \code{\link{MCMC.STmodel}}, \code{\link{plot.STdata}},
  \code{\link{plot.STmodel}},
  \code{\link{predict.STmodel}}, \code{\link{predictCV}},
  \code{\link{predictCV.STmodel}},
  \code{\link{print.summary.STmodel}},
  \code{\link{qqnorm.predCVSTmodel}},
  \code{\link{qqnorm.STdata}},
  \code{\link{qqnorm.STmodel}},
  \code{\link{scatterPlot.predCVSTmodel}},
  \code{\link{scatterPlot.STdata}},
  \code{\link{scatterPlot.STmodel}},
  \code{\link{simulate.STmodel}},
  \code{\link{summary.STmodel}}
}

