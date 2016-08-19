# ##' These Methods allow to extract and replace parts of the \code{knitrContainer} object.
# ##'
# ##'
# ##'
# ##'
# ##' @name extractreplace
#
#
#
# setReplaceMethod ("[",
#                   signature = signature(x = "knitrContainer"),
#                   function (x, name, value){
#                       validObject (x)
#
#                       if (is.list (value) && (length (value) == 2)){
#                           ilabel <- match ("label", names (value))
#
#                           if (is.na (ilabel))
#                               ilabel <- 2
#
#                           label <- value [[ilabel]]
#
#                           value <- value [[3 - ilabel]] ## the other of the 2 entries
#
#                       } else {
#                           label <- name
#                       }
#
#                       if (name == "..") { ## shortcut
#                           i <- -match ("spc", colnames (x@data))
#                           x@data[, i] <- value
#
#                           if (!is.null (label)){
#                               i <- colnames (x@data)[i]
#                               i <- match (i, names (x@label))
#                               x@label[i] <- label
#                           }
#                       } else {
#                           dots <- list (x = x@data, name = name, value = value)
#                           x@data <- do.call("$<-", dots)
#                           x@label[[name]] <- label
#                       }
#
#                       x
#                   })
