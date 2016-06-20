context("Function format_as_code")
#  ------------------------------------------------------------------------
test_that("Basic functionality of format_as_code() works", {
    expect_error(format_as_code())

    rez1 <- format_as_code(NULL)
    expect_length(rez1,3)
    expect_equal(rez1[1],"```r")
    expect_match(rez1[2],"NULL")
    expect_equal(rez1[3],"```")

    expect_length(format_as_code(summary(cars)),9)
})

#  ------------------------------------------------------------------------


test_that("parameter `comment` of format_as_code() works", {

    rez1 <- format_as_code(NULL)

    knitr::opts_chunk$set(comment = "##")
    rez2 <- format_as_code(NULL, comment = TRUE)

    rez3 <- format_as_code(NULL, comment = "##>")

    knitr::opts_chunk$set(comment = "## >>>")
    rez4 <- format_as_code(NULL, comment = TRUE)

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
test_that("parameter `highlight` of format_as_code() works", {

    rez1 <- format_as_code(NULL)
    rez2 <- format_as_code(NULL, highlight = "js")
    rez3 <- format_as_code(NULL, highlight = "python")
    rez4 <- format_as_code(NULL, highlight = FALSE)
    rez5 <- format_as_code(NULL, highlight = "")


    # Length of each output:
    expect_length(rez1,3)
    expect_length(rez2,3)
    expect_length(rez3,3)
    expect_length(rez4,3)
    expect_length(rez5,3)

    # Symbols of comment
    expect_equal(rez1[1],"```r")
    expect_equal(rez2[1],"```js")
    expect_equal(rez3[1],"```python")
    expect_equal(rez4[1],"```")
    expect_equal(rez5[1],"```")
})
#  ------------------------------------------------------------------------
