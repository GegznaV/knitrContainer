context("create_thumbnail")

## TODO: Rename context
## TODO: Add more tests

test_that("multiplication works", {

  fn <- "test.png"

  # Create image
  png(filename = fn, 1000, 1000);  plot(1,2);  silent <- dev.off();
  size_fn <- file.info(fn)$size

  # Create a thumbnail
  tn1 <- create_thumbnail(fn);

  expect_equal(tn1, "test_small.png");
  size_tn1 <- file.info(tn1)$size

  # Test that "overwrite" works
  tn2 <- create_thumbnail(fn, w = 250);
  size_tn2 <- file.info(tn2)$size

  tn3 <- create_thumbnail(fn, w = 200, overwrite = TRUE);
  size_tn3 <- file.info(tn3)$size

  # Tests
  expect_lt(size_tn1, size_fn);
  expect_lt(size_tn2, size_fn);
  expect_lt(size_tn3, size_fn);

  expect_lt(size_tn3, size_tn2);
  expect_lt(size_tn3, size_tn1);

  expect_equal(size_tn2, size_tn1);

  # Clear
  sitent <- file.remove(fn,tn1)
})
