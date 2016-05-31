# @param knitr.auto.asis Value for \pkg{pander} parameter \code{knitr.auto.asis}.

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
#'
#'
#' @export
#'
#' @examples
#'
#' # Find examples in link `knitrContainer-class`
#'
#' @author Vilmantas Gegzna
#' @family \code{knitrContainer} functions
knitrContainer <- function(
    # results = 'asis'
    # , knitr.auto.asis = FALSE
){
    # knitr::opts_chunk$set(results = results)

    container <- list()
    # container <- htmltools::tagList()
    class(container) <- c("knitrContainer", setdiff(class(container), "knitrContainer"))
    return(container)
}

# is.knitrContainer --------------------------------------------------------------------

#' @rdname knitrContainer
#' @param obj object to be tested or converted to \code{knitrContainer} object.
#'
#' @export
is.knitrContainer <- function(obj){
    inherits(obj, "knitrContainer")
}

# as.knitrContainer --------------------------------------------------------------------
#
#' @rdname knitrContainer
#' @param ... arguments to be passed to function \code{knitrContainer}.
#' @export
#
as.knitrContainer <- function(obj = NULL, ...){
    if (is.null(obj)) obj <- knitrContainer(...)

    # If NOT a container and NOT a list
    if (!inherits(obj, c("knitrContainer","list"))){
        obj <- added_as(obj, "As is")
        obj <- list(obj)
    }

    # Add class attribute for list
    if (inherits(obj, c("list"))){
        class(obj)  <-  c("knitrContainer", setdiff(class(obj), "knitrContainer"))
    }

    if (inherits(obj,"knitrContainer")) {
        return(obj)
    } else {
        stop(paste("Object of class ",
                   paste(class(obj), collapse = ", "),
                   "can not be converted to class 'knitrContainer'."))
    }
}
