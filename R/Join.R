# Join - merge containers ----------------------------------------------------

#' [!] Merge objects to `knitrContainer`
#'
#' \code{Join} converts objects to \code{knitrContainer} objects
#' (method "as is") and \bold{merges} them to one container.
#' @param ... objects to be merged.
#' @param list objects to be merged provided as a list.
#' @return knitrContainer
#' @export
#'
#' @examples
#'
#' # Find examples in link `knitrContainer-class`
#'
#' @author Vilmantas Gegzna
#' @family \code{knitrContainer} functions
#'
Join <- function(..., list = NULL) {

    if (is.null(list)) list <- list(...)

    # Convert non `knitrContainers` to `knitrContainers`
    list <- lapply(list, function(obj){
            if (!inherits(obj, "knitrContainer")){
                obj <- as.knitrContainer(obj)
            } else {
                obj
            }
        }
    )

    # Merge and return the result

    list %<>% Reduce(c,.) %>% as.knitrContainer

    return(list)
}
