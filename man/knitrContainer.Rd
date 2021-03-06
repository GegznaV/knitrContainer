% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/as.knitrContainer.R, R/is.knitrContainer.R,
%   R/knitrContainer-function.R
\name{as.knitrContainer}
\alias{as.knitrContainer}
\alias{is.knitrContainer}
\alias{knitrContainer}
\title{Create, test and convert to `knitrContainer` object}
\usage{
as.knitrContainer(obj = NULL)

is.knitrContainer(obj)

knitrContainer()
}
\arguments{
\item{obj}{object to be tested or converted to \code{knitrContainer} object.}
}
\description{
\code{knitrContainer()} - creates a new empty \code{knitrContainer} object.

\code{is.knitrContainer()} - tests if class of an object is object
                            \code{knitrContainer()}.

\code{as.knitrContainer()} - converts an object to \code{knitrContainer}.
 More specifically:\cr
for list - only the class attribute is added,\cr
for other objects - firstly an object is inctluded into list by
\code{list(object)} and then class attribute is added;\cr
for \code{knitrContainer} objects - they are returned as-is.
}
\examples{

# Find examples in link `knitrContainer-class`

}
\seealso{
Other \code{knitrContainer} functions: \code{\link{Join}},
  \code{\link{add_as_heading}}, \code{\link{add_as_}},
  \code{\link{knitrContainer-class}},
  \code{\link{print_all}}, \code{\link{print}},
  \code{\link{summary}}
}
\author{
Vilmantas Gegzna
}
