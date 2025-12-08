# Generate Scenario Predictions

Generate predictions for a set of scenarios using pre-loaded models.
This is a lower-level function that requires models to be loaded first
using
[`load_emulator_models()`](https://mrc-ide.github.io/rminte/reference/load_emulator_models.md).

For most use cases, prefer
[`run_malaria_emulator()`](https://mrc-ide.github.io/rminte/reference/run_malaria_emulator.md)
which handles model loading automatically.

## Usage

``` r
generate_scenario_predictions(
  scenarios,
  models,
  model_types = c("LSTM"),
  time_steps = 2190L
)
```

## Arguments

- scenarios:

  A data frame of scenarios created by
  [`create_scenarios()`](https://mrc-ide.github.io/rminte/reference/create_scenarios.md).

- models:

  An EmulatorModels object returned by
  [`load_emulator_models()`](https://mrc-ide.github.io/rminte/reference/load_emulator_models.md).

- model_types:

  Character vector. Model types to use. Default `c("LSTM")`.

- time_steps:

  Integer. Number of time steps in days. Default 2190.

## Value

A list of prediction dictionaries.

## See also

[`load_emulator_models()`](https://mrc-ide.github.io/rminte/reference/load_emulator_models.md),
[`run_malaria_emulator()`](https://mrc-ide.github.io/rminte/reference/run_malaria_emulator.md)

## Examples

``` r
if (FALSE) { # \dontrun{
models <- load_emulator_models(predictor = "prevalence")
scenarios <- create_scenarios(
  eir = 50, dn0_use = 0.5, dn0_future = 0.6, Q0 = 0.92,
  phi_bednets = 0.85, seasonal = 1, routine = 0.1,
  itn_use = 0.6, irs_use = 0.0, itn_future = 0.7,
  irs_future = 0.3, lsm = 0.0
)
predictions <- generate_scenario_predictions(scenarios, models)
} # }
```
