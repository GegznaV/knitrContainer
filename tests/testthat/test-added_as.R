context("Function added_as")

#  ------------------------------------------------------------------------


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

#  ------------------------------------------------------------------------

test_that("attribute `added_as` is added correctly.", {
    # As is ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    expect_identical(added_as(add_as_is(obj   = "text")[[1]]),  "As is")

    # As text ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    expect_identical(added_as(add_as_text(obj      = "text")[[1]]), "Text")
    expect_identical(added_as(add_as_paragraph(obj = "text")[[1]]), "Text")
    expect_match(added_as(add_as_strings(obj       = "text")[[1]]), "Strings")

    # As plotly widget ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    AS3 <- added_as(add_as_plotly_widget(obj = plotly::plot_ly())[[1]])
    expect_identical(AS3, "Plotly widget")

    AS4 <- added_as(add_as_plotly_widget(obj = ggplot2::qplot(1:5,1:5))[[1]])
    expect_identical(AS4,"Plotly widget")

    expect_error(add_as_plotly_widget(obj = "text"))

    # As pander ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    expect_match(added_as(add_as_pander(obj  = "text")[[1]]),  "Pander")

    # As section ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    expect_match(added_as(add_as_section(obj    = "text")[[1]]),   "Section")
    expect_match(added_as(add_as_subsection(obj = "text")[[1]]),   "Section")
    expect_match(added_as(add_as_heading1(obj   = "text")[[1]]),   "Section")
    expect_match(added_as(add_as_heading2(obj   = "text")[[1]]),   "Section")
    expect_match(added_as(add_as_heading3(obj   = "text")[[1]]),   "Section")
    expect_match(added_as(add_as_heading4(obj   = "text")[[1]]),   "Section")

    # As Output ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    expect_match(added_as(add_as_r_output(obj   = "text")[[1]]), "Printed")
    expect_match(added_as(add_as_printed(obj    = "text")[[1]]), "Printed")
    expect_match(added_as(add_as_printed_r(obj  = "text")[[1]]), "Printed")

    # As Code to evaluate  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    expect_match(added_as(add_as_code(obj = print("text"))[[1]]), "Code")
    expect_match(added_as(add_as_code(        obj = print("text"))[[1]]), "Code")

    # As Data ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    expect_match(added_as(add_as_data(obj = "text")[[1]]),  "Data")

    # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



})
