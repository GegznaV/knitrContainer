context("Function extract_and_print()")

#  ------------------------------------------------------------------------

test_that("print_objects() throws warning as it is deprecated", {

    cont <- add_as_is(obj = "A")
    expect_warning(print_objects(cont))
})

#  ------------------------------------------------------------------------
test_that("`code_to_eval.` that is not contained as character vector is not printed by extract_and_print()", {
    obj <- 2
    attributes(obj)$added_as <- "Code to eval."
    obj <- as.knitrContainer(obj)
    expect_warning(extract_and_print(obj))
})
#  ------------------------------------------------------------------------

test_that("extract_and_print() prints html widgets.", {


    # HTML tags were not collected
    AS1 <- add_as_is(obj = plotly::plot_ly())
    out1 <- capture.output(extract_and_print(AS1))

    # HTML tags were collected
    AS4 <- add_as_plotly_widget(obj = plotly::plot_ly())
    out4 <- capture.output(extract_and_print(AS4))

    # Test length
    expect_length(out1, 4) # out1 = [1] "  " ""   ""   "  "
    expect_length(out4, 5)

    # Test some contents
    expect_match(out4[2], "htmlwidget")
    expect_match(out4[2], "plotly html-widget")
    expect_match(out4[3], "htmlwidget")

})

#  ------------------------------------------------------------------------

test_that("extract_and_print() throws error where expected", {
 # No arguments
  expect_error(extract_and_print())
 # Wrong class
  expect_error(extract_and_print(list()))
 # Emplty container
  expect_warning(extract_and_print(knitrContainer()))
})

#  ------------------------------------------------------------------------

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

#  ------------------------------------------------------------------------

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


#  ------------------------------------------------------------------------


