\name{loglikeSTgetPars}
\alias{loglikeSTgetPars}
\title{Extract Parameters from a Vector}
\usage{
  loglikeSTgetPars(x, STmodel)
}
\arguments{
  \item{x}{A vector containing regression (optionally) and
  \emph{log}-covariance parameters. The ordering of
  \strong{has to be exactly} that indicated by
  \code{\link{loglikeSTnames}}.}

  \item{STmodel}{STmodel \code{STmodel} object describing
  the problem.}
}
\value{
  list containing: \item{gamma}{Regression coefficients for
  the spatio-temporal covariate(s).} \item{alpha}{A list of
  regression coefficients for geographic covariates.}
  \item{cov.beta}{A list containg a lists of pars and
  vector of nuggets.  See \code{\link{makeSigmaB}}.}
  \item{cov.nu}{A list of covariance parameters for the
  nu-field, as \code{pars}, \code{nugget} and
  \code{random.effect} respectively.} Covariance parameters
  are also back-transformed from log-scale.
}
\description{
  Extracts parameters for the log-likelihood from a
  parameter vector and separates regression parameters and
  \emph{log}-covariance parameters.
}
\examples{
##load the data
data(mesa.model)

##Compute dimensions for the data structure
dim <- loglikeSTdim(mesa.model)

##Let's create random parameter vectors ...
x <- runif( dim$nparam.cov )
names(x) <- loglikeSTnames(mesa.model, FALSE) 
x.all <- runif( dim$nparam )
names(x.all) <- loglikeSTnames(mesa.model, TRUE) 

##... and pick them apart
str( loglikeSTgetPars(x, mesa.model) )
str( loglikeSTgetPars(x.all, mesa.model) )

##Try a somewhat more interesting covariance structure
mesa.model.alt <- updateCovf(mesa.model,
                            cov.beta=list(covf=c("exp","exp2","matern"),
                              nugget=c(TRUE,FALSE,TRUE)),
                             cov.nu=list(covf="exp", nugget="type",
                               random.effect=TRUE))
##Compute dimensions for the data structure
dim <- loglikeSTdim(mesa.model.alt)

##Let's create random parameter vectors ...
x <- runif( dim$nparam.cov )
names(x) <- loglikeSTnames(mesa.model.alt, FALSE) 
x.all <- runif( dim$nparam )
names(x.all) <- loglikeSTnames(mesa.model.alt, TRUE) 

##... and pick them apart
str( loglikeSTgetPars(x, mesa.model.alt) )
str( loglikeSTgetPars(x.all, mesa.model.alt) )
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other likelihood utility functions:
  \code{\link{calc.iS.X}}, \code{\link{calc.mu.B}},
  \code{\link{calc.X.iS.X}}, \code{\link{loglikeSTdim}},
  \code{\link{loglikeSTnames}}
}

