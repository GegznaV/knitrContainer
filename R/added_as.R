# added_as ----------------------------------------------------------------

#' [!!!] Set or get attribute `added_as`
#'
#' Function either returns value of `attributes(obj)$added_as` (if TYPE is not provided)
#' OR
#' returns updated `obj` with addedd attribute if both  conditions are fulfilled:
#'     `TYPE` is provided and attribute is `NULL`. otherwise returns `obj` intact. \cr
#'
#' If force.TYPE == TRUE, new value of `TYPE` will be added any way.
#'
#' @param obj An object to be updated
#' @param TYPE string to be added as attribute \code{$added_as} if
#'             \code{$added_as} is not already present.
#' @param force.TYPE Logical. If \code{TRUE}, value of attribute \code{$added_as}
#'             is added or replaced even if \code{obj} already has it.
#'
#' @export
#'
#' @examples
#'
#' # [NO EXAMPLES YET]
#'
#' @author Vilmantas Gegzna
#'
added_as <- function(obj, TYPE = NULL, force.TYPE = FALSE){
    contained_TYPE <- attributes(obj)$added_as

    # Define supported types
    # TYPE <- match.arg(TYPE, c("As is", ...)

    if (is.null(TYPE))  {
        return(contained_TYPE)

    } else if (is.null(contained_TYPE) | force.TYPE == TRUE) {
        attributes(obj)$added_as <- TYPE
    }
    return(obj)
}
