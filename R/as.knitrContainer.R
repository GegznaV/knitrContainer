# as.knitrContainer --------------------------------------------------------------------
#
#' @rdname knitrContainer
#' @export
#
as.knitrContainer <- function(obj = NULL){
    # if (missing(obj)) stop("`obj` is missing.")
    if (is.null(obj)) obj <- knitrContainer()

    # If NOT a container and NOT a list
    if (!inherits(obj, c("knitrContainer","list"))){
        obj <- added_as(obj, TYPE =  "As is")
        obj <- list(obj)
    }

    # Add class attribute for list
    if (inherits(obj, c("list"))){
        obj <- lapply(obj, added_as, TYPE =  "As is")
        class(obj)  <-  c("knitrContainer", setdiff(class(obj), "knitrContainer"))
    }

    if (inherits(obj, "knitrContainer")) {
        return(obj)
    }
    # else {
    #     stop(paste("Object of class ",
    #                paste(class(obj), collapse = ", "),
    #                "can not be converted to class 'knitrContainer'."))
    # }
}