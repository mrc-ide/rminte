# Install minte Python package

Installs the minte Python package. This is typically not needed if using
the default reticulate ephemeral environment, as `py_require("minte")`
will handle installation automatically.

For users who prefer to manually manage their Python environment, this
function provides a convenient way to install minte.

## Usage

``` r
install_minte(envname = "r-minte", method = "auto", ...)
```

## Arguments

- envname:

  Name of the virtual environment. Default is "r-minte".

- method:

  Installation method. Default is "auto".

- ...:

  Additional arguments passed to
  [`reticulate::py_install()`](https://rstudio.github.io/reticulate/reference/py_install.html).

## Value

Invisible NULL

## Examples

``` r
if (FALSE) { # \dontrun{
# Install into a dedicated environment
install_minte(envname = "r-minte")

# Then activate it before using rminte
reticulate::use_virtualenv("r-minte")
library(rminte)
} # }
```
