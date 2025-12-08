# Run MINTer Scenarios

Main entry point for running malaria intervention scenarios using the
MINTe neural network emulator. This function takes intervention
parameters and returns predicted prevalence and clinical cases over
time.

## Usage

``` r
run_minter_scenarios(
  scenario_tag = NULL,
  res_use,
  py_only,
  py_pbo,
  py_pyrrole,
  py_ppf,
  prev,
  Q0,
  phi,
  season,
  routine,
  irs,
  irs_future,
  lsm,
  itn_future = NULL,
  net_type_future = NULL,
  predictor = c("prevalence", "cases"),
  benchmark = FALSE
)
```

## Arguments

- scenario_tag:

  Character vector. Tags/names for each scenario.

- res_use:

  Numeric vector. Current resistance level (0-1).

- py_only:

  Numeric vector. Pyrethroid-only net coverage (0-1).

- py_pbo:

  Numeric vector. PBO net coverage (0-1).

- py_pyrrole:

  Numeric vector. Pyrrole net coverage (0-1).

- py_ppf:

  Numeric vector. PPF net coverage (0-1).

- prev:

  Numeric vector. Current under-5 prevalence (0-1).

- Q0:

  Numeric vector. Indoor biting proportion (0-1).

- phi:

  Numeric vector. Bednet usage proportion (0-1).

- season:

  Numeric vector. Seasonality indicator (0 = perennial, 1 = seasonal).

- routine:

  Numeric vector. Routine treatment coverage (0-1).

- irs:

  Numeric vector. Current IRS coverage (0-1).

- irs_future:

  Numeric vector. Future IRS coverage (0-1).

- lsm:

  Numeric vector. LSM (Larval Source Management) coverage (0-1).

- itn_future:

  Numeric vector. Future ITN coverage (0-1). Optional.

- net_type_future:

  Character vector. Future net type. One of "py_only", "py_pbo",
  "py_pyrrole", "py_ppf". Optional.

- predictor:

  Character vector. Which predictions to run: "prevalence", "cases", or
  both. Default is c("prevalence", "cases").

- benchmark:

  Logical. If TRUE, print timing benchmarks. Default FALSE.

## Value

A list of class "minter_results" containing:

- prevalence:

  Data frame of prevalence predictions over time

- cases:

  Data frame of clinical case predictions over time

- scenario_meta:

  Data frame with per-scenario metadata

- eir_valid:

  Logical indicating if EIR is within calibrated range

- benchmarks:

  List of timing information (if benchmark=TRUE)

## Examples

``` r
if (FALSE) { # \dontrun{
# Single scenario
results <- run_minter_scenarios(
  scenario_tag = "example",
  res_use = 0.3,
  py_only = 0.4,
  py_pbo = 0.3,
  py_pyrrole = 0.2,
  py_ppf = 0.1,
  prev = 0.25,
  Q0 = 0.92,
  phi = 0.85,
  season = 1,
  routine = 0.1,
  irs = 0.0,
  irs_future = 0.3,
  lsm = 0.0
)

# Access results
head(results$prevalence)
head(results$cases)
} # }
```
