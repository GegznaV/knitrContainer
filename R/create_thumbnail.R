# Create a thumbnail of an image -----------------------------------

#' Create a thumbnail of an image.
#'
#'
#' @param figPath (vector of stings) relative or full path to original figure.
#' @param tnPath (vector of stings) relative or full path to thumblail.
#'                By default, suffix "_small" is added to file name.
#' @param w (integer|\code{NULL}) width of resized image in pixels.  Default is \code{300}.
#' @param h (integer|\code{NULL}) height of resized image in pixels. Default is \code{NULL}.
#' @param ratio (numeric|\code{NULL}) expected aspect ratio (width/height).
#'              If \code{NULL} (default), aspepct ratio of the original image is used.
#' @param overwrite (FALSE|TRUE) logical value, that controls if an exsisting
#'        thumbnail with the same name should be overwritten. Default is \code{FALSE}.
#' @param quality (numeric) a numeric ranging from 1 to 100 (default)
#'                 controlling the quality of the JPEG output.
#' @param ... further parameters (except x, files and quality) to be passed to
#'            function \code{\link[EBImage]{writeImage}()}.
#'
#' @return Function creates a thumbnail and returns a path to to it.
#' @export
#'
#' @examples
#' \dontrun{
#' \dontCheck{
#' figPath = "Figures/2016-08-02-11875.jpg"
#'
#' # Full name of a thumbnail
#' sep     <- .Platform$file.sep
#' tnPath  <- sub(pattern     = paste0("(.*", sep, ")?(Figures)(", sep, ".*)"),
#'               replacement = paste0("\\1\\2_small\\3"),
#'              x = figPath)
#'
#' # Creates a thumbnail and returns a path to it.
#'
#' tn <- create_thumbnail(figPath)
#'
#' browseURL(tn)
#' file.remove(tn)
#'
#' }}
#'
#' @importFrom utils installed.packages
#' @import EBImage

create_thumbnail <- function(figPath,
                             tnPath = sub("(.*)(\\..*?)$", "\\1_small\\2", figPath),
                             w = 300,
                             h = NULL,
                             ratio     = NULL,
                             quality   = 85,
                             overwrite = FALSE,

                             ...){

    if (length(figPath) != length(tnPath))
        stop("The number of original figures and thumbnail paths must agree.")

    if (is.null(w) & is.null(w))
        stop("At least one of `w` and `h` must not be NULL.")


    create_th <- function(Paths){
        figPath = Paths[1]
        tnPath  = Paths[2]
        if (length(figPath) > 1) stop("Only one figure can be accepted (`Paths`)")


        if (!file.exists(tnPath) | isTRUE(overwrite))
        {
            # # Install package "EBImage" if missing
            # if (!"EBImage"  %in% installed.packages()){
            #     source("http://bioconductor.org/biocLite.R")
            #     biocLite("EBImage")
            # }

            # Get name of thumbnail's folder
            tnDir  <- dirname(tnPath)

            # Read image
            im <- EBImage::readImage(figPath)
            # im <- load.image(figPath[1])

            # plot(im)

            # # Width and height of original immage
            # w0 <- dim(im)[1]
            # h0 <- dim(im)[2]
            #
            # w0 > h0
            # round(w0/h0,2)
            # 0.56
            #

            # if (w0 < h0) w <- 0.56 * w

            # Create a thumbnail

            if (is.null(ratio)){
                d = dim(im)[1:2]
                ratio <- d[2]/d[1]
            }

            if (is.null(h))   h <- round(w * ratio)
            if (is.null(w))   w <- round(h / ratio)

            im_tn <- EBImage::resize(im, w = w, h = h)

            # plot(im_tn)


            # # Crop ----------------------------
            # expected_h <- 168
            # pad_upp <- (h - expected_h) %/% 2
            # pad_low <- expected_h + pad_upp
            # im_tn <- im_tn[1:w, pad_upp:pad_low,]  %T>% plot
            #
            # # Add padding ----------------------
            # #  >> Not finished
            # abind(padding_1, image_array, padding_2)
            #
            # arr1 <- array(1, c(w1,h1,3))
            # arr2 <- array(1, c(w2,h2,3))
            #
            # abind(arr1, as.array(im_tn), arr2,
            #       along = 2)
            # # <<


            # Create directory for the thumbnail
            if(!dir.exists(tnDir)) {
                dir.create(tnDir, recursive = TRUE)
            }
            # Write the thumbnail
            EBImage::writeImage(im_tn, tnPath, quality = quality, ...)

            #     status <- "Thumbnail was created or overwritten."
            # } else {
            #     status <- "Thumbnail already exists and was NOT recreated."
        }
        # attr(tnPath, "status") <- status
        invisible(tnPath)
    }

    # Apply for all images
    tn_names <- sapply(list(c(figPath, tnPath)), create_th)
    names(tn_names) <- NULL
    return(tn_names)
}