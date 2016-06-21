
# Summary --------------------------------------------------------------------

#' @name summary
#' @title Print and summary methods for \code{knitrContainer}
#' @description Print summary of \code{knitrContainer} object.
#'
#' @param object \code{knitrContainer} object.
#' @param n Either the number of rows (objects) to display or numbers of
#'          the first and the last row \code{c(from, to)} to display.
#'          Default \code{n = 100}.
#' @param preview number of characters to be previewed in summary.
#' Default is 40.
#' @inheritParams utils::object.size
#'
#' @export
#' @method summary knitrContainer
#'
#' @examples
#'
#' # Find examples in link `knitrContainer-class`
#'
#' @author Vilmantas Gegzna
#' @family \code{knitrContainer} functions

summary.knitrContainer <- function(object, n = 100, preview = 40, units = "Kb", ...){
    container <- object

    # Initialize SUMMARY
    SUMMARY <- list()

    if (length(container)==0) {
        SUMMARY  %<>% attach_obj("*** Empty container ***")

    } else {
        # Get values
        n_first <- if (length(n) == 1) 1 else n[1]
        n_last  <- if (length(n) == 1) n else n[2]

        # Calculations
        n_total <- length(container)

        n_first <- ifelse(n_first < 1, 1, n_first)
        n_last  <- ifelse(n_last <= n_total, n_last, n_total)

        # Number of rows that are not displaayed
        n_starting_not_displayed <- n_first - 1
        n_ending_not_displayed   <- n_total - n_last

        # Subsetting container
        container <- container[n_first:n_last]

        # Extract information
        REZ <- data.frame(
        #> "Added as" column
            "Added as" = sapply(container, function(x){added_as(x) %if.NULL% " "}),

        #> "Preview" column
            "Preview"  = sapply(container, function(x){

                # Select text to preview
                PREVIEW_text <- if (added_as(x)  %in% # text type "added_as" formats:
                               c("Section",   "Text", "Formatted",
                                 "Paragraph", "Strings", "Command"))
                    {
                        paste(gsub("[\r\n]", " ", x), collapse = " ")
                    } else if (added_as(x) == "Data"){
                        attributes(x)$name
                    } else {
                        " "
                    }

                # Strip whitespace
                PREVIEW_text %<>% trimws

                # Print the preview text
                nCh <- nchar(PREVIEW_text)
                if (nCh > preview) {
                        paste0(substr(PREVIEW_text , 1, preview-3), "...")
                    } else {
                        paste0(substr(PREVIEW_text , 1, preview))
                    }
                }),

        #> "Size" column
            "Size"     = sapply(container, function(x){
                format(object.size(x), units = "Kb")
                }),

        #> "Classes" column
            "Classes"  = sapply(container, function(x){
                paste(class(x), collapse=", ")
                }),
            stringsAsFactors = FALSE
        )

        # Create vector of dots
        .DOTS. <- rep("...", ncol(REZ))

        # Collect SUMMARY
        SUMMARY  %<>% attach_obj(bru(n = 80))

        SUMMARY  %<>% attach_obj(
            sprintf(" *** knitr container *** \n\nContains %g object(s):\n",
                    n_total))

    # If truncated at the begining
        if (n_starting_not_displayed > 0) {

            Trunc_start <- sprintf("%g leading", n_starting_not_displayed)

            #> Add leading dots
            REZ <- rbind(.DOTS., REZ)
            rownames(REZ) = c("... ", n_first:n_last)
        } else {
            Trunc_start <- NULL
        }

    # If truncated at the end
        if (n_ending_not_displayed > 0) {
            Trunc_end <- sprintf("%g last", n_ending_not_displayed)

            #> Add tailing dots
            REZ <- rbind(REZ, .DOTS. )
            rownames(REZ)[n_last+1] = "..."
        } else {
            Trunc_end <- NULL
        }

    # The main text of summary
        SUMMARY  %<>% attach_obj(
                capture.output(print(REZ, right = FALSE, quote = FALSE)))

    # Add if truncated
        if (n_ending_not_displayed > 0 | n_starting_not_displayed > 0) {
            SUMMARY  %<>% attach_obj(
                sprintf("\n *** %s row(s) were not displayed! *** ",
                        paste(c(Trunc_start, Trunc_end), collapse = " and ")))
        }

        SUMMARY  %<>% attach_obj(bru(n = 80))
    }

    # Print/Cat SUMMARY
    nothing <- sapply(SUMMARY, function(x) cat(x,sep = "\n"))

    # Garbage Collection
    nothing <- gc(FALSE)

    # Return result
    invisible(SUMMARY)
}


#  ------------------------------------------------------------------------
#  Infix operator
`%if.NULL%` <- function(a, b) {if (!is.null(a)) a else b}

#  ------------------------------------------------------------------------
# Horizintal rule
bru <- function(symbol = "=", n = 80)
{
    # Create sequences of symbols
    lineC <- paste0(rep(symbol,n),   collapse = "")

    # Adjust the length
    lineC <- substr(lineC, 1, n)

    return(lineC)
}
#  ------------------------------------------------------------------------
