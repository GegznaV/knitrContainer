context("test print() and summary()")


test_that("Output of summary.knitrContainer() is correct.", {
    summary_EMPTY <- capture.output(summary(knitrContainer()))
    expect_match(summary_EMPTY, "Empty container")

    summary_1 <- capture.output(summary(as.knitrContainer("a")))
    expect_match(summary_1[2], "knitr container")
    expect_match(summary_1[4], "Contains 1 object")
    expect_match(summary_1[7], "1 As is")


    cont <- add_as_section(obj = "TEST")
    cont <- add_as_subsection(cont, obj = "TEST")
    cont <- add_as_text(cont, obj = "TEST")

    summary_2 <- capture.output(summary(cont, n=2))
    expect_match(summary_2[2], "knitr container")
    expect_match(summary_2[4], "Contains 3 obj")
    expect_match(summary_2[9], "\\.\\.\\. ")
})

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
