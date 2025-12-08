# Changelog

## rminte 0.1.0

- Initial release of rminte, an R interface to Python’s MINTe package.

### Features

- [`run_minter_scenarios()`](https://mrc-ide.github.io/rminte/reference/run_minter_scenarios.md) -
  High-level function to run malaria intervention scenarios
- [`run_malaria_emulator()`](https://mrc-ide.github.io/rminte/reference/run_malaria_emulator.md) -
  Direct interface to the neural network emulator
- [`create_scenarios()`](https://mrc-ide.github.io/rminte/reference/create_scenarios.md) -
  Helper to create scenario data frames
- [`load_emulator_models()`](https://mrc-ide.github.io/rminte/reference/load_emulator_models.md) -
  Pre-load models for faster predictions
- [`generate_scenario_predictions()`](https://mrc-ide.github.io/rminte/reference/generate_scenario_predictions.md) -
  Lower-level prediction with pre-loaded models

### Plotting

- [`plot_prevalence()`](https://mrc-ide.github.io/rminte/reference/plot_prevalence.md)
  /
  [`plot_cases()`](https://mrc-ide.github.io/rminte/reference/plot_cases.md) -
  Native ggplot2 plotting
- [`create_scenario_plots_mpl()`](https://mrc-ide.github.io/rminte/reference/create_scenario_plots_mpl.md) -
  Matplotlib-based plotting via Python

### Utilities

- [`calculate_overall_dn0()`](https://mrc-ide.github.io/rminte/reference/calculate_overall_dn0.md) -
  Calculate net effectiveness from resistance levels
- [`preload_all_models()`](https://mrc-ide.github.io/rminte/reference/preload_all_models.md)
  /
  [`clear_cache()`](https://mrc-ide.github.io/rminte/reference/clear_cache.md) -
  Model cache management
- [`minte_available()`](https://mrc-ide.github.io/rminte/reference/minte_available.md)
  /
  [`configure_minte()`](https://mrc-ide.github.io/rminte/reference/configure_minte.md)
  /
  [`install_minte()`](https://mrc-ide.github.io/rminte/reference/install_minte.md) -
  Setup helpers

### Documentation

- README with rendered examples
- Two vignettes: rminte tutorial and MINTverse ecosystem overview
- pkgdown site at <https://mrc-ide.github.io/rminte/>
