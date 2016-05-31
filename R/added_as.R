# INTERNAL FUNCTION

# added_as ----------------------------------------------------------------

# @author Vilmantas Gegzna
# @family \code{knitrContainer} functions

# Function either returns value of  `attributes(obj)$added_as` (if TYPE is not provided)
# OR
# returns updated `obj` with addedd attribute if both  conditions are fulfilled:
# `TYPE` is provided and attribute is `NULL`. otherwise returns `obj` intact.
#
# If force.TYPE == TRUE, new value of `TYPE` will be added any way.
#
#
# obj - object to be updated
# TYPE - attribute to  be added as `$added_as` if `$added_as` is not already present.
# force.TYPE - logical. If TRUE, new type is added despite the fact, that `obj`
#               already has it.
# @export
added_as <- function(obj, TYPE = NULL, force.TYPE = FALSE){
    contained_TYPE <- attributes(obj)$added_as

    # TYPE <- match.arg(TYPE, c("As is", ...)

    if (is.null(TYPE))  {
        return(contained_TYPE)

    } else if (is.null(contained_TYPE) | force.TYPE == TRUE)   {
        attributes(obj)$added_as <- TYPE
    }
    return(obj)
}



#' setClass("knitrContainer")
#'
#' #' @name Merge `knitrContainer` objects
#' #'
#' #' @rdname Merge `knitrContainer` objects
#' #' @aliases c,knitrContainer-method c
#' #' @export
#' setMethod("c",
#'           signature("knitrContainer"),
#'           function(...) {
#'               as.knitrContainer(c(...))
#'           }
#' )
#'
#' #' @rdname Merge `knitrContainer` objects
#' #' @aliases +,knitrContainer,knitrContainer-method
#' #' @export
#' setMethod("+",
#'           signature(e1 = "knitrContainer", e2 = "knitrContainer"),
#'           function(e1, e2) {
#'               as.knitrContainer(c(e1, e2))
#' })



#  ------------------------------------------------------------------------

#
#         if(inherits(x,"character")){
#             # noquote critical here  also turn off auto.asis very important
#             noquote(paste0(x, collapse="\n")) %>% cat(.)
#
#         } else  if (inherits(x,"htmlwidget")) {
#             # print the html piece of the htmlwidgets
#             htmltools::renderTags(x)$html  %>% cat(.)
#         } else {
#             cat("\n");print(x);cat("\n")
#         }
