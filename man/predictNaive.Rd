\name{predictNaive}
\alias{predictNaive}
\title{Naive Temporal Predictions}
\usage{
  predictNaive(STmodel, locations = NULL, type = NULL)
}
\arguments{
  \item{STmodel}{\code{STmodel} object for which to compute
  simple predictions.}

  \item{locations}{Locations on which to base the naive
  predictions.}

  \item{type}{The type of sites to base the predictions on,
  uses the (optional) field \code{STmodel$locations$type}.}
}
\value{
  A list with items: \item{pred}{A (number of observations)
  - by - (6) data.frame containing the four naive
  predictions described under \code{details}, along with
  dates and IDs.} \item{locations}{The locations used for
  the naive predictions.}
}
\description{
  Computes naive predictions that are based on a few sites.
  These predictions can then be used, e.g. in
  \code{\link{summary.predCVSTmodel}}, to evaluate how much
  better the spatial-temporal model performs compared to
  simple (temporal) predictions. \cr The function requires
  one of \code{location} and \code{type} to be specified,
  if both are given \code{location} \emph{will be used
  over} \code{type}. If \code{type} is given locations such
  that \cr \code{as.character(STmodel$locations$type) %in%
  type} \cr will be used.
}
\details{
  Given a set of locations the function computes 4 sets of
  naive prediction for the observations in \code{STmodel}:
  \describe{ \item{smooth.fixed}{The smooth trend in
  \code{STmodel$trend} is fit to \emph{all} observations at
  the sites in \code{locations} using a linear regression.
  The resulting smooth is used as a naive prediction for
  all locations.} \item{avg.fixed}{The temporal average
  over sites in \code{locations} is used as a naive
  prediction.} \item{smooth.closest.fixed}{This fits the
  smooth trend in \code{STmodel$trend} to each site in
  \code{locations}; using the smooth at the closest fixed
  site as a naive prediction.} \item{closest.fixed}{This
  uses the observations at the closest site in
  \code{locations} to predict observations at all other
  sites.} }
}
\examples{
##load data
data(mesa.model)

##naive predictions based on either AQS,
pred.aqs <- predictNaive(mesa.model, type="AQS")
##...or only one sites,
pred.1site <- predictNaive(mesa.model, locations="60372005")

##plot the predictions - The two cases that are constant in space
par(mfcol=c(2,1), mar=c(4.5,4.5,1,.5))

##observations as a function of date
plot(mesa.model, "loc.obs", type=as.factor(mesa.model$locations$ID),
     legend.loc=NULL, pch=19, cex=.25)
##Add the predictions based on the smooth fitted to all sites
with(pred.aqs$pred, lines(date, smooth.fixed, col=1, lwd=2) )
with(pred.1site$pred, lines(date, smooth.fixed, col=2, lwd=2) )

##plot the predictions - One of the cases that vary in space, i.e. the smooth
##fit to the closest site.
##first extract as a data matrix
D <- with(pred.aqs$pred, createDataMatrix(obs=smooth.closest.fixed,
                                          date=date, ID=ID) )

##observations as a function of date
##(only five sites for clarity)
mesa.model <- dropObservations(mesa.model, !(mesa.model$obs$idx \%in\% c(1,2,3,23,24)))
plot(mesa.model, "loc.obs", type=as.factor(mesa.model$locations$ID),
     legend.loc=NULL, pch=19, cex=.25)
##Add the predictions based on the smooth
##fitted to the closest site
for(i in 1:5){
  lines(as.Date(rownames(D)), D[,mesa.model$locations$ID[i]], col=i, lwd=2)
}
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other cross-validation functions:
  \code{\link{computeLTA}}, \code{\link{createCV}},
  \code{\link{dropObservations}}, \code{\link{estimateCV}},
  \code{\link{estimateCV.STmodel}},
  \code{\link{predictCV}}, \code{\link{predictCV.STmodel}}

  Other STmodel functions: \code{\link{createCV}},
  \code{\link{createDataMatrix}},
  \code{\link{createSTmodel}},
  \code{\link{dropObservations}},
  \code{\link{estimateBetaFields}},
  \code{\link{loglikeST}}, \code{\link{loglikeSTdim}},
  \code{\link{loglikeSTnaive}},
  \code{\link{processLocation}}, \code{\link{processLUR}},
  \code{\link{processST}}, \code{\link{updateCovf}},
  \code{\link{updateSTdataTrend}},
  \code{\link{updateTrend}},
  \code{\link{updateTrend.STdata}},
  \code{\link{updateTrend.STmodel}}
}

