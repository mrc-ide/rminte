# Plot Prevalence Over Time (R native)

Create a ggplot2 visualization of prevalence over time. This is a native
R implementation that doesn't require Python plotting.

## Usage

``` r
plot_prevalence(results, scenarios = NULL, title = "Prevalence Over Time")
```

## Arguments

- results:

  A minter_results object or data frame with prevalence data.

- scenarios:

  Character vector. Which scenarios to plot. If NULL, plot all.

- title:

  Character. Plot title.

## Value

A ggplot2 object

## Examples

``` r
if (FALSE) { # \dontrun{
results <- run_minter_scenarios(...)
p <- plot_prevalence(results)
print(p)
} # }
```
