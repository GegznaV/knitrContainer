# INTERNAL FUNCTION

# added_as ----------------------------------------------------------------

# @author Vilmantas Gegzna
# @family \code{knitrContainer} functions

# Function either returns value of  `attributes(obj)$added_as` (if TYPE is not provided)
# OR
# returns updated `obj` with addedd attribute if both  conditions are fulfilled:
# `TYPE` is provided and attribute is `NULL`. otherwise returns `obj` intact.
#
# If force.TYPE == TRUE, new value of `TYPE` will be added any way.
#
#
# obj - object to be updated
# TYPE - attribute to  be added as `$added_as` if `$added_as` is not already present.
# force.TYPE - logical. If TRUE, new type is added despite the fact, that `obj`
#               already has it.
# @export

added_as <- function(obj, TYPE = NULL, force.TYPE = FALSE){
    contained_TYPE <- attributes(obj)$added_as

    # Define supported types
    # TYPE <- match.arg(TYPE, c("As is", ...)

    if (is.null(TYPE))  {
        return(contained_TYPE)

    } else if (is.null(contained_TYPE) | force.TYPE == TRUE) {
        attributes(obj)$added_as <- TYPE
    }
    return(obj)
}
