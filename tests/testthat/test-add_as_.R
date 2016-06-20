context("Functions add_as_*()")

## TODO: Rename context
## TODO: Add more tests

#  ------------------------------------------------------------------------


test_that("`add_as_*()` functions throw error when `obj` is missing.", {
    expect_error(add_as_is())
    expect_error(add_as_text())
    expect_error(add_as_plotly_widget())
    expect_error(add_as_pander())
    expect_error(add_as_section())

    expect_error(add_as_command())
    expect_error(add_as_cmd())
    expect_error(add_as_cmd_str())
    expect_error(add_as_data())



    # expect_error(add_as_subsection())
    # expect_error(add_as_heading1())
    # expect_error(add_as_heading2())
    # expect_error(add_as_heading3())
    # expect_error(add_as_heading4())

})


