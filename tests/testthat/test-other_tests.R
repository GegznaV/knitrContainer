context("Other unit tests")

#  ------------------------------------------------------------------------


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

#  ------------------------------------------------------------------------



test_that("output of is.knitrContainer() is correct.", {
    expect_false(is.knitrContainer("knitrContainer"))
    expect_false(is.knitrContainer(NULL))
    cont <- knitrContainer()
    expect_true(is.knitrContainer(cont))
    expect_error(is.knitrContainer())

})

#  ------------------------------------------------------------------------


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

#  ------------------------------------------------------------------------


test_that("output of knitrContainer() is correct.", {
    expect_is(knitrContainer(), "list")
    expect_is(knitrContainer(), "knitrContainer")
    expect_error(knitrContainer(1))
})


#  ------------------------------------------------------------------------





