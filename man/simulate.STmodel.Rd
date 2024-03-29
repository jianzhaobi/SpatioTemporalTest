\name{simulate.STmodel}
\alias{simulate.STmodel}
\title{Simulate Data from the Spatio-Temporal Model}
\usage{
  \method{simulate}{STmodel} (object, nsim = 1,
    seed = NULL, x, nugget.unobs = 0, ...)
}
\arguments{
  \item{object}{A \code{STmodel} object to perform
  unconditional simulation from.}

  \item{nsim}{Number of replicates to simulate.}

  \item{seed}{if !=NULL used in a call to
  \code{\link[base:set.seed]{set.seed}}, allowing for
  replicatable simulation studies.}

  \item{x}{Parameters to use when simulating the data; both
  regression and covariance parameters must be given, see
  \code{\link{loglikeSTgetPars}}.}

  \item{nugget.unobs}{Value of nugget at unonserved
  locations, either a scalar or a vector with one element
  per unobserved site.}

  \item{...}{Additional parameters for
  \code{\link[base:set.seed]{set.seed}}}
}
\value{
  A list containing: \item{param}{Parameters used in the
  simulation, i.e. \code{x}.} \item{B}{The simulated beta
  fields in a (number of locations) - by - (number of
  temporal trends) - by - (number of replicates) array.}
  \item{X}{The simulated spatio-temporal fields in a
  (number of timepoints) - by - (number of locations) - by
  - (number of replicates) array. Row and column names
  indicate the time and locations for each point.}
  \item{obs}{A list with one element per replicate,
  containing the simulated observations extracted at
  space-time locations matching those in \code{object$obs}.
  To replace the observations with the i:th simulated
  values do:\cr \code{object$obs <- res$obs[[i]]}.}
}
\description{
  Data is simulated for the space-time locations in
  \code{object} using the parameters in \code{x}.
}
\examples{
##load the data
data(mesa.model)
data(est.mesa.model)

##Get estimated parameters
x <- coef(est.mesa.model)$par

##Simulate 5 replicates from these parameters
sim.data <- simulate(mesa.model, nsim=5, x=x)

##compute average beta fields
beta <- calc.mu.B(mesa.model$LUR, loglikeSTgetPars(x, mesa.model)$alpha)

##plot the simulated observations as a function of time
par(mfrow=c(2,2), mar=c(4,4,.5,.5))
plot(sim.data$obs[[1]]$date, sim.data$obs[[1]]$obs,
     type="n", ylab="obs", xlab="Date")
for(i in 1:5){
  points(sim.data$obs[[i]]$date, sim.data$obs[[i]]$obs, col=i)
}
##and the latent beta-fields
for(i in 1:3){
  plot(sim.data$B[,i,1], ylim=range(sim.data$B[,i,]), type="n",
       xlab="loc", ylab=paste("beta",colnames(sim.data$B)[i]))
  for(j in 1:5){
    points(sim.data$B[,i,j], col=j)
  }
  lines( beta[,i], col="grey")
}
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
  \code{\link{print.STmodel}},
  \code{\link{print.summary.STmodel}},
  \code{\link{qqnorm.predCVSTmodel}},
  \code{\link{qqnorm.STdata}},
  \code{\link{qqnorm.STmodel}},
  \code{\link{scatterPlot.predCVSTmodel}},
  \code{\link{scatterPlot.STdata}},
  \code{\link{scatterPlot.STmodel}},
  \code{\link{summary.STmodel}}
}

