
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pkgwatch

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/coatless/pkgwatch.svg?branch=master)](https://travis-ci.com/coatless/pkgwatch)
[![CRAN
status](https://www.r-pkg.org/badges/version/pkgwatch)](https://CRAN.R-project.org/package=pkgwatch)
[![Codecov test
coverage](https://codecov.io/gh/coatless/pkgwatch/branch/master/graph/badge.svg)](https://codecov.io/gh/coatless/pkgwatch?branch=master)
<!-- badges: end -->

The goal of pkgwatch is to prevent *R* packages from being used through
`library()` and `require()` calls. This is useful to prevent
(un)intentional use of packages not approved within a classroom,
research, or company environment.

## Installation

<!--
You can install the released version of pkgwatch from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("pkgwatch")
```

Or, you can be on the cutting-edge development version on GitHub using: -->

This package is only available on GitHub. To install the package, please
use:

``` r
if(!requireNamespace("remotes")) install.packages("remotes")
remotes::install_github("coatless/pkgwatch")
```

## Usage

To use the `pkgwatch` package, load it into *R* using:

``` r
library("pkgwatch")
#> No packages are currently prohibited from being used.
```

From there, any package that is on a blacklist will be prevented from
being loaded. The blacklist can be established on a per-session basis or
can be loaded as needed.

For example, let’s say we didn’t want to allow `toad` to be loaded. We
would call:

``` r
watch_add("toad")
#> Added a watch for {toad}.
```

If we attempted to load `toad` using either `library()` or `require()`,
then we would error:

``` r
library("toad")
#> Detected {toad} package load...
#> The {toad} package is not allowed to be used.
#> Error in as.environment(lib.pos) : invalid 'pos' argument

require("toad")
#> Loading required package: toad
#> Detected {toad} package load...
#> The {toad} package is not allowed to be used.
#> Failed with error:  'invalid 'pos' argument'
```

All packages that are prohibited from being used can be viewed with:

``` r
watch_active()
#> The following packages are prohibited from being used:
#> *  toad
```

To allow the package to be used, we would need to remove the watch:

``` r
watch_remove("toad")
#> Removed a watch for {toad}.
```

Then, the package load would be allowed.

``` r
library("toad")
```

## Motivation

When designing `pkgwatch`, the goal was to achieve a “soft-failure” when
undesirable packages were loaded via `library()` or `require()`.
Generally, this follows in the footsteps of
[`strict`](https://github.com/hadley/strict) – which sought to raise
issues with undesirable design patterns in code – and, subsequently,
[`conflicted`](https://github.com/r-lib/conflicted) – which addressed
search path collisions between similarly named functions in different
packages – both by Hadley Wickham. With this being said, there are
better variants of protecting the *R* process. Most notably, the
[`RAppArmor`](https://cran.r-project.org/package=RAppArmor) by Jeroen
Ooms provides superior sandboxing of *R*. Alternatively, the version of
*R* could simply not have these packages installed to begin with.

Fun fact: The code for this sat in an `untitled.R` file for \~2 years.

## Author

James Joseph Balamuta

## License

GPL (\>= 2)
