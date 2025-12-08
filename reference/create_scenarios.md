# Create Scenarios DataFrame

Helper function to create a scenarios data frame for use with
[`run_malaria_emulator()`](https://mrc-ide.github.io/rminte/reference/run_malaria_emulator.md).

## Usage

``` r
create_scenarios(
  eir,
  dn0_use,
  dn0_future,
  Q0,
  phi_bednets,
  seasonal,
  routine,
  itn_use,
  irs_use,
  itn_future,
  irs_future,
  lsm
)
```

## Arguments

- eir:

  Numeric vector. Entomological Inoculation Rate.

- dn0_use:

  Numeric vector. Current net effectiveness.

- dn0_future:

  Numeric vector. Future net effectiveness.

- Q0:

  Numeric vector. Indoor biting proportion.

- phi_bednets:

  Numeric vector. Bednet usage proportion.

- seasonal:

  Numeric vector. Seasonality indicator.

- routine:

  Numeric vector. Routine treatment coverage.

- itn_use:

  Numeric vector. Current ITN coverage.

- irs_use:

  Numeric vector. Current IRS coverage.

- itn_future:

  Numeric vector. Future ITN coverage.

- irs_future:

  Numeric vector. Future IRS coverage.

- lsm:

  Numeric vector. LSM coverage.

## Value

A data frame suitable for
[`run_malaria_emulator()`](https://mrc-ide.github.io/rminte/reference/run_malaria_emulator.md)
