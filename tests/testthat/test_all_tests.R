context("Unit.tests")

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

})

test_that("Output of added_as() is correct.", {
    type_added   <- added_as("a", "As is")
    keep_the_type<- added_as(type_added, "NEW")
    replace_type <- added_as(type_added, "NEW", force.TYPE = TRUE)

    expect_error(added_as())
    expect_identical(added_as("a"),          NULL)
    expect_identical(added_as(type_added),   "As is")
    expect_identical(added_as(keep_the_type),"As is")
    expect_identical(added_as(replace_type), "NEW")
})


test_that("attribute `added_as` is added correctly.", {

    expect_identical(added_as(add_as_is(obj = "text")[[1]]),    "As is")
    expect_identical(added_as(add_as_text(obj = "text")[[1]]),  "Text")

    AS3 <- added_as(add_as_plotly_widget(obj = plot_ly())[[1]])
    expect_identical(AS3, "Plotly widget")

    AS4 <- added_as(add_as_plotly_widget(obj = qplot(1:5,1:5))[[1]])
    expect_identical(AS4,"Plotly widget")

    expect_error(add_as_plotly_widget(obj = "text"))

    expect_match(added_as(add_as_pander(obj = "text")[[1]]),  "Pander")

    expect_match(added_as(add_as_section(obj = "text")[[1]]),    "Section")
    expect_match(added_as(add_as_subsection(obj = "text")[[1]]), "Section")
    expect_match(added_as(add_as_heading1(obj = "text")[[1]]),   "Section")
    expect_match(added_as(add_as_heading2(obj = "text")[[1]]),   "Section")
    expect_match(added_as(add_as_heading3(obj = "text")[[1]]),   "Section")
    expect_match(added_as(add_as_heading4(obj = "text")[[1]]),   "Section")

})


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

test_that("Text output of print_objects() is correct.", {
    cont <- add_as_text(obj = "TEST")
    cont <- add_as_is(cont, obj = "TEST")
    OUTPUT   <- capture.output(print_objects(cont))
    expect_match(OUTPUT[2], "TEST")
})

# test_that("ggplot as-is output of print_objects() is correct.", {
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
#            "print_objects(container)",
#            "```"),
#         file)
#    knit2html(file, quiet = TRUE)
#    readLines(con = paste0(file, ".html"))
#
#    file.remove(dir(pattern = file))
# })
