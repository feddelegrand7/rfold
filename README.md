
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fold

<!-- badges: start -->
<!-- badges: end -->

The goal of the `fold` package is to allow `R` developers to work with
many `R` directories within an `R` package. A considerable limitation
regarding `R` packages development, is that one cannot create other
directories/sub directories (other than the `R` directory) and bind them
to the package ecosystem.

Using `fold`, you can create as many directories/sub directories
(**outside of your `R` directory**).

The `fold()` function will list all the `.R` scripts available outside
of the `R` folder, assign their names to `.Rbuildignore` file and
transfer them within the main `R` directory, giving you all the
flexibility you need to organize your package into many
directories/sub-directories.

## Installation

You can install the development version of `fold` with:

``` r
remotes::install_github("feddelegrand7/fold")
```

## Usage

Just use `fold::fold()` before building or documenting your package and
you’re all set.

## Example

Suppose that within this package, I would decide to have the following
structure:

    #> .
    #> +-- CODE_OF_CONDUCT.md
    #> +-- DESCRIPTION
    #> +-- fold.Rproj
    #> +-- helper_functions
    #> |   +-- utilities.R
    #> |   \-- wrappers.R
    #> +-- LICENSE
    #> +-- LICENSE.md
    #> +-- man
    #> |   \-- fold.Rd
    #> +-- NAMESPACE
    #> +-- R
    #> |   \-- main.R
    #> +-- README.md
    #> +-- README.Rmd
    #> +-- services
    #> |   \-- api
    #> |       \-- api_functions.R
    #> \-- tests
    #>     +-- testthat
    #>     |   \-- test-main.R
    #>     \-- testthat.R

Running `fold::fold()`, all the external (external to the `R` folder)
`.R` scripts will be moved within the `R` folder:

``` r
fold::fold()
#> v Setting active project to 'C:/Users/Administrateur/Desktop/fold'v Adding '^helper_functions$', '^services$', '^api$' to '.Rbuildignore'i Copying the following R files into the R folder: helper_functions/utilities.R, helper_functions/wrappers.R, services/api/api_functions.R
#> v Success
```

As such, I’ll get now the following structure:

    #> .
    #> +-- CODE_OF_CONDUCT.md
    #> +-- DESCRIPTION
    #> +-- fold.Rproj
    #> +-- helper_functions
    #> |   +-- utilities.R
    #> |   \-- wrappers.R
    #> +-- LICENSE
    #> +-- LICENSE.md
    #> +-- man
    #> |   \-- fold.Rd
    #> +-- NAMESPACE
    #> +-- R
    #> |   +-- api_functions.R
    #> |   +-- main.R
    #> |   +-- utilities.R
    #> |   \-- wrappers.R
    #> +-- README.md
    #> +-- README.Rmd
    #> +-- services
    #> |   \-- api
    #> |       \-- api_functions.R
    #> \-- tests
    #>     +-- testthat
    #>     |   \-- test-main.R
    #>     \-- testthat.R

Note `devtools::build()` and `devtools::document()` will only consider
the scripts available within your `R` folder.

## Code of Conduct

Please note that the fold project is released with a [Contributor Code
of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
