context("create_numeration_fun")

## TODO: Rename context
## TODO: Add more tests

test_that("create_numeration_fun() creates a function", {

    iFig   <- create_numeration_fun("Fig.")
    expect_is(iFig, "function")

})

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
test_that("parameters `add_spacecre` and `prefix_bold` work", {

    iFig1   <- create_numeration_fun("")
    expect_equal(iFig1("---"), "**1** ---")

    iFig2   <- create_numeration_fun("", add_space = FALSE)
    expect_equal(iFig2("---"), "**1**---")

    iFig3   <- create_numeration_fun("", prefix_bold = FALSE)
    expect_equal(iFig3("---"), "1 ---")

})
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
test_that("create_numeration_fun() numbers correctly", {

    iFig   <- create_numeration_fun("Fig.")
    a <- lapply(paste("Automatically numbered caption for object",LETTERS[1:5]),
           FUN = iFig);

    expect_equal(iFig("The 6-th object."), "**Fig.6** The 6-th object.")

    # Get count of numbered objects
    n <- iFig(output = "count")
    expect_equal(n, 6)
    expect_equal(iFig(output = "count"), 6)

    # Restart numering
    d <- iFig("Numbering is restarted.", restart = TRUE)
    n_restart <- iFig(output = "count")
    expect_equal(n_restart, 1)
    expect_lt(n_restart, n)

})

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
test_that("create_numeration_fun0() creates a function", {

    iFig   <- create_numeration_fun0()
    expect_is(iFig, "function")

})
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
test_that("create_numeration_fun() numbers correctly", {

    iFig   <- create_numeration_fun0("**Fig.%g** %s")

    a <- lapply(paste("Automatically numbered caption for object", LETTERS[1:5]),
                FUN = iFig);

    expect_equal(iFig("The 6-th object."), "**Fig.6** The 6-th object.")

    # Get count of numbered objects
    n <- iFig(output = "count")
    expect_equal(n, 6)
    expect_equal(iFig(output = "count"), 6)

    # Restart numering
    d <- iFig("Numbering is restarted.", restart = TRUE)
    n_restart <- iFig(output = "count")
    expect_equal(n_restart, 1)
    expect_lt(n_restart, n)

})


