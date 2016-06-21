# add_as_* family functions  --------------------------------------------------
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
#' \code{\link{add_as_section}()} subfamily functions have separate description
#' page.
#'
#' @details
#'
#' Following functions convert and format an object \code{obj} such that it could
#' be appropriatly printed (or evaluated) by applying function
#' \code{\link{print_all}}().
#'
#' \code{add_as_is()} includes object \code{obj} in the \code{container} without
#' transformation (\bold{"as is"}). Function \code{print_all} will print
#' it using regular \code{print} function. Note that in R Markdaown \code{Rmd}
#' file \code{knitr} chunk option \code{results='asis'} may distort the
#' "beautiful" formatting of the printed object. This function is appropriate
#' to ingludde \pkg{ggplot2} plots, if they have to be displayed as \code{gg}
#' plots and not \code{plotly} plots.
#'
#' \code{add_as_text()} converts \code{obj} to \code{\link[base]{character}},
#'  formats as \bold{text} and includes it in the \code{container}. Function
#'  \code{print_all} will print it as text (`as-is`).
#'
#' \code{\link{add_as_section}()} converts \code{obj} to
#' \code{\link[base]{character}},
#'  formats it as a \bold{heading of section} and includes it in the
#'  \code{container}.
#'  Function \code{print_all} will print it as text.
#'
#' \code{add_as_plotly_widget()} converts \pkg{plotly} and \pkg{ggplot2} objects
#'  to plotly htmlwidget (details in \code{\link[plotly]{as.widget}}) and
#'  includes it in the \code{container}. Function \code{print_all} will
#'  print it as plotly htmlwidget and attach \code{html} dependencies.
#'
#' \code{add_as_pander()} formats supported types of \code{obj} with An R Pandoc
#'  Writer's function \code{\link[pander]{pander}} and includes it in the
#' \code{container}. Function \code{print_all} will print the object
#' as text.
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
    container <- attach_obj(container, obj)

    # Return the updated container
    return(container)
}

#  add_as_plotly_widget ------------------------------------------------------
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

#  add_as_pander --------------------------------------------------------------
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

# Following functions are NOT described well ==============================

# add_as_text -------------------------------------------------------------

