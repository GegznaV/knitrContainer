# print_all ----------------------------------------------------------------
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
#' Functions \code{print_objects()} and \code{extract_and_print()} are deprecated.
#'
#' @template container
#' @param env Environment in which evaluation of expressions an assignments
#' (objects added with \code{\link{add_as_cmd}} and \code{\link{add_as_data}})
#' take place.
#' @param print_widget Should htmlwidget be printed as an object(\code{TRUE})
#'                     or not as html code (\code{FALSE} (default)).
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
print_all <- function(container, env = parent.frame(), print_widget = FALSE, ...){
    # # Warn if `knitr` code chunk option is not "asis"\
    # if (knitr::opts_current$get("results") != "asis")
    #     warning(paste('The option "results" of current chunk is not "asis".',
    #                   'The output might be incorrect.',
    #                   'Use option `results = "asis"`'))

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
           # If x is a command (code-to-evaluate), evaluate it
           "Command" = {
               if (is.character(x)) {
                   eval(parse(text = x), envir = env)
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
               NAME <- as.character(attributes(x)$NameOfDataset)

                # Strip off unnecessary attributes
                attributes(x)$added_as      <- NULL
                attributes(x)$NameOfDataset <- NULL

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
                cat("\n")
                # cat("  \n")

                if (inherits(x, "character") & added_as(x)!= "As is"){
                    # noquote critical here also turn off auto.asis very important
                    noquote(paste0(x, collapse = "\n")) %>% cat

                } else if (inherits(x,"htmlwidget")) {
                    if (print_widget == FALSE){
                        # print the html piece of the htmlwidgets
                        htmltools::renderTags(x)$html %>% cat
                    } else {
                        print(x)
                    }

                } else {
                    # Remove attribute "added_as" to prevent from printing it
                    attributes(x)$added_as <- NULL
                    # Print
                    print(x)
                }
                cat("\n\n")
                # cat("\n\n  ")
           }
        ) #end switch
    }

    # Attach the Dependencies ================================================
    # since they do not get included with renderTags(...)$html

    # Find the htmlwidgets
    widget_objs <- Filter(function(x){inherits(x,'htmlwidget')},container)

    # Extract dependencies
    list_dependencies <- function(hw){htmltools::renderTags(hw)$dependencies}
    deps <- lapply(widget_objs, list_dependencies)

    # Attach dependencies
    htmltools::attachDependencies(
        htmltools::tagList(),
        unlist(deps,recursive=FALSE))
}

#  ------------------------------------------------------------------------
#' @export
#' @rdname print_all
extract_and_print <- function(container, env = parent.frame(), ...) {
    .Deprecated("print_all")
    print_all(container, env = env, ...)
}

#  ------------------------------------------------------------------------
#' @export
#' @rdname print_all
print_objects <- function(container, env = parent.frame(), ...){
    .Deprecated("print_all")
    print_all(container, env = env, ...)
}
#  ------------------------------------------------------------------------
# %>% knitr::asis_output(.)
