


###-----------------------------------------------------------------------------
###
### .extract - internal function doing the work for extracting with [] and [[]]
###

##' @noRd
.extract <- function(x, i, j, l,
                     ...,
                     wl.index = FALSE) {
    if (!missing (i))
        x@data <- x@data[i, , drop = FALSE]

    if (!missing (j)) {
        x@data <- x@data[, j, drop = FALSE]
        x@label <- x@label[c (".wavelength", colnames(x@data))]
    }

    if (!missing (l)) {
        if (is.null (x@data$spc))
            warning ("Selected columns do not contain specta. l ignored.")
        else {
            if (!wl.index)
                l <- wl2i (x, l)

            x@data$spc <- x@data$spc[, l, drop = FALSE]
            .wl(x) <- x@wavelength[l]
        }
    }

    x
}

##' The Methods to extract and replace elements of a \code{knitrContainer} object
##'
##' These Methods can be used for selecting/deleting,
##' and extracting or setting elements of a \code{knitrContainer} object.
##'
##' \emph{Extracting: \code{[}, \code{[[}, and \code{$}}.
##'
##' The version with single square brackets (\code{[}) returns the
##' resulting \code{knitrContainer} object.
##'
##' \code{[[} yields corresponding \code{knitrContainer}
##' element returned.
##'
##' \code{$} returns the selected element.
##'
##' \emph{Shortcuts.} Three shortcuts to conveniently extract much
##'  needed parts of the object are defined:
##'
##' \code{x[[]]} is equivalent to \code{print_all}.
##'
##' \code{x$.} returns ...
##'
##' \code{x$..} returns ...
##'
##' \emph{Replacing: \code{[<-}, \code{[[<-}, and \code{$<-}}.
##'
##' \code{value} gives the values to be assigned.\cr
##'
##'
##' \code{[[<-} replaces parts of the ...
##'
##' \code{[<-} replaces parts of the ...
##'
##' \code{$<-} replaces a ...
##'
##' \code{$..<-} is again an abbreviation for the ...
##'

##' @title Extract and Replace parts of knitrContainer objects
##' @rdname extractreplace
##' @docType methods
##' @rdname extractreplace
##' @param x a \code{knitrContainer} Object
##' @param i index of object inside knitrContainer
##' @param j selecting ...
##' @param l selecting ...
##' @param drop For \code{[[}: drop unnecessary dimensions, see
##'   \code{\link[base]{drop}} and \code{\link[base]{Extract}}. Ignored for
##'   \code{[}, as otherwise invalid \code{knitrContainer} objects might result.
##' @param ... ignored
##'
##' @keywords methods manip
##' @method "[" knitrContainer
##' @export
"[.knitrContainer" <-
    function(x,
             i,
             ...,
             section = NULL,
             level = 1,
             drop = FALSE)
        # drop has to be at end
    {
        if (drop)
            warning("Ignoring `drop = TRUE`.")
        #
        dots <- list(...)
        if (length(dots) > 0L)
            warning ("Ignoring additional parameters: ",
                     paste(names(dots), collapse = ", "))

        unclass(x)
        # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        if (is.numeric(section)) {
            x <- x[.which_section(x, level) %in% section]
        }
        # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        if (missing(i))       {
            x <- x
        } else {
            x <- unclass(x)[i, drop = drop]
        }
        as.knitrContainer(x) # return value

    }

##' @rdname extractreplace
##' @param name name of the data column to extract.
##' @method "[[" knitrContainer
##' @export
"[[.knitrContainer" <- function(x, i, ..., drop = TRUE)
{
    if (missing(i)) {
        print_all(x)
    } else
        unclass(x)[[i, ..., drop = drop]]
}

##' @rdname extractreplace
##' @param name name of the data column to extract.
##' @method "$" knitrContainer
##' @export
"$.knitrContainer" <- function(x, name)
{
    validObject(x)
    if (name == ".")
        ## shortcut
        data.frame(belongs_to_section = .which_section(a))
    else if (name == "..") {
        data.frame(belongs_to_section  = .which_section(a),
                   added_as = sapply(a, added_as))
    } else
        x[tolower(sapply(a, added_as)) %in% tolower(name)]
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.pastenames <- function(...)
{
    if (nargs() == 1L & is.list(..1))
        dots <- ..1
    else
        dots <- list(...)
    names <- names(dots)
    names <- sapply(names, function(x) {
        if (nchar(x) > 0L)
            sprintf("%s = ", x)
        else
            ""
    })
    paste(names, dots, collapse = ", ", sep = "")
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.which_section <- function(x, level = 1) {
    hl <- function(xi) {
        r <- attributes(xi)$heading_level

        if (is.null(r))
            0
        else
            r
    }
    (sapply(x, hl) == level)  %>% cumsum
}
