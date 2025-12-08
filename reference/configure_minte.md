# Configure Python environment for minte

Allows users to specify additional Python requirements or constraints
before Python is initialized. Must be called before any minte functions.

## Usage

``` r
configure_minte(python_version = NULL, gpu = FALSE, ...)
```

## Arguments

- python_version:

  Optional Python version constraint (e.g., "\>=3.9").

- gpu:

  Logical. If TRUE, request GPU-enabled torch. Default FALSE.

- ...:

  Additional arguments passed to
  [`reticulate::py_require()`](https://rstudio.github.io/reticulate/reference/py_require.html).

## Value

Invisible NULL

## Examples

``` r
if (FALSE) { # \dontrun{
# Request specific Python version
configure_minte(python_version = ">=3.10")

# Then use minte as normal
results <- run_minter_scenarios(...)
} # }
```
