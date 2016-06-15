context("Functions print() and summary()")

#  ------------------------------------------------------------------------
test_that("Output of summary.knitrContainer() is correct.", {

    # Output of emply container
    summary_EMPTY <- capture.output(summary(knitrContainer()))
    expect_match(summary_EMPTY, "Empty container")

    # Basic structure of output
    summary_1 <- capture.output(summary(as.knitrContainer("a")))
    expect_match(summary_1[2], "knitr container")
    expect_match(summary_1[4], "Contains 1 object")
    expect_match(summary_1[7], "1 As is")


    cont <- add_as_section(obj = "TEST")
    cont <- add_as_subsection(cont, obj = "TEST")
    cont <- add_as_text(cont, obj = "TEST")

    # Truncated number of lines
    summary_2 <- capture.output(summary(cont, n=2))
    expect_match(summary_2[2], "knitr container")
    expect_match(summary_2[4], "Contains 3 obj")
    expect_match(summary_2[9], "\\.\\.\\. ")
    expect_match(summary_2[11], "were not displayed!")


    # Truncated length of Preview field
    summary_3 <- capture.output(summary(cont, len = 5))
    expect_match(summary_3[2], "knitr container")
    expect_match(summary_3[4], "Contains 3 obj")
    expect_match(summary_3[7], "# \\.\\.\\. ")
    expect_match(summary_3[8], "##\\.\\.\\. ")

})

#  ------------------------------------------------------------------------
#
test_that("`Preview field of summary.knitrContainer() is correct.", {

    # Create container
    cont <- knitrContainer()
    cont <- add_as_text(cont, "Text")
    cont <- add_as_data(cont, cars)
    cont <- add_as_code_to_eval(cont, summary(cars))
    cont <- add_as_is(cont, cars)


    # Values in `Preview`
    summary_1 <- capture.output(summary(cont))
    expect_match(summary_1[7], "1 Text.*Text")
    expect_match(summary_1[8], "2 Data.*cars")
    expect_match(summary_1[9], "3 Code.*summary\\(cars\\)")
    expect_match(summary_1[10],"4 As is")

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
    print_2   <- capture.output(print(cont, n=2))
    summary_2 <- capture.output(summary(cont, n=2))
    expect_equal(summary_2, print_2)

})
#  ------------------------------------------------------------------------
