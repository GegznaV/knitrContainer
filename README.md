
<!-- README.md is generated from README.Rmd. Please edit that file -->

-----

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
version](http://www.r-pkg.org/badges/version/knitrContainer)](https://cran.r-project.org/package=knitrContainer)
[![GitHub
version](https://img.shields.io/badge/GitHub-v0.0.28-brightgreen.svg)](https://github.com/GegznaV/knitrContainer)
[![Last-update](https://img.shields.io/badge/last%20update-2018--07--27-yellowgreen.svg)](/commits/master)
[![Travis-CI Build
Status](https://travis-ci.org/GegznaV/knitrContainer.svg?branch=master)](https://travis-ci.org/GegznaV/knitrContainer)
[![codecov.io](https://codecov.io/github/GegznaV/knitrContainer/coverage.svg?branch=master)](https://codecov.io/github/GegznaV/knitrContainer?branch=master)

-----

<img src="https://raw.githubusercontent.com/GegznaV/knitrContainer/master/docs/logo.png" width="40%" height="40%" style="display: block; margin: auto;" />

<!-- **knitrContainer** - collect and print multiple objects in a `Knitr` R Markdown report -->

# R package `knitrContainer`

## About `knitrContainer`

`knitrContainer` is an [R](https://cran.r-project.org/) package. Its
purpose is to collect objects (*especially* those generated in loops)
and print them in [`knitr`](http://yihui.name/knitr/) – [R
Markdown](http://rmarkdown.rstudio.com/) reports.

### Why was it created?

Some objects such as `pander` tables and `plotly` plots, are not printed
from inside loop in a `knitr` report file in a regular
way.`knitrContainer` solves this problem by providing fuctions to get
these objects printed and included in `HTML`
files.

### What kind of objects can be collectd and printed with `knitrContainer`?

An object used by `knitrContainer` can be any object, that is includable
in R list an that is printable, such as :

1.  text;
2.  summaries of data frames;
3.  objects printable with
    [`pander`](http://rapporter.github.io/pander/);
4.  [`ggplot2`](http://ggplot2.org/), [`plotly`](https://plot.ly/r/)
    plots;
5.  etc.

## How to install the package?

Install development version from GitHub:

``` r
if (!require(devtools)) install.packages("devtools")
library(devtools)
install_github("GegznaV/knitrContainer")
```

## How to use `knitrContainer`?

Only 4 actions (in short: *“CASP”*) should be done for basic use of
`knitrContainer` package:

1.  **Create** a container (e.g. use function `knitrContainer()`);
2.  **Add** objects to the container (use `add_as_*` family functions,
    e.g. `add_as_is()`);
3.  **Set** option `results` to `results='asis'` in a chunk of R code in
    [`knitr`](http://yihui.name/knitr/) report file;
4.  **Print** the collected objects appropriately by applying function
    `print_all()` in the chunk which has option `results='asis'`.

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

Example how to add objects using the operator `%<>%` from package
[`magrittr`](https://github.com/smbache/magrittr#compound-assignment-pipe-operations):

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

## About Documentation of Development Version

Meaning of symbols in function descriptions:

  - \[+\] Well documented function.
  - \[\!\], \[\!\!\!\] Documentation needs attention.
  - \[\!+\] Updated description of a function, which was well-documented
    (some parts may be poor or not documented).
  - \[.\] Function may be removed, renamed or changed.

-----
