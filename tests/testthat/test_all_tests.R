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


test_that("is.knitrContainer() output is correct.", {
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
