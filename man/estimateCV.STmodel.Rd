\name{estimateCV.STmodel}
\alias{estimateCV}
\alias{estimateCV.STmodel}
\alias{predictCV}
\alias{predictCV.STmodel}
\title{Cross-Validated Estimation and Prediction}
\usage{
  \method{estimateCV}{STmodel} (object, x, Ind.cv,
    control = list(trace = 3), verbose.res = FALSE, ...)

  estimateCV(object, x, Ind.cv, ...)

  \method{predictCV}{STmodel} (object, x, Ind.cv = NULL,
    ..., silent = TRUE, LTA = FALSE)

  predictCV(object, x, Ind.cv, ...)
}
\arguments{
  \item{object}{\code{STmodel} object for which to perform
  cross-validation.}

  \item{x}{Either a vector or matrix of starting point(s)
  for the optimisation, see \code{\link{estimate.STmodel}};
  or a matrix with parameters, the i:th row being used for
  prediction of the i:th cross-validation set. For
  prediction either a \code{estCVSTmodel} or
  \code{estimateSTmodel} object, results from
  \code{\link{estimateCV.STmodel}} or
  \code{\link{estimate.STmodel}}, can be used.}

  \item{Ind.cv}{\code{Ind.cv} defines the cross-validation
  scheme.  Either a (number or observations) - by -
  (groups) logical matrix or an \emph{integer valued}
  vector with length equal to (number or observations). For
  \code{predictCV.STmodel} \code{Ind.cv} can be infered
  from \code{x} if \code{x} is a \code{estCVSTmodel} object
  See further \code{\link{createCV}}.}

  \item{control}{A list of control parameters for the
  optimisation.  See \code{\link[stats:optim]{optim}} for
  details; setting \code{trace}=0 eliminates all ouput.}

  \item{verbose.res}{A \code{TRUE}/\code{FALSE} variable
  indicating if full results from
  \code{\link{estimate.STmodel}} for each CV group should
  be returned; defaults to \code{FALSE}}

  \item{...}{All additional parameters for
  \code{\link{estimate.STmodel}} or
  \code{\link{predict.STmodel}}.  For
  \code{\link{predict.STmodel}} a number of parameters are
  set in \code{predictCV.STmodel} and can \strong{NOT} be
  overriden, these are \code{nugget.unobs},
  \code{only.pars=FALSE}, and \code{combine.data=FALSE}.}

  \item{silent}{Show status after each iteration?}

  \item{LTA}{\code{TRUE}/\code{FALSE}, compute long-term
  temporal averages, similar to \code{\link{computeLTA}},
  but with the option of including the uncertainty; see
  \code{\link{predict.STmodel}}.}
}
\value{
  Either a \code{estCVSTmodel} object with elements:
  \item{status}{Data.frame with convergence information and
  best function value for each cross-validation group.}
  \item{Ind.cv}{The cross-validation grouping.}
  \item{x.fixed}{Fixed parameters in the estimation, see
  \code{\link{estimate.STmodel}}.} \item{x.init}{Matrix of
  inital values used, i.e. \code{x} from the input.}
  \item{par.all, par.cov}{Matrices with estimated
  parameters for each cross-validation group.}
  \item{par.all.sd, par.cov.sd}{Standard deviations
  computed from the Hessian/information matrix for set of
  estimated parameters.} \item{res.all}{Estimation results
  for each cross-validation group, contains the output from
  the \code{\link{estimate.STmodel}} calls, only included
  if \code{verbose.res=TRUE}.} Or a \code{predCVSTmodel}
  object with elements: \item{opts}{Copy of the \code{opts}
  field in the output from \code{\link{predict.STmodel}}.}
  \item{Ind.cv}{The cross-validation grouping.}
  \item{pred.obs}{A data.frame with a copy of observations
  from \code{object$obs}, predictions (for different model
  components), variances, and residuals. Variance field
  will be missing if \code{pred.var=FALSE}.}
  \item{pred.all}{A list with time-by-location data.frames
  containing predictions and variances for all space-time
  locations as well as predictions and variances for the
  beta-fields. Unobserved points are \code{NA} for the
  option \code{only.obs=TRUE}.}
}
\description{
  Functions that perform cross-validated parameter
  estimation and prediction for the spatio-temporal model.
}
\details{
  For \code{predictCV.STmodel} the parameters used to
  compute predictions for the left out observations can be
  either a single vector or a matrix. For a single vector
  the same parameter values will be used for all
  cross-validation predictions; for a matrix the parameters
  in \code{x[,i]} will be used for the predictions of the
  i:th cross-validation set (i.e. for \code{Ind.cv[,i]}).
  Suitable matrices are provided in the output from
  \code{estimateCV.STmodel}.

  The cross-validation groups are given by \code{Ind.cv}.
  \code{Ind.cv} should be either a (number of observations)
  - by - (groups) logical matrix or an \emph{integer
  valued} vector with length equal to (number of
  observations). If a matrix then each column defines a
  cross-validation set with the \code{TRUE} values marking
  the observations to be left out. If a vector then
  \code{1}:s denote observations to be dropped in the first
  cross-validation set, \code{2}:s observations to be
  dropped in the second set, etc. Observations marked by
  values \code{<=0} are never dropped. See
  \code{\link{createCV}} for details.
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
\author{
  Johan Lindstr�m
}
\seealso{
  Other cross-validation functions:
  \code{\link{computeLTA}}, \code{\link{createCV}},
  \code{\link{dropObservations}},
  \code{\link{predictNaive}}

  Other estCVSTmodel methods:
  \code{\link{boxplot.estCVSTmodel}},
  \code{\link{coef.estCVSTmodel}},
  \code{\link{print.estCVSTmodel}},
  \code{\link{print.summary.estCVSTmodel}},
  \code{\link{summary.estCVSTmodel}}

  Other predCVSTmodel functions: \code{\link{computeLTA}}

  Other predCVSTmodel methods:
  \code{\link{plot.predCVSTmodel}},
  \code{\link{plot.predictSTmodel}},
  \code{\link{print.predCVSTmodel}},
  \code{\link{print.summary.predCVSTmodel}},
  \code{\link{qqnorm.predCVSTmodel}},
  \code{\link{qqnorm.STdata}},
  \code{\link{qqnorm.STmodel}},
  \code{\link{scatterPlot.predCVSTmodel}},
  \code{\link{scatterPlot.STdata}},
  \code{\link{scatterPlot.STmodel}},
  \code{\link{summary.predCVSTmodel}}

  Other STmodel methods: \code{\link{c.STmodel}},
  \code{\link{createSTmodel}}, \code{\link{estimate}},
  \code{\link{estimate.STmodel}}, \code{\link{MCMC}},
  \code{\link{MCMC.STmodel}}, \code{\link{plot.STdata}},
  \code{\link{plot.STmodel}},
  \code{\link{predict.STmodel}},
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

