# Preload All Models

Pre-load all neural network models into the cache for faster subsequent
predictions. This is useful when you want to minimize latency for the
first prediction call.

## Usage

``` r
preload_all_models()
```

## Value

Invisible NULL

## Examples

``` r
if (FALSE) { # \dontrun{
# Pre-load models at startup
preload_all_models()

# Now predictions will be faster
results <- run_minter_scenarios(...)
} # }
```
