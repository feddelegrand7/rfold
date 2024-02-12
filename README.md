
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rfold

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/rfold)](https://CRAN.R-project.org/package=rfold)
[![metacran
downloads](https://cranlogs.r-pkg.org/badges/rfold)](https://cran.r-project.org/package=rfold)
[![metacran
downloads](https://cranlogs.r-pkg.org/badges/grand-total/rfold)](https://cran.r-project.org/package=rfold)
<!-- badges: end -->

An introductory video can be found
[here](https://www.youtube.com/watch?v=q-GT7q0v_YA&ab_channel=RforPROD)

The goal of the `rfold` package is to allow `R` developers to work with
many `R` directories within an `R` package. A considerable limitation
regarding `R` packages development, is that one cannot create other
directories/sub directories (other than the `R` directory) and bind them
to the package ecosystem.

Using `rfold`, you can create as many directories/sub directories
(**outside of your `R` directory**).

The `rfold()` function will list all the `.R` scripts available outside
of the `R` folder, assign their names to `.Rbuildignore` file and
transfer them within the main `R` directory, giving you all the
flexibility you need to organize your package into many
directories/sub-directories.

## Working with `test` files

Using `rfold`, you can arrange your test file however you want, you can
for example put your test and R scripts in one folder. To do so, you
need to append the `test-` word to the name of your test files. For
example, `test-myapi.R`. This way `rfold` will recognize it as a test
file and move it within the correct folder.

At the moment, `rfold` works only with the `testthat` framework, feel
free to open an issue if other test framework should be supported

## Installation

You can install the development version of `rfold` with:

``` r
install.packages("rfold")
```

## Usage

Just use `rfold::rfold()` before building or documenting your package
and you’re all set. If you’re tired of running `rfold::rfold()`, then
`devtools::load_all()` each time, you can create a function that does
both, for example:

``` r
rfold_load_all <- function() {
  rfold::rfold()
  devtools::load_all()
}
```

This way, you’ll be sure to work with the last state of your package.

## Example

Suppose that within this package, I would decide to have the following
structure:

``` r
fs::dir_tree()
```

    ## .
    ## +-- api
    ## |   +-- api_call.R
    ## |   \-- test-api_call.R
    ## +-- DESCRIPTION
    ## +-- main
    ## |   +-- main1.R
    ## |   +-- main2.R
    ## |   \-- test-main
    ## |       +-- test-file1.R
    ## |       \-- test-file2.R
    ## +-- man
    ## +-- NAMESPACE
    ## +-- R
    ## +-- README.md
    ## +-- README.Rmd
    ## +-- rfoldtester.Rproj
    ## +-- tests
    ## |   +-- testthat
    ## |   \-- testthat.R
    ## \-- utilities
    ##     +-- test-utils1.R
    ##     +-- test-utils2.R
    ##     +-- utils1.R
    ##     \-- utils2.R

Running `rfold::rfold()`, all the external (external to the `R` folder)
`.R` scripts will be moved within the `R` or `tests` folder, depending
on the type of file (note that if the `tests` folder is not available,
`rfold` will create it for you):

``` r
rfold::rfold()
```

    ## v Setting active project to 'C:/Users/Administrateur/Desktop/rfoldtester'i Copying the following R files with prefix 'DO_NOT_EDIT_' into the R folder: api/api_call.R, main/main1.R, main/main2.R, utilities/utils1.R, utilities/utils2.R
    ## i Copying the following tests files with prefix 'DO_NOT_EDIT_' into the tests/testthat folder: api/test-api_call.R, main/test-main/test-file1.R, main/test-main/test-file2.R, utilities/test-utils1.R, utilities/test-utils2.R

As such, we will get now the following structure:

``` r
fs::dir_tree()
```

    ## .
    ## +-- api
    ## |   +-- api_call.R
    ## |   \-- test-api_call.R
    ## +-- DESCRIPTION
    ## +-- main
    ## |   +-- main1.R
    ## |   +-- main2.R
    ## |   \-- test-main
    ## |       +-- test-file1.R
    ## |       \-- test-file2.R
    ## +-- man
    ## +-- NAMESPACE
    ## +-- R
    ## |   +-- DO_NOT_EDIT_api_call.R
    ## |   +-- DO_NOT_EDIT_main1.R
    ## |   +-- DO_NOT_EDIT_main2.R
    ## |   +-- DO_NOT_EDIT_utils1.R
    ## |   \-- DO_NOT_EDIT_utils2.R
    ## +-- README.md
    ## +-- README.Rmd
    ## +-- rfoldtester.Rproj
    ## +-- tests
    ## |   +-- testthat
    ## |   |   +-- test-DO_NOT_EDIT_api_call.R
    ## |   |   +-- test-DO_NOT_EDIT_file1.R
    ## |   |   +-- test-DO_NOT_EDIT_file2.R
    ## |   |   +-- test-DO_NOT_EDIT_utils1.R
    ## |   |   \-- test-DO_NOT_EDIT_utils2.R
    ## |   \-- testthat.R
    ## \-- utilities
    ##     +-- test-utils1.R
    ##     +-- test-utils2.R
    ##     +-- utils1.R
    ##     \-- utils2.R

Notice, that script names that will be transferred to the `R` folder
have their name prefixed with the character `DO_NOT_EDIT`. You can tweak
this feature or deactivate it using the `script_name_prefix` parameter
of the `rfold()` function. Concerning the `test` file, they have to
start with `test-` word in order to be tested, as such, the
`script_name_prefix` will be appended after the `test-` part.

The following comment will also be inserted at the top of each script
that will be moved with `rfold`: **\# GENERATED BY FOLD: DO NOT EDIT BY
HAND \####**

There’s another parameter available, called `folders_to_ignore` which
allows you to ignore certain directories (for example `dev` directory)
when running the `rfold` function.

Note also that `devtools::build()` and `devtools::document()` will only
consider the scripts available within your `R` folder.

## Code of Conduct

Please note that the rfold project is released with a [Contributor Code
of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
