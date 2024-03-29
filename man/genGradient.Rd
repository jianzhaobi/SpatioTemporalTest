\name{genGradient}
\alias{genGradient}
\alias{genHessian}
\title{Compute Finite Difference Gradient and Hessians.}
\usage{
  genGradient(x, func, h = 0.001, diff.type = 0)

  genHessian(x, func, h = 0.001)
}
\arguments{
  \item{x}{Point at which to compute the gradient or
  hessian.}

  \item{func}{function that takes only \code{x} as an input
  argument. Use \cr
  \code{function(x){my.func(x,other.input)}} to create a
  temporary function, see the example.}

  \item{h}{Step length for the finite difference.}

  \item{diff.type}{Type of finite difference,
  \code{diff.type>0} gives forward differences,
  \code{diff.type=0} gives central differences, and
  \code{diff.type<0} gives backward differences.}
}
\value{
  gradient vector or Hessian matrix.
}
\description{
  Computes finite difference gradient and/or hessian.
  \code{genGradient} function does forward, backward or
  central differences, the \code{genHessian} function uses
  only central differences.
}
\examples{
#create a two variable function
f.test <- function(x){sin(x[1])*cos(x[2])}

#compute the gradient using forward difference
genGradient(c(.5,.5), f.test, diff.type=1)
#and central difference
genGradient(c(.5,.5), f.test, diff.type=0)
#compared to the true value
c(cos(.5)*cos(.5),-sin(.5)*sin(.5))

#Compute the Hessian
genHessian(c(.5,.5), f.test, h=1e-4)
#and compare to the true value
matrix(c(-sin(.5)*cos(.5),-cos(.5)*sin(.5),
         -cos(.5)*sin(.5),-sin(.5)*cos(.5)),2,2)

\dontshow{
  if( max(abs(genGradient(c(.5,.5), f.test, h=1e-5, diff.type=0) -
              c(cos(.5)*cos(.5),-sin(.5)*sin(.5)))) > 1e-10 ){
    stop("genGradient, diff.type=0: Results not equal")
  }
  if( max(abs(genGradient(c(.5,.5), f.test, h=1e-5, diff.type=1) -
              c(cos(.5)*cos(.5),-sin(.5)*sin(.5)))) > 1e-5 ){
    stop("genGradient, diff.type=1: Results not equal")
  }
  if( max(abs(genGradient(c(.5,.5), f.test, h=1e-5, diff.type=-1) -
              c(cos(.5)*cos(.5),-sin(.5)*sin(.5)))) > 1e-5 ){
    stop("genGradient, diff.type=-1: Results not equal")
  }
  if( max(abs(genHessian(c(.5,.5), f.test, h=1e-4) -
              matrix(c(-sin(.5)*cos(.5),-cos(.5)*sin(.5),
                       -cos(.5)*sin(.5),-sin(.5)*cos(.5)),2,2))) > 1e-5 ){
    stop("genHessian: Results not equal")
  }
}

}
\author{
  Johan Lindstr�m
}
\seealso{
  Other numerical derivatives: \code{\link{loglikeSTGrad}},
  \code{\link{loglikeSTHessian}},
  \code{\link{loglikeSTnaiveGrad}},
  \code{\link{loglikeSTnaiveHessian}}
}

