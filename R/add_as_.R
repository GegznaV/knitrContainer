# Add  -----------------------------------------------------------------------
#'
#' @name add_as_
#' @aliases add_as_is
#' @aliases add_as_text
#'
#' @aliases add_as_plotly_widget
#' @aliases add_as_pander
#' @aliases add_as_is
#'
#' @title Add object to \code{knitrContainer}
#'
#' @description Functions to transform and add objects to \code{knitrContainer}.
#' Objects, that can be included in R \code{\link[base]{list}}, can also be
#' included in \code{knitrContainer}.
#'
#' \code{\link{add_as_section}()} subfamily functions have separate description page.
#'
#' @details
#'
#' Following functions converts and formats object \code{obj} sch that it could
#' be appropriatly printed with function \code{\link{print_objects}}().
#'
#' \code{add_as_is()} includes object \code{obj} in the \code{container} without
#' transformation (\bold{"as is"}). Function \code{print_objects} will print it
#' using regular \code{print} function. Note that in R Markdaown \code{Rmd}
#' file \code{knitr} chunk option \code{results='asis'} may distort the
#' "beautiful" formatting of the printed object. This function is appropriate
#' to ingludde \pkg{ggplot2} plots, if they have to be displayed as \code{gg}
#' plots and not \code{plotly} plots.
#'
#' \code{add_as_text()} converts \code{obj} to \code{\link[base]{character}},
#'  formats as \bold{text} and includes it in the \code{container}. Function
#'  \code{print_objects} will print it as text.
#'
#' \code{\link{add_as_section}()} converts \code{obj} to \code{\link[base]{character}},
#'  formats it as a \bold{heading of section} and includes it in the \code{container}.
#'  Function \code{print_objects} will print it as text.
#'
#' \code{add_as_plotly_widget()} converts \pkg{plotly} and \pkg{ggplot2} objects to
#' plotly htmlwidget (details in \code{\link[plotly]{as.widget}}) and includes
#' it in the \code{container}. Function \code{print_objects} will print it as
#' plotly htmlwidget and attach
#' \code{html} dependencies.
#'
#' \code{add_as_pander()} formats supported types of \code{obj} with An R Pandoc
#'  Writer's function \code{\link[pander]{pander}} and includes it in the
#'  \code{container}. Function \code{print_objects} will print the object as text.
#'
#'
#'
#' @template container
#' @template obj
#'
#' @export
#'
#' @examples
#' # Find examples in link `knitrContainer-class`
#'
#' @author Vilmantas Gegzna
#' @family \code{knitrContainer} functions
#'
add_as_is <- function(container = NULL, obj){
    if (missing(obj)) stop("`obj` is missing.")

    container <- as.knitrContainer(container)
    # Add added_as TYPE
    obj <- added_as(obj, "As is")
    # Add to container
    container[[length(container) + 1]] <- obj
    # Return the updated container
    return(container)
}

#' @rdname add_as_
#' @export
add_as_text <- function(container = NULL, obj){
    if (missing(obj)) stop("`obj` is missing.")

    container <- as.knitrContainer(container)

    # Extract added_as TYPE before it is lost
    TYPE <- added_as(obj) %if.NULL% "Text"

    # Transform obj to appropriate form
    obj <- capture.output(cat(as.character(obj)))

    # Add added_as TYPE
    obj <- added_as(obj, TYPE)

    # Add to container
    container <- add_as_is(container, obj)

    # Return the updated container
    return(container)
}

#  ------------------------------------------------------------------------

#' @rdname add_as_
#' @export
add_as_plotly_widget <- function(container = NULL, obj){
    if (missing(obj)) stop("`obj` is missing.")

    container <- as.knitrContainer(container)

    obj <- plotly::as.widget(obj)
    obj <- added_as(obj, "Plotly widget")

    container <- add_as_is(container,obj)
    return(container)
}

#' @rdname add_as_
#' @export
#' @param ... Options to be passed to \code{\link[pander]{pander}}.
add_as_pander <- function(container = NULL, obj, ...){
    if (missing(obj)) stop("`obj` is missing.")

    container <- as.knitrContainer(container)
    # Get and set pander options
    op <- pander::panderOptions('knitr.auto.asis')
    pander::panderOptions('knitr.auto.asis', TRUE)

    # Get value
    obj <- capture.output(cat(pander::pander(obj,...)))

    # Reset pander options
    pander::panderOptions('knitr.auto.asis',op)

    # Attach to object `container`
    obj <- added_as(obj, "Pander object")
    add_as_is(container,obj)
}
