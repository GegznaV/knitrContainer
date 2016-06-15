context("Function format_as_output")
#  ------------------------------------------------------------------------
test_that("Basic functionality of format_as_output() works", {
    expect_error(format_as_output())

    rez1 <- format_as_output(NULL)
    expect_length(rez1,3)
    expect_equal(rez1[1],"```r")
    expect_match(rez1[2],"NULL")
    expect_equal(rez1[3],"```")

    expect_length(format_as_output(summary(cars)),9)
})

#  ------------------------------------------------------------------------


test_that("parameter `comment` of format_as_output() works", {

    rez1 <- format_as_output(NULL)

    knitr::opts_chunk$set(comment = "##")
    rez2 <- format_as_output(NULL, comment = TRUE)

    rez3 <- format_as_output(NULL, comment = "##>")

    knitr::opts_chunk$set(comment = "## >>>")
    rez4 <- format_as_output(NULL, comment = TRUE)

    # Length of each output:
    expect_length(rez1,3)
    expect_length(rez2,3)
    expect_length(rez3,3)
    expect_length(rez4,3)

    # Symbols of comment
    expect_equal(rez1[2]," NULL")
    expect_equal(rez2[2],"## NULL")

    # Manually adds correcly:
    expect_equal(rez3[2],"##> NULL")

    # reads `knitr::opts_chunk` correctly:
    expect_equal(rez4[2],"## >>> NULL")
})
#  ------------------------------------------------------------------------
test_that("parameter `highlight` of format_as_output() works", {

    rez1 <- format_as_output(NULL)
    rez2 <- format_as_output(NULL, highlight = "js")
    rez3 <- format_as_output(NULL, highlight = "python")


    # Length of each output:
    expect_length(rez1,3)
    expect_length(rez2,3)
    expect_length(rez2,3)

    # Symbols of comment
    expect_equal(rez1[1],"```r")
    expect_equal(rez2[1],"```js")
    expect_equal(rez3[1],"```python")
})
#  ------------------------------------------------------------------------