#' @rdname add_as_
#' @export
add_as_text <- function(container = NULL, obj){
    if (missing(obj)) stop("`obj` is missing.")

    container <- as.knitrContainer(container)

    # Extract added_as TYPE before it is lost
    # This line is needed by `add_as_section()` and its wrappers
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

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' @rdname add_as_
#' @export
#' @details
#' \code{add_as_paragraph} is the same as \code{add_as_text} - converts input to
#' chatacter vector and saves it as one paragraph.\cr
add_as_paragraph <- function(container = NULL, obj){
    if (missing(obj)) stop("`obj` is missing.")
    container <- add_as_text(container, obj)
    return(container)
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' @rdname add_as_
#' @export
#' @details
#' \code{add_as_strings} converts input to vectors of chatacter and saves every
#' vector as sepatate strings (i.e. separate paragraphs).\cr
add_as_strings <- function(container = NULL, obj){
    if (missing(obj)) stop("`obj` is missing.")

    container <- as.knitrContainer(container)

    # Transform obj to appropriate form
    obj <- capture.output(cat(as.character(obj), sep="\n"))

    # Add added_as TYPE
    obj <- added_as(obj, "Strings")

    # Add to container
    container <- add_as_is(container, obj)

    # Return the updated container
    return(container)
}


#  add_as_data ----------------------------------------------------------------
#' @rdname add_as_
#' @export
#' @param give.name A string, that gives a name of a data set passed as
#' \code{obj}.\cr
#'  **Default value** is the name passed as input \code{obj}.
#'  If the imput is is not a name of an object, then sequence of functions
#'  is applied to make a valind name from first 60 symbols of the input:
#' \code{match.call()$obj \%>\% c \%>\% as.character \%>\% make.names \%>\% substr(1,60)}.
#'
#' @details
#' \code{add_as_data()} adds object (data frame, list, vector, etc.) to the
#' container.
#' When function \code{print_all} the object is not printed, but just
#'  extracted and assigned in the environment \code{env} (by default to the
#'  parent frame) to the object which name is entered as value of parameter
#'  \code{give.name}.
add_as_data <- function(container = NULL, obj,
                        give.name = match.call()$obj %>% c %>% as.character %>%
                            make.names %>% substr(1,60)){
    if (missing(obj)) stop("`obj` is missing.")

    container <- as.knitrContainer(container)

    obj <- added_as(obj, "Data")
    attributes(obj)$name <- as.name(give.name)

    container <- add_as_is(container,obj)
    return(container)
}

#  add_as_command ---------------------------------------------------------
#' @rdname add_as_
#' @export
#'
#' @details
#' \code{add_as_command()} takes \emph{unquoted} expression and
#' converts it to a string.
#' The expression is going to be evaluated when function
#' \code{print_all} is applied.\cr
add_as_command <- function(container = NULL, obj){
    if (missing(obj)) stop("`obj` is missing.")

    container <- as.knitrContainer(container)
    # obj <- substitute(obj)  # problem as it is printed only once
    obj <- substitute(obj) %>% c %>%  as.character
    obj <- added_as(obj, "Command")
    container <- add_as_is(container,obj)
    return(container)
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' @rdname add_as_
#' @export
#'
#' @details
#' \code{add_as_cmd()} is the same as \code{add_as_command()}.
#'
add_as_cmd <- function(container = NULL, obj){
    if (missing(obj)) stop("`obj` is missing.")

    container <- as.knitrContainer(container)
    obj <- substitute(obj) %>% c %>%  as.character
    obj <- added_as(obj, "Command")
    container <- add_as_is(container,obj)
    return(container)
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' @rdname add_as_
#' @export
#'
#' @details
#' \code{add_as_cmd_str()} is the same as \code{add_as_command()}, just object
#' must be entered entered as a string.
#'
add_as_cmd_str <- function(container = NULL, obj){
    if (missing(obj)) stop("`obj` is missing.")
    if (!is.character(obj)) stop("`obj` is not a string.")

    container <- as.knitrContainer(container)
    obj <- added_as(obj, "Command")
    container <- add_as_is(container,obj)
    return(container)
}


#  add_as_code ---------------------------------------------------------------
#' @rdname add_as_
#' @export
#' @inheritParams format_as_code
#' @details
#' \code{add_as_code()} saves object as text and prints it formatted as code
#' (i.e., as formatted text). \cr

add_as_code <- function(container = NULL, obj, comment = FALSE,
                        highlight = FALSE){
    if (missing(obj)) stop("`obj` is missing.")

    container <- as.knitrContainer(container)

    # Transform obj to appropriate form
    obj <- format_as_code(obj, comment, highlight)

    # Add added_as TYPE
    obj <- added_as(obj, "Formatted")  # <----------------------- Pakeisti i "formatted"

    # Add to container
    container <- add_as_is(container, obj)

    # Return the updated container
    return(container)
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' @rdname add_as_
#' @export
#' @inheritParams format_as_code
#' @details
#' \code{add_as_code_r()} saves object as text and prints it formatted as
#' R code text. \cr
add_as_code_r <- function(container = NULL, obj, comment = FALSE,
                          highlight = "r"){
    if (missing(obj)) stop("`obj` is missing.")

    container <- add_as_code(container, obj, comment, highlight)

    # Return the updated container
    return(container)
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' @rdname add_as_
#' @export
#' @inheritParams format_as_code
#' @details
#' \code{add_as_code_js()} saves object as text and prints it formatted as
#' Java Script code. \cr
add_as_code_js <- function(container = NULL, obj, comment = FALSE,
                           highlight = "js"){
    if (missing(obj)) stop("`obj` is missing.")

    container <- add_as_code(container, obj, comment, highlight)

    # Return the updated container
    return(container)
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' @rdname add_as_
#' @export
#' @inheritParams format_as_code
#' @details
#' \code{add_as_output()} saves object as text and prints it formatted as
#' output text. \cr
add_as_output <- function(container = NULL, obj, comment = TRUE,
                           highlight = FALSE){
    if (missing(obj)) stop("`obj` is missing.")

    container <- add_as_code(container, obj, comment, highlight)

    # Return the updated container
    return(container)
}

#  ------------------------------------------------------------------------


