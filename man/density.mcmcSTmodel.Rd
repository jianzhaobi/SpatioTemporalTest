\name{density.mcmcSTmodel}
\alias{density.mcmcSTmodel}
\title{Kernel Density Estimation for an \code{mcmcSTmodel} Object}
\usage{
  \method{density}{mcmcSTmodel} (x, BurnIn = 0,
    estSTmodel = NULL, ...)
}
\arguments{
  \item{x}{\code{mcmcSTmodel} object}

  \item{BurnIn}{Number of initial points to ignore.}

  \item{estSTmodel}{Either a \code{estimateSTmodel} object
  from \code{\link{estimate.STmodel}} or a matrix with
  parameter-estimates and standard deviations, such as the
  output from \code{\link{coef.estimateSTmodel}}. If given
  as a matrix, it should have columns named "par" and "sd",
  and rows named after the parameters.}

  \item{...}{Additional parameters passed to
  \code{\link[stats:density]{density}}.}
}
\value{
  List containing density estimate and Gaussian densities
  for all model parameters.
}
\description{
  \code{\link[stats:density]{density}} method for class
  \code{mcmcSTmodel}.
}
\details{
  Computes kernel density estimates for the
  MCMC-parameters; as well as approximate Gaussian
  densities based on the Fischer-information.
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
  Other mcmcSTmodel methods: \code{\link{MCMC}},
  \code{\link{MCMC.STmodel}},
  \code{\link{plot.density.mcmcSTmodel}},
  \code{\link{plot.mcmcSTmodel}},
  \code{\link{print.mcmcSTmodel}},
  \code{\link{print.summary.mcmcSTmodel}},
  \code{\link{summary.mcmcSTmodel}}
}

