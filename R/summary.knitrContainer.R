
# Summary --------------------------------------------------------------------

#' @name summary
#' @title Print and summary methods for \code{knitrContainer}
#' @description Print summary of \code{knitrContainer} object.
#'
#' @param object \code{knitrContainer} object.
#' @param n The number of rows (objects) to display. Default \code{n = 30}.
#' @param len length of text (number of characters) to be shown in summary.
#' Default is 100.
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

summary.knitrContainer <- function(object, n = 100, len = 30, units = "Kb", ...){
    container <- object

    if (length(container)==0) {
        cat("*** Empty container ***")

    } else {
        bru(n = 80)
        LENGTH <- length(container)
        cat(paste("*** knitr container *** \n\nContains",  LENGTH,
                  "object(s):\n\n"))

        REZ <- data.frame(
            "Added as" = sapply(container, function(x){added_as(x) %if.NULL% " "}),
            "Text"     = sapply(container, function(x){
                if (added_as(x)  %in% c("Section","Text")){
                    x <- gsub("[\r\n]", "", x)
                    nCh <- nchar(x)
                    if (nCh > len) paste0(substr(x , 1, len-3), "...")
                    else substr(x , 1, len)
                } else {
                    " "
                }}),
            "Size"     = sapply(container, function(x){format(object.size(x), units = "Kb")}),
            "Classes"  = sapply(container, function(x){paste(class(x), collapse=", ")}),
        stringsAsFactors = FALSE)

        if (LENGTH > n) {
            REZ <- rbind(REZ[1:n,], c("...","...","...","...") )
              rownames(REZ)[n+1] = "..."
              print(REZ, right = FALSE, quote = FALSE)
              cat(sprintf("\n *** Only the first %s lines are displayed! *** \n", n))
        } else {
            print(REZ, right = FALSE, quote = FALSE)
        }

        bru(n = 80)
    }
}


#  ------------------------------------------------------------------------
`%if.NULL%` <- function(a, b) {if (!is.null(a)) a else b}
#  ------------------------------------------------------------------------
bru <- function(symbol = "=",
                n = 60,
                after  = (if (print) 1 else 0),
                before = 0,
                print  = TRUE)
{
    # Create sequences of symbols
    nlA <- paste0(rep('\n', after),  collapse = "")
    nlB <- paste0(rep('\n', before), collapse = "")
    lineC <- paste0(rep(symbol,n),   collapse = "")

    # Adjust the length
    lineC <- substr(lineC, 1, n)

    # Join all symbols
    lineC <- paste0(nlB, lineC, nlA)

    # Either print or return the result
    if (print)  cat(lineC) else return(lineC)
}
#  ------------------------------------------------------------------------
