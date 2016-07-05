#' @name knitrContainer-package
#' @docType package
#' @title Collect and Print Multiple Objects in a \code{Knitr} R Markdown Report
#'
#' @description
#' The purpose of \code{knitrContainer} is to collect objects (\bold{especially}
#' ones generated in a loop) and print them in a \code{knitr}/\code{rmarkdown}
#' report.\cr
#'
#'  WHY? Some objects such as \code{pander} tables and \code{plotly} plots,
#'  are not printed from inside a loop and are not displayed in `knitr` reports.
#' `knitrContainer` solves this problem by providing convenience
#' functions to get these objects printed and included in \code{HTML} files.
#'
#' @section Objects:
#' \bold{What objects can be collectd and printed with \code{knitrContainer}?}\cr
#'
#'  An object used by \code{knitrContainer} can be any object, that is
#' includible in an R list and that is printable, such as:
#' \itemize{
#'
#' \item{objects printable with \pkg{pander}
#'      (\href{http://rapporter.github.io/pander/}{pander: An R Pandoc Writer},
#'      \code{\link[pander]{pander}});}
#'
#' \item{\pkg{ggplot2} (\href{http://ggplot2.org/}{ggplot2 is a plotting system},
#'      \code{\link[ggplot2]{ggplot}});}
#'
#' \item{\pkg{plotly} (\href{https://plot.ly/r/}{Plotly R Library},
#'      \code{\link[plotly]{plot_ly}});}
#'
#' \item{text, strings;}
#'
#' \item{etc.}
#' }
#'
#' @seealso
#' \href{https://github.com/GegznaV/knitrContainer}{\code{knitrContainer}'s gitHub repository}.
#'
#' @references
#' Some ideas for functions in \code{knitrContainer} package are taken from
#'  \href{https://github.com/ropensci/plotly/issues/273#issuecomment-217982315}{this answer} on github.com.
#'
#' @author Vilmantas Gegzna
#'
#' @import magrittr
#' @importFrom utils capture.output object.size

NULL
#> NULL

# \code{\link{}} \cr
# \code{\link{}} \cr
# \code{\link{}} \cr
# \code{\link{}} \cr
# \code{\link{}} \cr
# \code{\link{}} \cr
# \code{\link{}} \cr
# \code{\link{}} \cr
# @importFrom tidyr '%>%'
#
# [![Issue Stats](http://issuestats.com/github/GegznaV/knitrContainer/badge/pr?style=flat)](http://issuestats.com/github/GegznaV/knitrContainer)
#
# [![Issue Stats](http://issuestats.com/github/GegznaV/knitrContainer/badge/issue?style=flat)](http://issuestats.com/github/GegznaV/knitrContainer)