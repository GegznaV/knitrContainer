#  ----------------------------------------------------------------------------
# Functions and lines of code to remove ---------------------------------------
#  ----------------------------------------------------------------------------


#' setClass("knitrContainer")
#'
#' #' @name Merge `knitrContainer` objects
#' #'
#' #' @rdname Merge `knitrContainer` objects
#' #' @aliases c,knitrContainer-method c
#' #' @export
#' setMethod("c",
#'           signature("knitrContainer"),
#'           function(...) {
#'               as.knitrContainer(c(...))
#'           }
#' )
#'
#' #' @rdname Merge `knitrContainer` objects
#' #' @aliases +,knitrContainer,knitrContainer-method
#' #' @export
#' setMethod("+",
#'           signature(e1 = "knitrContainer", e2 = "knitrContainer"),
#'           function(e1, e2) {
#'               as.knitrContainer(c(e1, e2))
#' })



#  ----------------------------------------------------------------------------

#
#         if(inherits(x,"character")){
#             # noquote critical here  also turn off auto.asis very important
#             noquote(paste0(x, collapse="\n")) %>% cat(.)
#
#         } else  if (inherits(x,"htmlwidget")) {
#             # print the html piece of the htmlwidgets
#             htmltools::renderTags(x)$html  %>% cat(.)
#         } else {
#             cat("\n");print(x);cat("\n")
#         }



#  ------------------------------------------------------------------------


#  #' @rdname add_as_
#  #' @export
#  #' @details
#  #'
#  #' \code{add_as_printed_text()} prints object, captures the output and saves it
#  #' to container as strings.  \cr
#  add_as_printed_text <- function(container = NULL, obj){
#      if (missing(obj)) stop("`obj` is missing.")
#
#      container <- as.knitrContainer(container)
#
#      # Transform obj to appropriate form
#      obj <- capture.output(print(obj))
#      # obj <- capture.output(print(obj, ...))
#
#      # Add added_as TYPE
#      obj <- added_as(obj, "Text")
#
#      # Add to container
#      container <- add_as_is(container, obj)
#
#      # Return the updated container
#      return(container)
#  }
#
#
#


#  ------------------------------------------------------------------------
# #' @rdname add_as_
# #' @export
# #'
# #' @details
# #' \code{add_as_expression()} takes unquoted expression and converts it to string.
# #' The expression is going to be evaluated when function
# #' \code{print_all} is applied.\cr
# #'
# add_as_expression <- function(container = NULL, obj){
#     if (missing(obj)) stop("`obj` is missing.")
#
#     container <- as.knitrContainer(container)
#
#     # obj <- substitute(obj)  # problem as it is printed only once
#
#     obj <- substitute(obj) %>% c %>%  as.character
#
#     obj <- added_as(obj, "Code to evaluate")
#
#     container <- add_as_is(container,obj)
#     return(container)
# }
#



#  add_as_command ---------------------------------------------------------
#' #' @rdname add_as_
#' #' @export
#' #'
#' #' @details
#' #' \code{add_as_command()} takes \emph{unquoted} expression and
#' #' converts it to a string.
#' #' The expression is going to be evaluated when function
#' #' \code{print_all} is applied.\cr
#' add_as_command <- function(container = NULL, obj){
#'     if (missing(obj)) stop("`obj` is missing.")
#'
#'     container <- as.knitrContainer(container)
#'     # obj <- substitute(obj)  # problem as it is printed only once
#'     obj <- substitute(obj) %>% c %>%  as.character
#'     obj <- added_as(obj, "Command")
#'     container <- add_as_is(container,obj)
#'     return(container)
#' }
#' # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' #' @rdname add_as_
#' #' @export
#' #'
#' #' @details
#' #' \code{add_as_cmd()} is the same as \code{add_as_command()}.
#' #'
#' add_as_cmd <- function(container = NULL, obj){
#'     if (missing(obj)) stop("`obj` is missing.")
#'
#'     container <- as.knitrContainer(container)
#'
#'     obj <- substitute(obj) %>% c %>%  as.character
#'     obj <- added_as(obj, "Command")
#'     container <- add_as_is(container,obj)
#'     return(container)
#' }
#'
#'


# add_as_paragraph ------------------------------
#' # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' #' @rdname add_as_
#' #' @export
#' #' @details
#' #' \code{add_as_paragraph} is the same as \code{add_as_text} - converts input to
#' #' chatacter vector and saves it as one paragraph.\cr
#' add_as_paragraph <- function(container = NULL, obj){
#'     if (missing(obj)) stop("`obj` is missing.")
#'     container <- add_as_text(container, obj)
#'     return(container)
#' }