# Create Scenario Plots (Matplotlib)

Python/matplotlib wrapper for creating visualizations from MINTe
results. This function calls the underlying Python
`minte.create_scenario_plots()` function and returns matplotlib figure
objects.

**Note:** For native R plotting with ggplot2, use
[`plot_prevalence()`](https://mrc-ide.github.io/rminte/reference/plot_prevalence.md)
or
[`plot_cases()`](https://mrc-ide.github.io/rminte/reference/plot_cases.md)
instead, which provide the same functionality using R's ggplot2 graphics
system.

## Usage

``` r
create_scenario_plots_mpl(
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

A list of matplotlib figure objects (Python objects). These can be saved
to files but are not directly viewable in R graphics devices.

## See also

- [`plot_prevalence()`](https://mrc-ide.github.io/rminte/reference/plot_prevalence.md)
  for native R/ggplot2 prevalence plots

- [`plot_cases()`](https://mrc-ide.github.io/rminte/reference/plot_cases.md)
  for native R/ggplot2 cases plots

## Examples

``` r
if (FALSE) { # \dontrun{
results <- run_minter_scenarios(...)
# Save matplotlib plots to files
plots <- create_scenario_plots_mpl(
  results$prevalence,
  output_dir = "plots/",
  plot_type = "both"
)

# For interactive R plotting, use the native functions instead:
p <- plot_prevalence(results)
print(p)
} # }
```
