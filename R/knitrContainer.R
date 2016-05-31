
#' @name knitrContainer
#' @title Create, test and convert to `knitrContainer` object
#'
#' @description
#' \code{knitrContainer()} - creates a new empty \code{knitrContainer} object.
#'
#' \code{is.knitrContainer()} - tests if class of an object is object
#'                             \code{knitrContainer()}.
#'
#' \code{as.knitrContainer()} - converts an object to \code{knitrContainer}.
#'  More specifically:\cr
#' for list - only the class attribute is added,\cr
#' for other objects - firstly an object is inctluded into list by
#' \code{list(object)} and then class attribute is added;\cr
#' for \code{knitrContainer} objects - they are returned as-is.
#'
#' @export
#'
#' @examples
#'
#' # Find examples in link `knitrContainer-class`
#'
#' @author Vilmantas Gegzna
#' @family \code{knitrContainer} functions
knitrContainer <- function(){
    container <- list()
    # container <- htmltools::tagList()
    class(container) <- c("knitrContainer", setdiff(class(container), "knitrContainer"))
    return(container)
}


# @param knitr.auto.asis Value for \pkg{pander} parameter \code{knitr.auto.asis}.
    # knitr::opts_chunk$set(results = results)
    # results = 'asis'
    # , knitr.auto.asis = FALSE
