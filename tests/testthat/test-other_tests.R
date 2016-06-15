context("Other unit tests")

test_that("as.knitrContainer() output is correct.", {
    expect_length(as.knitrContainer(), 0)

    expect_is(as.knitrContainer(), "knitrContainer")
    expect_length(as.knitrContainer(1), 1)

    expect_is(as.knitrContainer(list(a = 1, b = "2")), "knitrContainer")
    expect_length(as.knitrContainer(list(a = 1, b = "2")), 2)

    cont <- knitrContainer()
    expect_is(as.knitrContainer(cont), "knitrContainer")
    expect_length(as.knitrContainer(cont), 0)

})


test_that("output of is.knitrContainer() is correct.", {
    expect_false(is.knitrContainer("knitrContainer"))
    expect_false(is.knitrContainer(NULL))
    cont <- knitrContainer()
    expect_true(is.knitrContainer(cont))
    expect_error(is.knitrContainer())

})

test_that("output of Join() is correct.", {
    container <- knitrContainer()
    expect_is(Join(), "knitrContainer")
    expect_length(Join(),0)

    expect_is(Join("any text"), "knitrContainer")
    expect_length(Join("any text"),1)

    expect_length(Join("a","b",add_as_text(obj = "c")),3)

    cont <- knitrContainer()
    expect_length(Join(cont, "a","b",add_as_text(obj = "c")),3)

})

test_that("output of knitrContainer() is correct.", {
    expect_is(knitrContainer(), "list")
    expect_is(knitrContainer(), "knitrContainer")
    expect_error(knitrContainer(1))
})


test_that("Behaviour of `in as_is_*` family is corret when `obj` is missing.", {
    expect_error(add_as_is())
    expect_error(add_as_text())
    expect_error(add_as_plotly_widget())
    expect_error(add_as_pander())
    expect_error(add_as_section())

    # expect_error(add_as_subsection())
    # expect_error(add_as_heading1())
    # expect_error(add_as_heading2())
    # expect_error(add_as_heading3())
    # expect_error(add_as_heading4())

})




test_that("Text output of extract_and_print() is correct.", {
    cont <- add_as_text(obj = "TEST")
    cont <- add_as_is(cont, obj = "TEST")
    OUTPUT  <- capture.output(extract_and_print(cont))
    expect_match(OUTPUT[2], "TEST")
})

# test_that("ggplot as-is output of extract_and_print() is correct.", {
#
#    file = "test-add_as_plotly_widget"
#    writeLines(c(
#            "```{r setup, include=FALSE}",
#            "knitr::opts_chunk$set(echo = TRUE)",
#            "library(plotly)",
#            "library(ggplot2)",
#            "library(magrittr)",
#            "library(knitrContainer)",
#            "```",
#            "",
#            "```{r, results='asis', echo = FALSE}",
#            "container <- knitrContainer()",
#            "for (i in 1:2) container  %<>%",
#            "    add_as_plotly_widget(obj = ggplotly(qplot(1:5,1:5)))",
#            "extract_and_print(container)",
#            "```"),
#         file)
#    knit2html(file, quiet = TRUE)
#    readLines(con = paste0(file, ".html"))
#
#    file.remove(dir(pattern = file))
# })
