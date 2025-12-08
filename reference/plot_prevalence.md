# Plot Prevalence Over Time

Create a ggplot2 visualization of prevalence over time. This is the
recommended plotting function for R users, providing native R graphics
that integrate with the R ecosystem (RStudio plots pane, R Markdown,
etc.).

This function provides equivalent functionality to the Python
`minte.create_scenario_plots()` function but uses ggplot2 instead of
matplotlib.

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

A ggplot2 object that can be printed, saved with
[`ggsave()`](https://ggplot2.tidyverse.org/reference/ggsave.html), or
further customized with ggplot2 functions.

## See also

- [`plot_cases()`](https://mrc-ide.github.io/rminte/reference/plot_cases.md)
  for plotting clinical cases

- [`create_scenario_plots_mpl()`](https://mrc-ide.github.io/rminte/reference/create_scenario_plots_mpl.md)
  for Python/matplotlib plotting (saves to files)

## Examples

``` r
if (FALSE) { # \dontrun{
results <- run_minter_scenarios(...)

# Basic plot
p <- plot_prevalence(results)
print(p)

# Filter to specific scenarios
p <- plot_prevalence(results, scenarios = c("scenario_1", "scenario_2"))

# Customize with ggplot2
p <- plot_prevalence(results) +
  ggplot2::theme_bw() +
  ggplot2::scale_color_brewer(palette = "Set1")

# Save to file
ggplot2::ggsave("prevalence.png", p, width = 10, height = 6)
} # }
```
