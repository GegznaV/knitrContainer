#' @title Class \code{knitrContainer}
#'
#' @name knitrContainer-class
#' @aliases knitrContainer-class
#' @exportClass knitrContainer
#'
#' @description
#'  \code{knitrContainer} is an object dedicated for collecting other objects,
#'  such as section headings, text, \code{ggplot} and \code{plotly} plots
#'  (this kind of ojects before they are printed), \code{pander} tables, etc.
#'  and printing them in one function call in a \code{knitr} report file
#'  (usually when \code{HTML} output is desired).
#'  The advantage  of such printing is obvious in those cases, where otherwise
#'  the object are not printed, e.g., from inside \code{for} loop in
#'  \code{knitr} report when \code{HTML} output is desired.\cr
#'
#'  Technically \code{knitrContainer} object is a list with attached
#'  \code{class} attribute "\code{knitrContainer}" thus lists can be easily
#'  converted to \code{knitrContainer}s by using funtion
#'  \code{as.knitrContainer}.
#'
#' @author  Vilmantas Gegzna
#' @seealso Examples in vignette .
#' @family \code{knitrContainer} functions
#'
#' @keywords classes
#' @docType class
#'
#' @examples
#' # For more examples type:
#' vignette("v1_examples", package = "knitrContainer")
#'
#' # Examples:
#' library(knitrContainer)
#'
#' library(plotly)
#' library(ggplot2)
#'
#' plotly_obj <- plot_ly(economics, x = date, y = uempmed, type = "scatter",
#'              showlegend = FALSE)
#'
#' ggplot_obj <- qplot(mpg, wt, data = mtcars, colour = cyl)
#'
#'
#' container <- knitrContainer()
#' container <- add_as_section(container, "Plots")
#'
#' container <- add_as_section(container, "Add plotly", level = 2)
#' container <- add_as_plotly_widget(container, plotly_obj)
#'
#' container <- add_as_section(container, "Add ggplot as plotly", level = 2)
#' container <- add_as_plotly_widget(container, ggplot_obj)
#'
#' container <- add_as_section(container, "Add ggplot", level = 2)
#' container <- add_as_is(container, ggplot_obj)
#'
#' container <- add_as_section(container, "Pander and text", level = 1)
#'
#' container <- add_as_section(container, "As pander", level = 2)
#' container <- add_as_pander(container, summary(mtcars))
#'
#' container <- add_as_section(container, "As text", level = 2)
#' container <- add_as_text(container, summary(mtcars))
#'
#' container <- add_as_section(container, "As is", level = 2)
#' container <- add_as_is(container, summary(mtcars))
#'
#' container <- add_as_is(container, plotly_obj)
#'
#' summary(container)
#' print(container)
#' print_all(container)
#'
#' is.knitrContainer(container)
#' is.knitrContainer(ggplot_obj)
#'
#' as.knitrContainer(ggplot_obj)
#'
#' class(container)
#'
#'
#' Join(container, container)
#' Join(container, ggplot_obj)
#' Join(ggplot_obj)
NULL
