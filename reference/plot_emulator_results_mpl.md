# Plot Emulator Results (Matplotlib)

Python/matplotlib wrapper for plotting emulator results. This function
calls the underlying Python plotting function and returns matplotlib
figure objects.

**Note:** For native R plotting with ggplot2, use
[`plot_prevalence()`](https://mrc-ide.github.io/rminte/reference/plot_prevalence.md)
or
[`plot_cases()`](https://mrc-ide.github.io/rminte/reference/plot_cases.md)
instead.

## Usage

``` r
plot_emulator_results_mpl(results, output_dir = NULL, ...)
```

## Arguments

- results:

  Results from
  [`run_malaria_emulator()`](https://mrc-ide.github.io/rminte/reference/run_malaria_emulator.md)
  or similar.

- output_dir:

  Character. Directory to save plots.

- ...:

  Additional arguments passed to the Python function.

## Value

Matplotlib figure objects (Python objects). These can be saved to files
but are not directly viewable in R graphics devices.

## See also

- [`plot_prevalence()`](https://mrc-ide.github.io/rminte/reference/plot_prevalence.md)
  for native R/ggplot2 prevalence plots

- [`plot_cases()`](https://mrc-ide.github.io/rminte/reference/plot_cases.md)
  for native R/ggplot2 cases plots
