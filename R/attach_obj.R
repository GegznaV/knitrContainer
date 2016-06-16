
#' Attach an object to the end of a list
#'
#' @param x A list.
#' @param obj An object to be attached as the last element of the
#' list \code{x}.
#'
#' @return The list \code{x} with \code{obj} attached as its
#'         last and unnamed element.
#' @export
#'
#' @examples
#'
#' l <- list(a = 1, b = 2)
#' attach_obj(l, obj = 3)
#'  #> $a
#'  #> [1] 1
#'  #>
#'  #> $b
#'  #> [1] 2
#'  #>
#'  #> [[3]]
#'  #> [1] 3
#'
#'
attach_obj <- function(x = list(), obj){
    force(x)
    if (is.null(obj)) {
        warning("Variale `obj` is NULL! It was not attached to the list.")
        return(x)
    }
    x[[length(x) + 1]] <- obj
    return(x)
}
