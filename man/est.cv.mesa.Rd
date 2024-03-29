\docType{data}
\name{est.cv.mesa}
\alias{est.cv.mesa}
\alias{pred.cv.mesa}
\title{Example of \code{estCVSTmodel} and \code{predCVSTmodel} structures}
\format{A list with elements, see the return description in
  \code{\link{estimateCV.STmodel}} and \code{\link{predictCV.STmodel}}.}
\source{
  Contains parametere estimates for the Spatio-Temporal
  model applied to monitoring data from the \strong{MESA
  Air} project, see Cohen et.al. (2009) and
  \code{\link{mesa.data.raw}} for details.
}
\description{
  Example of 10-fold cross-validated for the model in
  \code{\link{mesa.model}} using
  \code{\link{estimateCV.STmodel}} and
  \code{\link{predictCV.STmodel}}.
}
\examples{
##load data
data(mesa.model)
data(est.mesa.model)

################
## estimateCV ##
################
##create the CV structure defining 10 different CV-groups
Ind.cv <- createCV(mesa.model, groups=10, min.dist=.1)

##use the best parameters and there starting values as
x.init <- coef(est.mesa.model, pars="cov")[,c("par","init")]

\dontrun{
  ##estimate different parameters for each CV-group
  est.cv.mesa <- estimateCV(mesa.model, x.init, Ind.cv)
}
##lets load precomputed results instead
data(est.cv.mesa)

##examine the estimation results
print( est.cv.mesa )
##estimated parameters for each CV-group
coef(est.cv.mesa, pars="cov")

###############
## predictCV ##
###############
\dontrun{
  ##Do cross-validated predictions using the just estimated parameters
  ##Ind.cv is infered from est.cv.mesa as est.cv.mesa$Ind.cv
  pred.cv.mesa <- predictCV(mesa.model, est.cv.mesa, LTA=TRUE)
}
##lets load precomputed results instead
data(pred.cv.mesa)

##prediction results
print( pred.cv.mesa )

##and CV-statistics
print( summary( pred.cv.mesa, LTA=TRUE) )


\dontrun{
  ##A faster option is to only consider the observations and not to compute
  ##variances
  pred.cv.fast <- predictCV(mesa.model, est.cv.mesa, only.obs=TRUE,
                            pred.var=FALSE)
  print( pred.cv.fast )
  summary( pred.cv.fast )
}
}
\references{
  M. A. Cohen, S. D. Adar, R. W. Allen, E. Avol, C. L.
  Curl, T.  Gould, D. Hardie, A. Ho, P. Kinney, T. V.
  Larson, P. D. Sampson, L.  Sheppard, K. D. Stukovsky, S.
  S. Swan, L. S. Liu, J. D. Kaufman. (2009) Approach to
  Estimating Participant Pollutant Exposures in the
  Multi-Ethnic Study of Atherosclerosis and Air Pollution
  (MESA Air). Environmental Science & Technology: 43(13),
  4687-4693.
}
\seealso{
  \code{\link{estimateCV.STmodel}} and
  \code{\link{predictCV.STmodel}} for cross-validation.
  \cr \code{\link{createSTmodel}} for creation of the
  originating \code{STmodel} object.

  Other example data: \code{\link{est.mesa.model}},
  \code{\link{MCMC.mesa.model}},
  \code{\link{mesa.data.raw}}, \code{\link{mesa.model}},
  \code{\link{pred.mesa.model}}
}
\keyword{datasets}

