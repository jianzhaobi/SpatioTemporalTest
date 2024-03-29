\name{createLUR}
\alias{createLUR}
\alias{createST}
\title{Add Covariate Fields to \code{STdata} Object.}
\usage{
  createLUR(STdata, LUR.list)

  createST(STdata, ST.list)
}
\arguments{
  \item{STdata}{\code{STdata} object with observations,
  covariates, trends, etc; see
  \code{\link{mesa.data.raw}}.}

  \item{LUR.list}{specification of covariates; e.g. output
  from \code{\link{processLUR}}.}

  \item{ST.list}{specification of spatio-temporal
  covariates; e.g. output from \code{\link{processST}}.}
}
\value{
  \code{STdata} with added fields \code{LUR}, or \code{ST}
  and \code{ST.all}.
}
\description{
  Extracts the requested geographic and spatio-temporal
  covariates from a \code{STmodel} object and formats them
  into suitable matrices. For \strong{INTERNAL} use by
  \code{\link{createSTmodel}}
}
\author{
  Johan Lindstr�m
}

