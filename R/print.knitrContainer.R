# print ------------------------------------------------------------------------

#' @name print
#' @title Print and summary methods for \code{knitrContainer}
#' @description Print summary of \code{knitrContainer} object.
#'
#' @param x \code{knitrContainer} object.
#' @param n The number of rows (objects) to display. Default \code{n = 30}.
#' @param preview length of text (number of characters) to be previewed in summary.
#' Default is 25.
#' @inheritParams utils::object.size
#'
#' @export
#' @method print knitrContainer
#'
#' @examples
#'
#' # Find examples in link `knitrContainer-class`
#'
#' @author Vilmantas Gegzna
#' @family \code{knitrContainer} functions
#'
print.knitrContainer <- function(x, n = 30, preview = 25, units = "Kb", ...){
    summary(x, n = n, preview = preview, units = units)
}

