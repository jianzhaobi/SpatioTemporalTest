\name{MCMC.STmodel}
\alias{MCMC}
\alias{MCMC.STmodel}
\title{MCMC Inference of Parameters in the Spatio-Temporal Model}
\usage{
  \method{MCMC}{STmodel} (object, x, x.fixed = NULL,
    type = "f", N = 1000, Hessian.prop = NULL,
    Sigma.prop = NULL, info = min(ceiling(N/50), 100), ...)

  MCMC(object, ...)
}
\arguments{
  \item{object}{\code{STmodel} for which to run MCMC.}

  \item{x}{Point at which to start the MCMC. Could be
  either only \emph{log}-covariance parameters or
  regression and \emph{log}-covariance parameters. If
  regression parameters are given but not needed they are
  dropped, if they are needed but not given they are
  inferred by calling \cr \code{\link{predict.STmodel}}
  with \code{only.pars=TRUE}.}

  \item{x.fixed}{Vector with parameter to be held fixed;
  parameters marked as \code{NA} will still be estimated.}

  \item{type}{A single character indicating the type of
  log-likelihood to compute. Valid options are "f" or "r",
  for \emph{full}, or \emph{restricted maximum likelihood}
  (REML). Since \emph{profile} is not a proper likelihood
  \code{type="p"} will revert (with a warning) to using the
  \emph{full} log-likelihood.}

  \item{N}{Number of MCMC iterations to run.}

  \item{Hessian.prop}{Hessian (information) matrix for the
  log-likelihood, can be used to create a proposal matrix
  for the MCMC.}

  \item{Sigma.prop}{Proposal matrix for the MCMC.}

  \item{info}{Outputs status information every info:th
  iteration.  If \code{info=0} no output.}

  \item{...}{ignored additional arguments.}
}
\value{
  \code{mcmcSTmodel} object with elements: \item{par}{A
  \code{N} - by - (number of parameters) matrix with
  trajectories of the parameters.} \item{log.like}{A vector
  of length \code{N} with the log-likelihood values at each
  iteration.} \item{acceptance}{A vector of length \code{N}
  with the acceptance probability for each iteration.}
  \item{Sigma.prop, chol.prop}{Proposal matrix and it's
  Choleskey factor.} \item{x.fixed}{Any fixed parameters.}
}
\description{
  Estimates parameters and parameter uncertainties for the
  spatio-temporal model using a Metropolis-Hastings based
  Markov Chain Monte Carlo (MCMC) algorithm. \cr The
  function runs uses a Metropolis-Hastings algorithm
  (Hastings, 1970) to sample from the parameters of the
  spatio-temporal model, assuming flat priors for all the
  parameters (flat on the log-scale for the covariance
  parameters).
}
\details{
  At each iteration of the MCMC new parameters are proposed
  using a random-walk with a proposal covariance matrix.
  The proposal matrix is determined as: \describe{
  \item{1}{If \code{Sigma.prop} is given then this is
  used.} \item{2}{If \code{Sigma.prop=NULL} then we follow
  Roberts et.al. (1997) and compute \cr \code{c <-
  2.38*2.38/dim(Hessian.prop)[1]}\cr \code{Sigma.prop <-
  -c*solve(Hessian.prop)}.} \item{3}{If both
  \code{Sigma.prop=NULL} and \code{Hessian.prop=NULL} then
  the Hessian is computed using
  \code{\link{loglikeSTHessian}} and \code{Sigma.prop} is
  computed according to point 2.} } The resulting proposal
  matrix is checked to ensure that it is positive definite
  before proceeding, \cr \code{all(eigen(Sigma.prop)$value
  > 1e-10)}.
}
\examples{
##load data
data(mesa.model)
##and results of estimation
data(est.mesa.model)

##strating point
x <- coef(est.mesa.model)
##Hessian, for use as proposal matrix
H <- est.mesa.model$res.best$hessian.all
\dontrun{
  ##run MCMC
  MCMC.mesa.model <- MCMC(mesa.model, x$par, N = 2500, Hessian.prop = H)
}
##lets load precomputed results instead
data(MCMC.mesa.model)

##Examine the results
print(MCMC.mesa.model)

##and contens of result vector
names(MCMC.mesa.model)
 
##Summary
summary(MCMC.mesa.model)

##MCMC tracks for four of the parameters
par(mfrow=c(5,1),mar=c(2,2,2.5,.5))
plot(MCMC.mesa.model, ylab="", xlab="", type="l")
for(i in c(4,9,13,15)){
  plot(MCMC.mesa.model, i, ylab="", xlab="", type="l")
}
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other mcmcSTmodel methods:
  \code{\link{density.mcmcSTmodel}},
  \code{\link{plot.density.mcmcSTmodel}},
  \code{\link{plot.mcmcSTmodel}},
  \code{\link{print.mcmcSTmodel}},
  \code{\link{print.summary.mcmcSTmodel}},
  \code{\link{summary.mcmcSTmodel}}

  Other STmodel methods: \code{\link{c.STmodel}},
  \code{\link{createSTmodel}}, \code{\link{estimate}},
  \code{\link{estimate.STmodel}}, \code{\link{estimateCV}},
  \code{\link{estimateCV.STmodel}},
  \code{\link{plot.STdata}}, \code{\link{plot.STmodel}},
  \code{\link{predict.STmodel}}, \code{\link{predictCV}},
  \code{\link{predictCV.STmodel}},
  \code{\link{print.STmodel}},
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

