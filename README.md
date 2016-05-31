<!-- README.md is generated from README.Rmd. Please edit that file -->
[![CRAN version](http://www.r-pkg.org/badges/version/knitrContainer)](http://cran.rstudio.com/web/packages/knitrContainer/index.html) [![CRAN mirror downloads](http://cranlogs.r-pkg.org/badges/knitrContainer)](http://cran.rstudio.com/web/packages/knitrContainer/index.html) [![codecov.io](https://codecov.io/github/GegznaV/knitrContainer/coverage.svg?branch=master)](https://codecov.io/github/GegznaV/knitrContainer?branch=master) [![Travis-CI Build Status](https://travis-ci.org/GegznaV/knitrContainer.png?branch=master)](https://travis-ci.org/GegznaV/knitrContainer)

Development version of package **knitrContainer**
=================================================

About `knitrContainer`
----------------------

`knitrContainer` is an [R](https://cran.r-project.org/) package designed to collect objects and print them in [`knitr`](http://yihui.name/knitr/) reports.

### Why was it created?

Some objects such as `pander` tables and `plotly` plots, are not printed from inside loop in a `knitr` report file in a regular way.`knitrContainer` solves this problem by providing fuctions to get these objects printed and included in `HTML` files.

### What king of objects can be collectd and printed with `knitrContainer`?

An object used by `knitrContainer` can be any object, that is includable in R list an that is printable, such as :

1.  objects printable with [`pander`](http://rapporter.github.io/pander/);
2.  text;
3.  [`ggplot2`](http://ggplot2.org/), [`plotly`](https://plot.ly/r/) plots;
4.  etc.

How to install the package?
---------------------------

From a GitHub repository:

``` r
library(devtools)
install_github("GegznaV/knitrContainer")
```

How to use `knitrContainer`?
----------------------------

Only 4 things should be done for basic use of `knitrContainer` package :

1.  Create a container(e.g. function `knitrContainer()`);
2.  Add objects to the container (use `add_as_*` family functions, e.g. function `add_as_is()`);
3.  In a R code chunk of [`knitr`](http://yihui.name/knitr/) report file set option `results` to `results='asis'`;
4.  Print the objects appropriately: apply function `print_objects()` in the chunk which has option `results='asis'`.

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

Example how to add objects using the operator `%<>%` from package [`magrittr`](https://github.com/smbache/magrittr#compound-assignment-pipe-operations):

``` r
container %<>% add_as_text("Text added using `%<>%` operator.")
```

It is the same as:

``` r
container <- add_as_text(container, "Text added using `<-` operator.")
```

Type the following code in R to learn more about operator `%<>%`:

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
File updated on <b>2016-06-01</b> with version of package <b>0.0.4</b>
</p>
