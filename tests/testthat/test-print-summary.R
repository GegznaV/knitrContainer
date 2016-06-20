context("Functions `print()` and `summary()`")

#  ------------------------------------------------------------------------

test_that("summary of empty knitrContainer is correct.", {

    # Output of emply container
    summary_EMPTY <- capture.output(summary(knitrContainer()))
    expect_match(summary_EMPTY, "Empty container")
})

test_that("summary of knitrContainer() with 1 object is correct.", {
    # Basic structure of output
    summary_1 <- capture.output(summary(as.knitrContainer("a")))
    expect_match(summary_1[2], "knitr container")
    expect_match(summary_1[4], "Contains 1 object")
    expect_match(summary_1[7], "1 As is")
})

test_that("Parameter `n` (which length is 1) in summary of knitrContainer() works", {

    cont <- add_as_section(obj = "TEST")
    cont <- add_as_subsection(cont, obj = "TEST")
    cont <- add_as_text(cont, obj = "TEST")

    # Truncated number of lines
    summary_2 <- capture.output(summary(cont, n=2))
    expect_match(summary_2[2], "knitr container")
    expect_match(summary_2[4], "Contains 3 obj")
    expect_match(summary_2[9], "(\\.\\.\\.).*\\1.*\\1")
    expect_match(summary_2[11], "were not displayed!")

})

test_that("Parameter `n` (which length is 2) in summary of knitrContainer() works", {

    cont <- add_as_section(obj = "TEST")
    cont <- add_as_subsection(cont, obj = "TEST")
    cont <- add_as_text(cont, obj = "TEST")
    cont <- add_as_text(cont, obj = "TEST")
    cont <- add_as_text(cont, obj = "TEST")

    # Truncated number of lines
    summary_2 <- capture.output(summary(cont, n=c(2,3)))
    expect_match(summary_2[2], "knitr container")
    expect_match(summary_2[4], "Contains 5 obj")
    expect_match(summary_2[7], "(\\.\\.\\.).*\\1.*\\1")
    expect_match(summary_2[10], "(\\.\\.\\.).*\\1.*\\1")
    expect_match(summary_2[12], "were not displayed!")
    expect_match(summary_2[12], "1 leading") # number of leading rows truncated
    expect_match(summary_2[12], "2") # number of tailing rows truncated

})


test_that("Parameter `preview` in summary of knitrContainer() works", {
    cont <- add_as_section(obj = "TEST")
    cont <- add_as_subsection(cont, obj = "TEST")
    cont <- add_as_text(cont, obj = "TEST")

    # Truncated length of Preview field
    summary_3 <- capture.output(summary(cont, preview = 5))
    expect_match(summary_3[2], "knitr container")
    expect_match(summary_3[4], "Contains 3 obj")
    expect_match(summary_3[7], "# \\.\\.\\. ")
    expect_match(summary_3[8], "##\\.\\.\\. ")

})

#  ------------------------------------------------------------------------
#
test_that("Column `Preview` of summary.knitrContainer() is correct.", {

    # Create container
    cont <- knitrContainer()
    cont <- add_as_text(cont, "Text")
    cont <- add_as_data(cont, cars)
    cont <- add_as_command(cont, summary(cars))
    cont <- add_as_is(cont, cars)
    cont <- add_as_printed(cont, cars)
    cont <- add_as_printed_r(cont, cars)

    # Values in `Preview`
    summary_4 <- capture.output(summary(cont))
    expect_match(summary_4[7], "1 Text.*Text")
    expect_match(summary_4[8], "2 Data.*cars")
    expect_match(summary_4[9], "3 Command.*summary\\(cars\\)")
    expect_match(summary_4[10],"4 As is")
    expect_match(summary_4[11],"```")
    expect_match(summary_4[12],"```r")

})


#  ------------------------------------------------------------------------

test_that("Output of print.knitrContainer() is correct.", {
    summary_EMPTY <- capture.output(print(knitrContainer()))
    expect_match(summary_EMPTY, "Empty container")

    summary_1 <- capture.output(summary(as.knitrContainer("a")))
    expect_match(summary_1[2], "knitr container")
    expect_match(summary_1[4], "Contains 1 object")
    expect_match(summary_1[7], "1 As is")


    cont <- add_as_section(obj = "TEST")
    cont <- add_as_subsection(cont, obj = "TEST")
    cont <- add_as_text(cont, obj = "TEST")

    summary_2 <- capture.output(print(cont, n=2))
    expect_match(summary_2[2], "knitr container")
    expect_match(summary_2[4], "Contains 3 obj")
    expect_match(summary_2[9], "\\.\\.\\. ")
})
#  ------------------------------------------------------------------------


test_that("Output of print.knitrContainer() and summary.knitrContainer() match.", {
    summary_EMPTY <- capture.output(summary(knitrContainer()))
    print_EMPTY   <- capture.output(print(knitrContainer()))
    expect_equal(summary_EMPTY, print_EMPTY)

    cont <- add_as_section(obj = "TEST")
    cont <- add_as_subsection(cont, obj = "TEST")
    cont <- add_as_text(cont, obj = "TEST")
    print_2   <- capture.output(print(cont,   n=2))
    summary_2 <- capture.output(summary(cont, n=2))
    expect_equal(summary_2, print_2)

})
#  ------------------------------------------------------------------------
