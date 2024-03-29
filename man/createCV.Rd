\name{createCV}
\alias{createCV}
\title{Define Cross-Validation Groups}
\usage{
  createCV(STmodel, groups = 10, min.dist = 0.1,
    random = FALSE, subset = NA,
    option = c("all", "fixed", "comco", "snapshot", "home"),
    Icv.vector = TRUE)
}
\arguments{
  \item{STmodel}{Model object for which to determine
  cross-validation.}

  \item{groups}{Number of cross-validation groups, zero
  gives leave-one-out cross-validation.}

  \item{min.dist}{Minimum distance between locations for
  them to end up in separate groups. Points closer than
  \code{min.dist} will be forced into the same group. A
  high value for \code{min.dist} can result in fewer
  cross-validation groups than specified in \code{groups}.}

  \item{random}{If \code{FALSE} repeated calls to the
  function will return the same grouping, if \code{TRUE}
  repeated calls will give different CV-groupings. Ensures
  that simulation studies are reproducable.}

  \item{subset}{A subset of locations for which to define
  the cross-validation setup. Only sites listed in
  \code{subset} are dropped from one of the
  cross-validation groups; in other words sites \emph{not
  in} \code{subset} are used for estimation and preidiction
  of \emph{all} cross-validation groups. This option is
  \emph{ignored} if \code{option!="all"}.}

  \item{option}{For internal MESA Air usage, see Details
  below.}

  \item{Icv.vector}{Attempt to return a vector instead of a
  matrix. If the same observation is in several groups a
  matrix will still be returned.}
}
\value{
  Return a vector, with each element giving the CV-group
  (as an integer) of each observation; Or a (number or
  observations) - by - (groups) logical matrix; each column
  defines a cross-validation set with the \code{TRUE}
  values marking the observations to be left out.
}
\description{
  Creates a matrix that specifies cross-validation schemes.
}
\details{
  The number of observations left out of each group can be
  rather uneven; the main goal of \code{createCV} is to
  create CV-groups such that the groups contain roughly the
  same \emph{number of locations} ignoring the number of
  observations at each location. If there are large
  differences in the number of observations at differnt
  locations one could use the \code{subset} option to
  create different CV-groupings for different types of
  locations. If \code{Icv.vector=FALSE}, the groups can
  then be combined as \cr \code{I.final = I.1 | I.2 | I.3}.

  The \code{option} input determines which sites to include
  in the cross-validation. Possible options are
  \code{"all"}, \code{"fixed"}, \code{"comco"},
  \code{"snapshot"} and \code{"home"}. \describe{
  \item{all}{Uses all available sites, possibly subset
  according to \code{subset}. The sites will be grouped
  with sites seperated by less than \code{min.dist} being
  put in the same CV-group.} \item{fixed}{Uses only sites
  that have \cr \code{STmodel$locations$type \%in\%
  c("AQS","FIXED")}.  Given the subsettting the sites will
  be grouped as for \code{all}.} \item{home}{Uses only
  sites that have \cr \code{STmodel$locations$type \%in\%
  c("HOME")}.  Given the subsettting the sites will be
  grouped as for \code{all}.} \item{comco}{Uses only sites
  that have \cr \code{STmodel$locations$type \%in\%
  c("COMCO")}.  The sites will be grouped together if they
  are from the same road gradient. The road gradients are
  grouped by studying the name of the sites. With "?"
  denoting one or more letters and "#" denoting one or more
  digits the names are expected to follow "?-?#?#", for
  random sites, and "?-?#?#?" for the gradients (with all
  but the last letter being the same for the entire
  gradient).} }
}
\examples{
##load the data
data(mesa.model)

##create a matrix with the CV-schemes
I.cv <- createCV(mesa.model, groups=10)

##number of observations in each CV-group
table(I.cv)

##Which sites belong to which groups?
ID.cv <- sapply(split(mesa.model$obs$ID, I.cv),unique)
print(ID.cv)

##Note that the sites with distance 0.084<min.dist 
##are grouped together (in group 10).
mesa.model$D.beta[ID.cv[[10]], ID.cv[[10]]]

##Find out which location belongs to which cv group
I.col <- apply(sapply(ID.cv,function(x) mesa.model$locations$ID
               \%in\% x), 1, function(x) if(sum(x)==1) which(x) else 0)
names(I.col) <- mesa.model$locations$ID
print(I.col)

##Plot the locations, colour coded by CV-grouping
plot(mesa.model$locations$long, mesa.model$locations$lat,
     pch=23+floor(I.col/max(I.col)+.5), bg=I.col, 
     xlab="Longitude", ylab="Latitude")

###############################################################
## Using matrix representation of cross-validation structure ##
###############################################################

##create a matrix with the CV-schemes
I.cv <- createCV(mesa.model, groups=10, Icv.vector=FALSE)

##number of observations in each CV-group
colSums(I.cv)

##Which sites belong to which groups?
ID.cv <- apply(I.cv, 2, function(x){ unique(mesa.model$obs$ID[x]) })

##and then as above...
}
\author{
  Johan Lindstr�m
}
\seealso{
  Other cross-validation functions:
  \code{\link{computeLTA}}, \code{\link{dropObservations}},
  \code{\link{estimateCV}},
  \code{\link{estimateCV.STmodel}},
  \code{\link{predictCV}}, \code{\link{predictCV.STmodel}},
  \code{\link{predictNaive}}

  Other STmodel functions: \code{\link{createDataMatrix}},
  \code{\link{createSTmodel}},
  \code{\link{dropObservations}},
  \code{\link{estimateBetaFields}},
  \code{\link{loglikeST}}, \code{\link{loglikeSTdim}},
  \code{\link{loglikeSTnaive}}, \code{\link{predictNaive}},
  \code{\link{processLocation}}, \code{\link{processLUR}},
  \code{\link{processST}}, \code{\link{updateCovf}},
  \code{\link{updateSTdataTrend}},
  \code{\link{updateTrend}},
  \code{\link{updateTrend.STdata}},
  \code{\link{updateTrend.STmodel}}
}

