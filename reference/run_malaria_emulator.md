# Run Malaria Emulator Directly

Direct interface to the neural network emulator for scenario
predictions. This provides lower-level access compared to
[`run_minter_scenarios()`](https://mrc-ide.github.io/rminte/reference/run_minter_scenarios.md).

## Usage

``` r
run_malaria_emulator(scenarios, predictor = "prevalence", benchmark = FALSE)
```

## Arguments

- scenarios:

  A data frame of scenarios created by
  [`create_scenarios()`](https://mrc-ide.github.io/rminte/reference/create_scenarios.md).

- predictor:

  Character. Which prediction to run: "prevalence" or "cases".

- benchmark:

  Logical. If TRUE, print timing benchmarks. Default FALSE.

## Value

A data frame with predictions

## Examples

``` r
if (FALSE) { # \dontrun{
scenarios <- create_scenarios(
  eir = c(50, 100, 150),
  dn0_use = c(0.5, 0.4, 0.3),
  dn0_future = c(0.6, 0.5, 0.4),
  Q0 = c(0.92, 0.92, 0.92),
  phi_bednets = c(0.85, 0.85, 0.85),
  seasonal = c(1, 1, 1),
  routine = c(0.1, 0.1, 0.1),
  itn_use = c(0.6, 0.5, 0.4),
  irs_use = c(0.0, 0.0, 0.0),
  itn_future = c(0.7, 0.6, 0.5),
  irs_future = c(0.3, 0.3, 0.3),
  lsm = c(0.0, 0.0, 0.0)
)
results <- run_malaria_emulator(scenarios, predictor = "prevalence")
} # }
```
