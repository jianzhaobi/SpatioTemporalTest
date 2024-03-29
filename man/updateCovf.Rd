\name{updateCovf}
\alias{updateCovf}
\title{Update Covariance Functions in \code{STmodel} Objects}
\usage{
  updateCovf(STmodel, cov.beta = STmodel$cov.beta,
    cov.nu = STmodel$cov.nu)
}
\arguments{
  \item{STmodel}{\code{STmodel} object with observations,
  covariates, trends, etc; see \code{\link{mesa.model}}.}

  \item{cov.beta,cov.nu}{Covariance specification for the
  beta- and nu-fields should contain fields \code{covf},
  \code{nugget}, and \code{random.effect} (for the nu
  field); see details for description of these fields.  For
  \code{cov.beta} the fields should contain one element for
  each smooth-temporal trend / beta-field if the fields
  have only one element, these elements are repeated
  implying the same covariance for all beta-fields.}
}
\value{
  updated version of \code{STmodel} with new covariance
  specifications.
}
\description{
  Updates/sets the covariance functions for \code{STmodel}
  objects. Used by \code{\link{createSTmodel}}.
}
\details{
  The covariance function is specified using lists for
  \code{cov.beta} and \code{cov.nu}. The lists should
  contain the following elements: \describe{
  \item{covf}{The type of covariance function(s), see
  \code{\link{namesCovFuns}}.} \item{nugget}{For the
  beta-fields: a vector of \code{TRUE}/\code{FALSE}
  indicating if each beta-field should contain a nugget.
  \cr For the nu-field: Either \code{TRUE}/\code{FALSE} for
  constant nugget/no nugget; a formula; or length=1
  character vector. For the latter two the nugget is
  allowed to vary as \code{exp(B*theta)} where: \cr
  \code{nugget = as.formula(paste("~", paste(cov.nu$nugget,
  collapse="+")))} \cr \code{ covars = model.frame(nugget,
  covars, drop.unused.levels=TRUE)} \cr \code{
  B=model.matrix(nugget, covars)} \cr \code{ B=as.matrix(B)
  } \cr The resulting regression matrix is stored as
  \code{STmodel$cov.nu$nugget.matrix} giving nugget for the
  observed locations. Unobserved locations are assumed to
  have a zero nugget.} \item{random.effect}{Only used for
  \code{cov.nu}, \code{TRUE}/\code{FALSE} indicating if a
  random.effect for the mean value should be included, see
  \code{\link{makeSigmaNu}}.} }
}
\examples{
##load the data
data(mesa.model)

##covariance specification:
cov.beta <- list(covf="exp", nugget=FALSE)
cov.nu <- list(covf="exp", nugget=TRUE, random.effect=FALSE)

##Simple covariance structure
updateCovf(mesa.model, cov.beta, cov.nu)

##different behaviour for different beta:s
cov.beta <- list(covf=c("exp","exp2","matern"), nugget=c(TRUE,FALSE,FALSE))
updateCovf(mesa.model, cov.beta, cov.nu)

##Spatially varying nugget
cov.nu <- list(covf="exp", nugget="type", random.effect=FALSE)
print(tmp <- updateCovf(mesa.model, cov.beta, cov.nu))
##lets study the regression matrix for the nugget
str(tmp$cov.nu$nugget.matrix)
head(tmp$cov.nu$nugget.matrix)
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other covariance functions: \code{\link{crossDist}},
  \code{\link{evalCovFuns}}, \code{\link{makeSigmaB}},
  \code{\link{makeSigmaNu}}, \code{\link{namesCovFuns}},
  \code{\link{parsCovFuns}}

  Other STmodel functions: \code{\link{createCV}},
  \code{\link{createDataMatrix}},
  \code{\link{createSTmodel}},
  \code{\link{dropObservations}},
  \code{\link{estimateBetaFields}},
  \code{\link{loglikeST}}, \code{\link{loglikeSTdim}},
  \code{\link{loglikeSTnaive}}, \code{\link{predictNaive}},
  \code{\link{processLocation}}, \code{\link{processLUR}},
  \code{\link{processST}}, \code{\link{updateSTdataTrend}},
  \code{\link{updateTrend}},
  \code{\link{updateTrend.STdata}},
  \code{\link{updateTrend.STmodel}}
}

