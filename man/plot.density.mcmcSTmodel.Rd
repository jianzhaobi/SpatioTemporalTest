\name{plot.density.mcmcSTmodel}
\alias{plot.density.mcmcSTmodel}
\title{Plots for an \code{density.mcmcSTmodel} object}
\usage{
  \method{plot}{density.mcmcSTmodel} (x, y = 1,
    add = FALSE, norm.col = 0, main = NULL, ylim = NULL,
    ...)
}
\arguments{
  \item{x}{\code{density.mcmcSTmodel} object to plot.}

  \item{y}{Name/index of parameter for which to plot the
  density.}

  \item{add}{Add to existing plot using
  \code{\link[graphics:lines]{lines}}.}

  \item{norm.col}{Add the Gaussian density using a line
  with colour \code{norm.col}, if \code{norm.col=0} do
  \emph{not} add the Gaussian.}

  \item{main}{Parameter passed as \code{main} to
  \code{\link[stats:plot.density]{plot.density}}, defaults
  to the parameter-name if not given.}

  \item{ylim}{Additional parameters passed to
  \code{\link[stats:plot.density]{plot.density}}.}

  \item{...}{Additional parameters passed to
  \code{\link[stats:plot.density]{plot.density}} or
  \code{\link[graphics:lines]{lines}}.}
}
\value{
  Nothing
}
\description{
  \code{\link[graphics:plot]{plot}} method for class
  \code{density.mcmcSTmodel}. Plots results from
  \code{\link{density.mcmcSTmodel}}.
}
\examples{
##load estimation results
data(est.mesa.model)
##and MCMC results instead
data(MCMC.mesa.model)

##compute density estimates for the results, and use the Gaussian approximation
##based on Fischer information as reference.
dens <- density(MCMC.mesa.model, estSTmodel=est.mesa.model)

##all the estimated densities
str(dens,1)

##or results for one paramter
dens[[1]]

##plot density functions
plot(dens)
##for a different paramter, along with Gaussian approx
plot(dens, 3, norm.col="red")

##all covariance parameters
par(mfrow=c(3,3),mar=c(4,4,2.5,.5))
for(i in 9:17){
  plot(dens, i, norm.col="red")
}
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other mcmcSTmodel methods:
  \code{\link{density.mcmcSTmodel}}, \code{\link{MCMC}},
  \code{\link{MCMC.STmodel}},
  \code{\link{plot.mcmcSTmodel}},
  \code{\link{print.mcmcSTmodel}},
  \code{\link{print.summary.mcmcSTmodel}},
  \code{\link{summary.mcmcSTmodel}}
}

