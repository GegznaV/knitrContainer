# is.knitrContainer --------------------------------------------------------------------

#' @rdname knitrContainer
#' @param obj object to be tested or converted to \code{knitrContainer} object.
#'
#' @export
is.knitrContainer <- function(obj){
    inherits(obj, "knitrContainer")
}

