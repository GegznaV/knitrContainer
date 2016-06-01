# extract_and_print ----------------------------------------------------------------
# @param results Value for \code{knitr} chunk parameter \code{results}.
#  Default option is to set \code{results} to \code{asis}.


#' [!] Print objects from \code{knitrContainer}
#'
#'  Function is designed to be used in a \code{knitr} file which generates
#'  \code{HTML} output.\cr
#'  The function takes every element (i.e., object) of a
#'  \code{knitrContainer}, prints it appropriately:
#'  either as text (using \code{\link[base]{cat}}),
#'  as htmlwidget (using \code{\link[base]{cat}}) or object as-is using
#'  \code{\link[base]{print}}. Then attaches \code{HTML} dependencies for
#'  \code{\link[htmlwidgets]{htmlwidgets}} to show them correctly.
#'
#' @details
#' Functions \code{extract_and_print()} and \code{print_objects()} are aliases.
#'
#' @template container
#' @param ... not used.
#' @export
#'
#' @examples
#'
#' # Find examples in link `knitrContainer-class`
#'
#' @author Vilmantas Gegzna
#' @family \code{knitrContainer} functions
#'
extract_and_print <- function(container, ...) {
    if (length(container)==0) {
        stop("*** knitrContainer is empty!!! ***")
    }

    # Print ===================================================================
    # Extract and print all of the content
    for(j in 1:length(container)){
        x <- container[[j]]

        #  we know only character and htmlwidget in this case
        #   if more need to handle appropriately
        cat("  \n")
        if (inherits(x,"character") & added_as(x)!= "As is"){
            # noquote critical here also turn off auto.asis very important
            noquote(paste0(x, collapse="\n")) %>% cat
        } else  if (inherits(x,"htmlwidget")) {
            # print the html piece of the htmlwidgets
            htmltools::renderTags(x)$html %>% cat
        } else {
            # Remove aattribute "added_as" to prevent from printing it
            attributes(x)$added_as <- NULL
            # Print
            print(x)
        }
        cat("\n\n  ")
    }

    # Attach the Dependencies ================================================
    # since they do not get included with renderTags(...)$html

    # Find the htmlwidgets
    widget_obj <- Filter(function(x){inherits(x,'htmlwidget')},container)

    # Extract dependencies
    list_dependencies <- function(hw){htmltools::renderTags(hw)$dependencies}
    deps <- lapply(widget_obj, list_dependencies)

    # Attach dependencies
    htmltools::attachDependencies(
        htmltools::tagList(),
        unlist(deps,recursive=FALSE))
}

#  ------------------------------------------------------------------------
#' @export
#' @rdname extract_and_print
print_objects <- function(container, ...){
    extract_and_print(container, ...)
}
#  ------------------------------------------------------------------------
# %>% knitr::asis_output(.)