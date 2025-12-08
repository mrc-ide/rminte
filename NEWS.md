# rminte 0.1.0

* Initial release of rminte, an R interface to Python's MINTe package.

## Features

* `run_minter_scenarios()` - High-level function to run malaria intervention scenarios
* `run_malaria_emulator()` - Direct interface to the neural network emulator
* `create_scenarios()` - Helper to create scenario data frames
* `load_emulator_models()` - Pre-load models for faster predictions
* `generate_scenario_predictions()` - Lower-level prediction with pre-loaded models

## Plotting

* `plot_prevalence()` / `plot_cases()` - Native ggplot2 plotting
* `create_scenario_plots_mpl()` - Matplotlib-based plotting via Python

## Utilities

* `calculate_overall_dn0()` - Calculate net effectiveness from resistance levels
* `preload_all_models()` / `clear_cache()` - Model cache management
* `minte_available()` / `configure_minte()` / `install_minte()` - Setup helpers

## Documentation

* README with rendered examples
* Two vignettes: rminte tutorial and MINTverse ecosystem overview
* pkgdown site at https://mrc-ide.github.io/rminte/
