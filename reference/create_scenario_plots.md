# Create Scenario Plots

Create visualizations from MINTe results. Generates plots of prevalence
and/or cases over time for each scenario.

## Usage

``` r
create_scenario_plots(
  results,
  output_dir = NULL,
  plot_type = "both",
  predictor = NULL,
  window_size = 14L,
  plot_tight = FALSE,
  figsize_combined = c(12, 8),
  figsize_individual = c(10, 6),
  dpi = 300L
)
```

## Arguments

- results:

  A data frame of results (e.g., from `results$prevalence`).

- output_dir:

  Character. Directory to save plots. If NULL, plots are returned but
  not saved.

- plot_type:

  Character. Type of plot: "individual", "combined", or "both".

- predictor:

  Character. Predictor type ("prevalence" or "cases"). Auto-detected if
  NULL.

- window_size:

  Integer. Days per timestep. Default 14.

- plot_tight:

  Logical. Use tight y-axis scaling. Default FALSE.

- figsize_combined:

  Numeric vector of length 2. Figure size for combined plot.

- figsize_individual:

  Numeric vector of length 2. Figure size for individual plots.

- dpi:

  Integer. DPI for saved figures. Default 300.

## Value

A list of plot objects (matplotlib figures).

## Examples

``` r
if (FALSE) { # \dontrun{
results <- run_minter_scenarios(...)
plots <- create_scenario_plots(
  results$prevalence,
  output_dir = "plots/",
  plot_type = "both"
)
} # }
```
