#' Create function to number objects (figures, tables, etc.)
#'
#' This function creates a function that numbers objects
#' (e.g., figures, tables, etc.) in an R Markdown file.
#'
#' @param prefix_start Sting that will be used in prefix \bold{before}
#'                     count, e.g. \code{"Fig."}.
#' @param prefix_end Sting that will be used in prefix \bold{after} count,
#'                   e.g. \code{" figue"}.
#' @param start_at A number (an integer, greater than or equal to 1) at which
#'                 numbering starts.
#' @param prefix_bold Logical. If \code{TRUE} (default), double asterisk \code{"**"} will be
#'        used to enclose the prefix, ant it will be interpreted as bold in R
#'        markdown.
#' @param add_space Logical. If \code{TRUE} (default), a space between prefix
#'                 and the main body of caption/description is added.
#' @param env (environment object) An environment to store the count number.
#'
#' @param varName (string) A string with variable name to be created in
#'         environment `env` in which number of counts is stored.
#'
#'
#'
#' @return A function to number objects and add caption/description.
#'         The default result of created function is a string.
#'         The default arguments are \cr
#'         \code{caption = ""} - a string with description,\cr
#'         \code{restart = FALSE} - logical. If \code{TRUE}, numbering
#'         is restarted; \cr
#'         \code{output = "caption"} - A string, that indicated what kind of
#'          output should be returned. If \code{output = "caption"}, a numbered
#'          prefix with description is returned, e.g. \code{"Fig.1 Random
#'          noise"}.
#'          If \code{output = "count"} number of
#'          objects that are numbered by this function (after the last restart)
#'          is returned. Other arguments are ignored.
#'
#' @export
#'
#' @examples
#'
#' iFig   <- create_numeration_fun("Fig.")
#'
#' # Alternative syntax:
#' iFig   <- create_numeration_fun0("**Fig. %g** %s")
#'
#' lapply(paste("Automatically numbered caption for object",LETTERS[1:5]),
#'       FUN = iFig);
#'
#' # Continue numering
#' iFig("The 6-th object.")
#'
#' # Count of numbered objects
#' iFig(output = "count")
#'
#' # Restart numering
#' iFig("Numbering is restarted.", restart = TRUE)
#' iFig(output = "count")
#'
#'
#' # Create separate functions to number different types of objects.
#'
#' iTable   <- create_numeration_fun("Table.")
#' iFig     <- create_numeration_fun("Fig.")
#' iSection <- create_numeration_fun("Section ")
#'
#' iSection(); iTable(); iSection(); iFig(); iSection();
#'

create_numeration_fun <- function(prefix_start = NULL,
                          prefix_end   = NULL,
                          start_at     = 1L,
                          add_space    = TRUE,
                          prefix_bold  = TRUE,
                          env = new.env(),
                          varName = make.names(paste0(prefix_start, prefix_end))){

    # Create a variable name `varName` for counts in environment `env`

    if(start_at < 1)
        stop("`startAt` must be integer, greater than or equal to 1.")

    # Initialize count
    if(is.null(env[[varName]])) assign(varName, start_at - 1 , envir = env)

    s_bold  <- if(prefix_bold)  "**" else ""
    s_space <- if(add_space)    " "  else ""

    function(caption = "", restart = FALSE, output = c("caption","count")){

        switch(output[1],
           count = {
                count <- env[[varName]]
                return(count)
           },

           caption = {
                # Add 1 or reset
                count <- if (restart == TRUE) 1 else env[[varName]] + 1
                # Save current count
                assign(varName, count, envir = env)

                # Create whole string and trim whitespace
                res <- trimws(
                    paste0(s_bold, prefix_start, count, prefix_end, s_bold,
                           s_space, caption)
                )
                return(res)
           }
        )
    }
}
#' @param fmt a character vector of format strings, each of up to 8192 bytes
#'        to be passed to function \code{\link[base]{sprintf}}. \code{fmt}
#'        must include one tag for a numeric value of object's number,
#'        (e.g. \code{\%g}) and one tag for a string with description
#'        (\code{\%s}). Default is \code{"\%g \%s"}. The tag for a number must
#'        be before the tag for a string.
#'
#' @rdname create_numeration_fun
#' @export
create_numeration_fun0 <- function(fmt = "%g %s",
                           start_at    = 1L,
                           env         = new.env(),
                           varName     = make.names(fmt)){

    # Create a variable name `varName` for counts in environment `env`

    if(start_at < 1)
        stop("`startAt` must be integer, greater than or equal to 1.")

    # Initialize count
    if(is.null(env[[varName]]))
        assign(varName, start_at - 1 , envir = env)

    function(caption = "", restart = FALSE, output = c("caption","count")){

        switch(output[1],
           count = {
                count <- env[[varName]]
                return(count)
           },

           caption = {
                # Add 1 or reset
                count <- if (restart == TRUE) 1 else env[[varName]] + 1
                # Save current count
                assign(varName, count, envir = env)

                # Create whole string and trim whitespace
                res <- sprintf(fmt, count, caption)

                return(res)
           }
        )
    }
}