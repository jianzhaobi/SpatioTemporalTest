\name{loglikeSTGrad}
\alias{loglikeSTGrad}
\alias{loglikeSTHessian}
\alias{loglikeSTnaiveGrad}
\alias{loglikeSTnaiveHessian}
\title{Compute Gradient and Hessian for the Log-likelihood}
\usage{
  loglikeSTGrad(x, STmodel, type = "p", x.fixed = NULL,
    h = 0.001, diff.type = 0)

  loglikeSTHessian(x, STmodel, type = "p", x.fixed = NULL,
    h = 0.001)

  loglikeSTnaiveGrad(x, STmodel, type = "p",
    x.fixed = NULL, h = 0.001, diff.type = 0)

  loglikeSTnaiveHessian(x, STmodel, type = "p",
    x.fixed = NULL, h = 0.001)
}
\arguments{
  \item{x}{Point at which to compute the gradient or
  hessian, see \code{\link{loglikeST}}.}

  \item{STmodel}{\code{STmodel} object with the model for
  which to compute derivatives of the log-likelihood.}

  \item{type}{A single character indicating the type of
  log-likelihood to compute. Valid options are "f", "p",
  and "r", for \emph{full}, \emph{profile} or
  \emph{restricted maximum likelihood} (REML).}

  \item{x.fixed}{Parameters to keep fixed, see
  \code{\link{loglikeST}}.}

  \item{h,diff.type}{Step length and type of finite
  difference to use when computing gradients, see
  \code{\link{genGradient}}.}
}
\value{
  Returns the gradient or Hessian for the
  \code{\link{loglikeST}} and \code{\link{loglikeSTnaive}}
  functions.
}
\description{
  Computes finite difference gradients and hessians for the
  log-likelihood functions \code{\link{loglikeST}} and
  \code{\link{loglikeSTnaive}}. \cr Uses
  \code{\link{genGradient}} and \code{\link{genHessian}} to
  compute finite difference derivatives of the
  log-likelihood function in \code{\link{loglikeST}} and
  \code{\link{loglikeSTnaive}}.
}
\section{Warning}{
  \code{loglikeSTnaiveGrad} and
  \code{loglikeSTnaiveHhessian} may take \strong{very} long
  time to run, use with \strong{extreme caution}.
}
\examples{
\dontrun{
  ##load the data
  data(mesa.model)
  
  ##Compute dimensions for the data structure
  dim <- loglikeSTdim(mesa.model)
  
  ##Let's create random vectors of values
  x <- runif(dim$nparam.cov)
  x.all <- runif(dim$nparam)
 
  ##Compute the gradients
  Gf <- loglikeSTGrad(x.all, mesa.model, "f")
  Gp <- loglikeSTGrad(x, mesa.model, "p")
  Gr <- loglikeSTGrad(x, mesa.model, "r")
 
  ##And the Hessian, this may take some time...
  Hf <- loglikeSTHessian(x.all, mesa.model, "f")
  Hp <- loglikeSTHessian(x, mesa.model, "p")
  Hr <- loglikeSTHessian(x, mesa.model, "r")
}

}
\author{
  Johan Lindstr�m
}
\seealso{
  Other likelihood functions: \code{\link{loglikeST}},
  \code{\link{loglikeSTnaive}}

  Other numerical derivatives: \code{\link{genGradient}},
  \code{\link{genHessian}}
}

