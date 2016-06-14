context("function extract_and_print()")



test_that("extract_and_print() throws error where expected", {
 # No arguments
  expect_error(extract_and_print())
 # Wrong class
  expect_error(extract_and_print(list()))
 # Emplty container
  expect_warning(extract_and_print(knitrContainer()))
})


test_that("extract_and_print() and add_as_data() works correnctly", {

    # Capture name
    cont1 <- add_as_data(obj = mtcars)
    extract_and_print(cont1)
    expect_true("mtcars" %in% ls())


    # Capture and correct the name
    cont2 <- add_as_data(obj = mtcars$cyl)
    extract_and_print(cont2)
    expect_true("mtcars.cyl" %in% ls())

    # Capture and correct the name
    cont3 <- add_as_data(obj = mtcars, give.name = "NAME_1")
    extract_and_print(cont3)
    expect_true("NAME_1" %in% ls())

    # Identical contents
    expect_identical(NAME_1, mtcars)
    expect_identical(mtcars$cyl, mtcars.cyl)

})


test_that("extract_and_print() and add_as_code_to_eval() works correnctly", {


    # Expr 1
    cont1 <- add_as_code_to_eval(obj = print(1+3))
    #Empty line is aded, thus select just the 1st element
    expect_equal(capture.output(extract_and_print(cont1))[1],
                 capture.output(print(4)))

    # Expr 2
    cont2 <- add_as_code_to_eval(obj = print(mtcars))
    expect_identical(capture.output(extract_and_print(cont2))[1:10],
                     capture.output(print(mtcars))[1:10])

    # Expre 3
    expect_false("OBJ" %in% ls())

    cont3 <- add_as_code_to_eval(obj = OBJ <- mtcars)
    extract_and_print(cont3)

    expect_true("OBJ" %in% ls())
    expect_identical(OBJ, mtcars)

})
