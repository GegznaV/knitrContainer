#' @title Add text as a heading (section name) to \code{knitrContainer}
#'
#' @description
#' \code{add_as_heading()} converts \code{obj} to \code{\link[base]{character}},
#'  formats it as a \bold{heading of a section} and includes it in the
#'  \code{container}. Function \code{print_objects} will print the object as text.
#'
#' @template container
#' @param obj (string) a piece of text to be used as heading.
#' @param level (integer) The level of heading (between 1 and 6).
#'               1 is the top level section.
#'
#'
#' @details
#'   All the remaining functions listed here are wrappers of
#'   \code{add_as_heading}  with different value of parameter
#'   \code{level} passed to \code{add_as_heading}:\cr
#'
#'  In \code{add_as_section()} default value of  \code{level = 1}.\cr
#'  In \code{add_as_heading1()} default value of  \code{level = 1}.\cr
#'
#'  In \code{add_as_subsection()} default value of  \code{level = 2}.\cr
#'  In \code{add_as_heading2()} default value of  \code{level = 2}.\cr
#'
#'  In \code{add_as_heading3()} default value of  \code{level = 3}.\cr
#'
#'  In \code{add_as_heading4()} default value of  \code{level = 4}.\cr
#'
#'  In \code{add_as_heading5()} default value of  \code{level = 5}.\cr
#'
#'  In \code{add_as_heading6()} default value of  \code{level = 6}.\cr
#'
#'
#' @rdname add_as_heading
#' @export
#'
#' @examples
#' # Find more examples in link `knitrContainer-class`
#'
#'
#' # Initialize container
#' container <- knitrContainer()
#'
#' # Fill the container
#'
#' container %<>% add_as_heading1(obj = "Heading 1")
#' container %<>% add_as_heading2(obj = "Heading 2")
#' container %<>% add_as_heading3(obj = "Heading 3")
#' container %<>% add_as_heading4(obj = "Heading 4")
#' container %<>% add_as_heading5(obj = "Heading 5")
#' container %<>% add_as_heading6(obj = "Heading 6")
#'
#' container %<>% add_as_heading(obj = "Heading 5", level = 5)
#' container %<>% add_as_heading(obj = "Heading 6", level = 6)
#'
#' container %<>% add_as_section(obj = "Heading 1")
#' container %<>% add_as_subsection(obj = "Heading 2")
#'
#' # Print the contents of the container
#' print_all(container)
#'
#'
#' # Operator `%<>%` updates the object `container`
#'   ?`%<>%`
#'
#' # These 2 lines are equivalent:
#'  container  <-  add_as_section(container, obj = "Heading 1")
#'  container %<>% add_as_section(obj = "Heading 1")
#'
#'
#' @author Vilmantas Gegzna
#' @family \code{knitrContainer} functions
add_as_heading <- function(container = NULL, obj, level = 1){
    if (missing(obj)) stop("`obj` is missing.")

    force(level)

    container <- as.knitrContainer(container)

    # Process the string
    obj <- sprintf("\n\n%s %s\n",
                   #line adds required number of symbols (#):
                   paste0(rep("#",times = level), collapse = ""),
                   as.character(obj))
    # Add attributes
    obj <- added_as(obj, "Heading")
    attr(obj, "heading_level") <- level

    # Add object to container
    container <- add_as_is(container, obj)
    return(container)
}
#' @rdname add_as_heading
#' @export
add_as_section <- function(container = NULL, obj, level = 1){
    add_as_heading(container = container, obj = obj, level = level)
}

#' @rdname add_as_heading
#' @export
add_as_subsection <- function(container = NULL, obj){
    add_as_heading(container = container, obj = obj, level = 2)
}
#' @rdname add_as_heading
#' @export
add_as_heading1 <- function(container = NULL, obj){
    add_as_heading(container = container, obj = obj, level = 1)
}
#' @rdname add_as_heading
#' @export
add_as_heading2 <- function(container = NULL, obj){
    add_as_heading(container = container, obj = obj, level = 2)
}
#' @rdname add_as_heading
#' @export
add_as_heading3 <- function(container = NULL, obj){
    add_as_heading(container = container, obj = obj, level = 3)
}
#' @rdname add_as_heading
#' @export
add_as_heading4 <- function(container = NULL, obj){
    add_as_heading(container = container, obj = obj, level = 4)
}
#' @rdname add_as_heading
#' @export
add_as_heading5 <- function(container = NULL, obj){
    add_as_heading(container = container, obj = obj, level = 5)
}
#' @rdname add_as_heading
#' @export
add_as_heading6 <- function(container = NULL, obj){
    add_as_heading(container = container, obj = obj, level = 6)
}
#  ------------------------------------------------------------------------
