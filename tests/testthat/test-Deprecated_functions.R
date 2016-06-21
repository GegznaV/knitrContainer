context("Deprecated_functions")


#  ------------------------------------------------------------------------

test_that("print_objects() throws warning as it is deprecated", {

    cont <- add_as_is(obj = "A")
    expect_warning(capture.output(print_objects(cont)))
})

#  ------------------------------------------------------------------------
