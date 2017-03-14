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
#' @param widget_as_html (TURE, FALSE, "auto") Should htmlwidget be printed as
#'        an HTML code or as an object (default is \code{"auto"}).
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
print_all <- function(container, env = parent.frame(), widget_as_html = "auto", ...){

    # Warn if `knitr` code chunk option is not "asis"\
    knitr_rez <- knitr::opts_current$get("results")
    inside_knitr <- !is.null(knitr_rez)

    if (inside_knitr & !identical(knitr_rez,"asis")){
        warning(
            paste0('\nThe option "results" of the current knitr chunk is set to "',
                  knitr_rez,'".\n',
                      'This may lead to incorrect output.\n',
                      'Use option `results = "asis"`')
            )
        }

    # If function is called during knitting process and is rendered
    # as HTML file, a widget is also printed as an HTML code:
    if (widget_as_html == "auto")
        widget_as_html <- !is.null(knitr::opts_knit$get("out.format"))

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
                    if (widget_as_html == TRUE){
                        # print the html piece of the htmlwidgets
                        htmltools::renderTags(x)$html %>% cat
                    } else {
                        print(x)
                    }

                } else if (inherits(x,"gtable")) {
                    grid::grid.newpage()
                    grid::grid.draw(x)

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

    if(widget_as_html == TRUE) {

        # Find the htmlwidgets
        widget_objs <- Filter(function(x){inherits(x, 'htmlwidget')}, container)

        # Extract dependencies
        list_dependencies <- function(obj){htmltools::renderTags(obj)$dependencies}
        dependencies <- lapply(widget_objs, list_dependencies)

        # Attach dependencies
        htmltools::attachDependencies(
            htmltools::tagList(),
            unlist(dependencies, recursive = FALSE)
        )
    }
}

#  ---------------------------------------------------------------------------
#' @export
#' @rdname print_all
extract_and_print <- function(container, env = parent.frame(), ...) {
    .Deprecated("print_all")
    print_all(container, env = env, ...)
}

#  ---------------------------------------------------------------------------
#' @export
#' @rdname print_all
print_objects <- function(container, env = parent.frame(), ...){
    .Deprecated("print_all")
    print_all(container, env = env, ...)
}
#  ---------------------------------------------------------------------------
# %>% knitr::asis_output(.)
