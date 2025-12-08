# Load Emulator Models

Load the neural network models into memory. Returns an EmulatorModels
object that can be passed to
[`generate_scenario_predictions()`](https://mrc-ide.github.io/rminte/reference/generate_scenario_predictions.md)
for lower-level control, or models are cached automatically for use by
[`run_malaria_emulator()`](https://mrc-ide.github.io/rminte/reference/run_malaria_emulator.md).

## Usage

``` r
load_emulator_models(
  predictor = "prevalence",
  device = NULL,
  verbose = TRUE,
  force_reload = FALSE
)
```

## Arguments

- predictor:

  Character. Which models to load: "prevalence" or "cases".

- device:

  Character. Device to load models on ("cpu" or "cuda"). If NULL,
  auto-detected.

- verbose:

  Logical. Print loading messages. Default TRUE.

- force_reload:

  Logical. Force reload even if cached. Default FALSE.

## Value

An EmulatorModels object containing loaded models and configuration.
This can be passed to
[`generate_scenario_predictions()`](https://mrc-ide.github.io/rminte/reference/generate_scenario_predictions.md).

## See also

[`generate_scenario_predictions()`](https://mrc-ide.github.io/rminte/reference/generate_scenario_predictions.md),
[`run_malaria_emulator()`](https://mrc-ide.github.io/rminte/reference/run_malaria_emulator.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Load prevalence models
models <- load_emulator_models(predictor = "prevalence")

# Use with generate_scenario_predictions
scenarios <- create_scenarios(...)
predictions <- generate_scenario_predictions(scenarios, models)
} # }
```
