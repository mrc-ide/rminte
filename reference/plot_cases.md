# Plot Cases Over Time (R native)

Create a ggplot2 visualization of clinical cases over time.

## Usage

``` r
plot_cases(results, scenarios = NULL, title = "Clinical Cases Over Time")
```

## Arguments

- results:

  A minter_results object or data frame with cases data.

- scenarios:

  Character vector. Which scenarios to plot. If NULL, plot all.

- title:

  Character. Plot title.

## Value

A ggplot2 object
