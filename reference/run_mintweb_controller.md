# Run MINTweb Controller

Simplified controller for web application integration. This provides a
streamlined interface suitable for web APIs.

## Usage

``` r
run_mintweb_controller(
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
  clean_output = TRUE,
  tabulate = TRUE
)
```

## Arguments

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

  Numeric vector. Seasonality indicator.

- routine:

  Numeric vector. Routine treatment coverage (0-1).

- irs:

  Numeric vector. Current IRS coverage (0-1).

- irs_future:

  Numeric vector. Future IRS coverage (0-1).

- lsm:

  Numeric vector. LSM coverage (0-1).

- clean_output:

  Logical. If TRUE, return cleaned output. Default TRUE.

- tabulate:

  Logical. If TRUE, return tabulated results. Default TRUE.

## Value

A list with web-friendly results

## Examples

``` r
if (FALSE) { # \dontrun{
results <- run_mintweb_controller(
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
} # }
```
