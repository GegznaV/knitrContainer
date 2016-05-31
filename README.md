<!-- README.md is generated from README.Rmd. Please edit that file -->
[![CRAN version](http://www.r-pkg.org/badges/version/knitrContainer)](http://cran.rstudio.com/web/packages/knitrContainer/index.html) [![CRAN mirror downloads](http://cranlogs.r-pkg.org/badges/knitrContainer)](http://cran.rstudio.com/web/packages/knitrContainer/index.html) [![Issue Stats](http://issuestats.com/github/GegznaV/knitrContainer/badge/pr?style=flat)](http://issuestats.com/github/GegznaV/knitrContainer) [![Issue Stats](http://issuestats.com/github/GegznaV/knitrContainer/badge/issue?style=flat)](http://issuestats.com/github/GegznaV/knitrContainer)

[![codecov.io](https://codecov.io/github/GegznaV/knitrContainer/coverage.svg?branch=master)](https://codecov.io/github/GegznaV/knitrContainer?branch=master)

[![Travis-CI Build Status](https://travis-ci.org/GegznaV/knitrContainer.png?branch=master)](https://travis-ci.org/GegznaV/knitrContainer)

Developement version of package `knitrContainer`
================================================

About `knitrContainer`
----------------------

### What is `knitrContainer`?

`knitrContainer` is an R package designed to collect objects and print them in `R Markdown`.

### Why was it created?

Some objecs such as `pander` tables and `plotly` plots, are not printed from insite loop in `R Markdown` file in a regular way.`knitrContainer` solves this problem by allowing these objects to be printed and included in `HTML` files.

### What objects can be collectd and printed with `knitrContainer`?

An object used by `knitrContainer` can be any object, that is includable in R list an that is printable, such as objects, printable with `pander`, text, as well as `ggplot2`, `plotly` plots, etc.

How to install the package?
---------------------------

From GitHub repository:

``` r
library(devtools)
install_github("GegznaV/knitrContainer")
```

How to use `knitrContainer`?
----------------------------

For basic use `knitrContainer` only 3 things should be done:

1.  A container must be created (e.g. function `knitrContainer()`);
2.  The container must filled (`add_as_*` family functions, e.g. function `add_as_is()`);
3.  The collected contens of the container must be printed appropriately (option `results` in R code chunk set to `'asis'` and use function `print_objects()`).

### Example 1

``` r
library(knitrContainer)
```

``` r
container <- knitrContainer()
container <- add_as_text(container, "Text to be added.")
print_objects(container)
```

### Example 2

Example how to add objects using the operator `%<>%` fom package [`magrittr`](https://github.com/smbache/magrittr#compound-assignment-pipe-operations):

``` r
container %<>% add_as_text("Text added using `%<>%` operator.")
```

It is the same as:

``` r
container <- add_as_text(container, "Text added using `<-` operator.")
```

Type the following code in R to learn more abput operator `%<>%`:

``` r
?`%<>%`
```

### More Examples

``` r
vignette("v1_examples", package = "knitrContainer")
```

About Documentation
-------------------

Meaning of symbols in function descriptions:

-   \[+\] Well documented function.
-   \[!\], \[!!!\] Documentation needs attention.
-   \[!+\] Updated function, which was well-documented (some parts may be poor or not documented).
-   \[.\] function may be removed, renamed or changed.

------------------------------------------------------------------------

<p align="right">
File updated on <b>2016-05-31</b> with version of package <b>0.0.1</b>
</p>
