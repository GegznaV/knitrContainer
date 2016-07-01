
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/knitrContainer)](https://cran.r-project.org/package=knitrContainer)
[![GitHub version](https://img.shields.io/badge/GitHub-v0.0.15-brightgreen.svg)](https://github.com/GegznaV/knitrContainer) [![Travis-CI Build Status](https://travis-ci.org/GegznaV/knitrContainer.png?branch=master)](https://travis-ci.org/GegznaV/knitrContainer) [![codecov.io](https://codecov.io/github/GegznaV/knitrContainer/coverage.svg?branch=master)](https://codecov.io/github/GegznaV/knitrContainer?branch=master)

Development version of R package **knitrContainer**
===================================================

About `knitrContainer`
----------------------

`knitrContainer` is an [R](https://cran.r-project.org/) package. Its purpose is to collect objects (*especially* those generated in loops) and print them in [`knitr`](http://yihui.name/knitr/) - [R Markdown](http://rmarkdown.rstudio.com/) reports.

### Why was it created?

Some objects such as `pander` tables and `plotly` plots, are not printed from inside loop in a `knitr` report file in a regular way.`knitrContainer` solves this problem by providing fuctions to get these objects printed and included in `HTML` files.

### What kind of objects can be collectd and printed with `knitrContainer`?

An object used by `knitrContainer` can be any object, that is includable in R list an that is printable, such as :

1.  text;
2.  summaries of data frames;
3.  objects printable with [`pander`](http://rapporter.github.io/pander/);
4.  [`ggplot2`](http://ggplot2.org/), [`plotly`](https://plot.ly/r/) plots;
5.  etc.

How to install the package?
---------------------------

Install development version from GitHub:

``` r
if (!require(devtools)) install.packages("devtools")
library(devtools)
install_github("GegznaV/knitrContainer")
```

How to use `knitrContainer`?
----------------------------

Only 4 actions (in short: *"CASP"*) should be done for basic use of `knitrContainer` package:

1.  **Create** a container (e.g. use function `knitrContainer()`);
2.  **Add** objects to the container (use `add_as_*` family functions, e.g. `add_as_is()`);
3.  **Set** option `results` to `results='asis'` in a chunk of R code in [`knitr`](http://yihui.name/knitr/) report file;
4.  **Print** the collected objects appropriately by applying function `print_all()` in the chunk which has option `results='asis'`.

### Example 1

``` r
library(knitrContainer)
```

``` r
# Create
container <- knitrContainer()
# Collect
container <- add_as_text(container, "Text to be added.")
# Print
print_all(container)
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

About Documentation of Development Version
------------------------------------------

Meaning of symbols in function descriptions:

-   \[+\] Well documented function.
-   \[!\], \[!!!\] Documentation needs attention.
-   \[!+\] Updated description of a function, which was well-documented (some parts may be poor or not documented).
-   \[.\] Function may be removed, renamed or changed.

------------------------------------------------------------------------

<p align="right">
File updated on <b>2016-07-01</b> with version of package <b>0.0.15</b>
</p>
