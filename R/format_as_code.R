#' Format object to be printed as a code in a Markdown file
#'
#' Function prints object, captures the output and formats it so that
#' it will be printed as a piece of code in a Markdown file.
#'
#' @param obj An object to be printed and returned as strings.
#'
#' @param comment Either logical or a string:\cr
#'  If \code{TRUE} - default \code{knitr} chunk of code comment symbols are
#'  used (usually \code{##}). \cr
#' If \code{FALSE} (default) or  \code{NA} - no comment is used. \cr
#' If a string, the entered symbols are used as comment symbols.
#'
#' @param highlight Either \code{NULL}, \code{FALSE} or a string with name of
#'                  programming language for which rules of
#'                  code highlighting will be applied. Default is "r".
#' @param ... Further arguments to be passed to \code{\link[base]{print}}.
#'
#' @return A vector of strings.
#'
#' @details Function prints the object \code{obj}
#' (see \code{\link[base]{print}}),
#'  captures the output (see \code{\link[utils]{capture.output}}),
#'  adds \code{comment} at the beggining of each string and
#'  adds \code{\`\`\`} + value of \code{highlight} as the first string
#'  (e.g., \code{\`\`\`r}) and
#'  \code{\`\`\`} as the last string (see section "Examples").
#'
#' @export
#'
#' @examples
#'
#' format_as_code(summary(cars))
#'  #> [1] "```r"
#'  #> [2] "      speed           dist       "
#'  #> [3] "  Min.   : 4.0   Min.   :  2.00  "
#'  #> [4] "  1st Qu.:12.0   1st Qu.: 26.00  "
#'  #> [5] "  Median :15.0   Median : 36.00  "
#'  #> [6] "  Mean   :15.4   Mean   : 42.98  "
#'  #> [7] "  3rd Qu.:19.0   3rd Qu.: 56.00  "
#'  #> [8] "  Max.   :25.0   Max.   :120.00  "
#'  #> [9] "```"
#'
#'  # Set parameter `comment = TRUE`
#'
#'  format_as_code(summary(cars), comment = TRUE)
#'  #> [1] "```r"
#'  #> [2] "##      speed           dist       "
#'  #> [3] "##  Min.   : 4.0   Min.   :  2.00  "
#'  #> [4] "##  1st Qu.:12.0   1st Qu.: 26.00  "
#'  #> [5] "##  Median :15.0   Median : 36.00  "
#'  #> [6] "##  Mean   :15.4   Mean   : 42.98  "
#'  #> [7] "##  3rd Qu.:19.0   3rd Qu.: 56.00  "
#'  #> [8] "##  Max.   :25.0   Max.   :120.00  "
#'  #> [9] "```"
#'
#'
#'  # Compare the lines above to:
#'
#'  summary(cars)
#'  #> speed           dist
#'  #> Min.   : 4.0   Min.   :  2.00
#'  #> 1st Qu.:12.0   1st Qu.: 26.00
#'  #> Median :15.0   Median : 36.00
#'  #> Mean   :15.4   Mean   : 42.98
#'  #> 3rd Qu.:19.0   3rd Qu.: 56.00
#'  #> Max.   :25.0   Max.   :120.00
#'
#'
#' format_as_code("a")
#'  #> [1] "```r"
#'  #> [2] " [1] \"a\""
#'  #> [3] "```"
#'

format_as_code <- function(obj, comment = FALSE, highlight = "r", ...){

    if (highlight==FALSE | is.na(highlight)) {
        highlight <- NULL
    }

    # Chose comment
    if (isTRUE(comment)){
        comment <- knitr::opts_chunk$get("comment")
        # If comment is NA or is FALSE
        if (comment == FALSE | is.na(comment)) {
            comment <- NULL
        }
    } else if (comment == FALSE | is.na(comment)) {
        comment <- NULL
    } else {
        comment <- as.character(comment)
    }



    # Format output text
    rez <- c(paste0("```", highlight),
             paste(comment,  capture.output(print(obj, ...))),
             "```")

    # Return result
    return(rez)
}
