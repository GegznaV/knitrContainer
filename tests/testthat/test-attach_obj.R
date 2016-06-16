context("Function attach_obj()")

## TODO: Rename context
## TODO: Add more tests

test_that("attach_obj() works", {
    l <- list()

    # Too few input elements
    expect_error(attach_obj())
    expect_error(attach_obj(l))

    # If `obj` is NULL
    expect_warning(attach_obj(l, NULL))

   # Test that adds correct object
    expect_equal(attach_obj(obj = "2")[[1]],    "2")
    expect_equal(attach_obj(l, obj = "2")[[1]], "2")

    # Test that length is correct
    l1 <- attach_obj(l, "ppp")
    expect_length(l1, 1)

    l2 <- attach_obj(l1, "ddd")
    expect_length(l2, 2)

    # Test that attaches to the end
    expect_equal(l2[[2]], "ddd")

})

