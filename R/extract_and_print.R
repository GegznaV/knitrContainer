# extract_and_print ----------------------------------------------------------------
# @param results Value for \code{knitr} chunk parameter \code{results}.
#  Default option is to set \code{results} to \code{asis}.


#' [!] Print objects from \code{knitrContainer}
#'
#'  Function is designed to be used in a \code{knitr}/\code{rmarkdown} file
#'  which generates \code{HTML} output.\cr
#'  The function takes every element (i.e., object) of a
#'  \code{knitrContainer}, prints it appropriately:
#'  either as text (using \code{\link[base]{cat}}),
#'  as htmlwidget (using \code{\link[base]{cat}}) or object as-is using
#'  \code{\link[base]{print}}. Then attaches \code{HTML} dependencies for
#'  \code{\link[htmlwidgets]{htmlwidgets}} to show them correctly.
#'
#' @details
#' Functions \code{extract_and_print()} and \code{print_objects()} are aliases.
#' function \code{print_objects()} is deprecated.
#'
#' @template container
#' @param env Environment in which evaluation of expressions an assignments
#' (objects added with \code{\link{add_as_code}} and \code{\link{add_as_data}})
#' take place.
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
extract_and_print <- function(container, env = parent.frame(), ...) {
    # STOP if:

    # -- if container inherits incorrectly
    if(!inherits(container, "knitrContainer"))
        stop("Class of `container` must be `knitrContainer`.")

    # -- If container is emply
    if (length(container)==0) {
        warning("*** knitrContainer is empty!!! ***")
        return(NULL)
    }

    # Print ===================================================================
    # Extract and print all of the content
    for(j in 1:length(container)){
        x <- container[[j]]


        switch(added_as(x),
           # If x is a code-to-evaluate, evaluate it
           # "Code to evaluate" = {
           "Code to eval." = {

               if (is.character(x)) {
                   eval(parse(text = x), envir = env)
               # } else if (is.call(x)) {
               #     eval(x, envir = env)
               } else {
                   warning(sprintf(paste(
                       "Object nr. %d is not a string (its class is: %s).",
                       "Thus it was not evaluated."),
                       j, paste(class(x), collapse = " ,")))
               }

               next()
            },
           #  ------------------------------------------------------------------------
           # If x is added as data
           "Data" = {
               NAME <- as.character(attributes(x)$name)

                # Strip off unnecessary attributes
                attributes(x)$added_as <- NULL
                attributes(x)$name     <- NULL

                # Evaluate/assign
                assign(NAME, value = x, envir = env)

                # Clear NAME
                rm(NAME)
                next()
           },


           #  ------------------------------------------------------------------------
            # If other kind of object: print it
            #
            #  Known types of objects 'character', 'htmlwidget' and objects
            #  added as-is.
            #
            #  If more types are need, following piece of code should be extended
            #  to handle appropriately.
           {
                cat("  \n")

                if (inherits(x, "character") & added_as(x)!= "As is"){
                    # noquote critical here also turn off auto.asis very important
                    noquote(paste0(x, collapse = "\n")) %>% cat

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
        ) #end switch
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
    .Deprecated("extract_and_print")
    extract_and_print(container, ...)
}
#  ------------------------------------------------------------------------
# %>% knitr::asis_output(.)
