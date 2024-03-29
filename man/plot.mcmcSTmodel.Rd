\name{plot.mcmcSTmodel}
\alias{plot.mcmcSTmodel}
\title{Plots for an \code{mcmcSTmodel} object}
\usage{
  \method{plot}{mcmcSTmodel} (x, y = "like", add = FALSE,
    main = NULL, ...)
}
\arguments{
  \item{x}{\code{mcmcSTmodel} object to plot.}

  \item{y}{Type of plot, options are \code{"like"},
  \code{"alpha"}, or name/index number of a parameter.}

  \item{add}{Add to existing plot using
  \code{\link[graphics:lines]{lines}}}

  \item{main}{Parameter passed as \code{main} to
  \code{\link[graphics:plot]{plot}}, defaults to the
  parameter-name if not given.}

  \item{...}{Additional parameters passed to
  \code{\link[graphics:plot]{plot}} or
  \code{\link[graphics:lines]{lines}}}
}
\value{
  Nothing
}
\description{
  \code{\link[graphics:plot]{plot}} method for class
  \code{mcmcSTmodel}.
}
\details{
  Plots results from \code{\link{MCMC.STmodel}}. Either
  parameter paths or the log-likelihood for the mcmc
  simulations.
}
\examples{
##load MCMC results instead
data(MCMC.mesa.model)

##plot the log-likelihood
plot(MCMC.mesa.model, ylab="", xlab="", type="l")

##and MCMC tracks for four of the parameters
par(mfrow=c(4,1),mar=c(2,2,2.5,.5))
for(i in c(4,9,13,15)){
  plot(MCMC.mesa.model, i, ylab="", xlab="", type="l")
}

##or by name
par(mfrow=c(1,1),mar=c(2,2,2.5,.5))
plot(MCMC.mesa.model, "nu.log.range.exp", ylab="", xlab="", type="l",
     main="all range estimates", ylim=c(-14,10))
##all ranges in one plot
plot(MCMC.mesa.model, "log.range.const.exp", add=TRUE, col=2)
plot(MCMC.mesa.model, "log.range.V1.exp", add=TRUE, col=3)
plot(MCMC.mesa.model, "log.range.V2.exp", add=TRUE, col=4)
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other mcmcSTmodel methods:
  \code{\link{density.mcmcSTmodel}}, \code{\link{MCMC}},
  \code{\link{MCMC.STmodel}},
  \code{\link{plot.density.mcmcSTmodel}},
  \code{\link{print.mcmcSTmodel}},
  \code{\link{print.summary.mcmcSTmodel}},
  \code{\link{summary.mcmcSTmodel}}
}

