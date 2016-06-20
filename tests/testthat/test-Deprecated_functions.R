context("Deprecated_functions")

## TODO: Rename context
## TODO: Add more tests

test_that("function add_as_code() marked as deprecated", {
  expect_warning(add_as_code(obj = print("x")))
})


#  ------------------------------------------------------------------------

test_that("print_objects() throws warning as it is deprecated", {

    cont <- add_as_is(obj = "A")
    expect_warning(capture.output(print_objects(cont)))
})

#  ------------------------------------------------------------------------
