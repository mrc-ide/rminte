# Calculate Overall dn0 (Net Effectiveness)

Calculate the overall net effectiveness (dn0) from resistance levels and
net coverage parameters. Returns both the weighted-average dn0 and the
total ITN usage proportion.

## Usage

``` r
calculate_overall_dn0(
  resistance_level,
  py_only = 0,
  py_pbo = 0,
  py_pyrrole = 0,
  py_ppf = 0
)
```

## Arguments

- resistance_level:

  Numeric. Current resistance level (0-1).

- py_only:

  Numeric. Pyrethroid-only net usage proportion (0-1).

- py_pbo:

  Numeric. PBO net usage proportion (0-1).

- py_pyrrole:

  Numeric. Pyrrole net usage proportion (0-1).

- py_ppf:

  Numeric. PPF net usage proportion (0-1).

## Value

A list with two elements:

- dn0:

  The weighted-average dn0 at the requested resistance level

- itn_use:

  The total usage proportion of pyrethroid-based ITNs

## Examples

``` r
if (FALSE) { # \dontrun{
result <- calculate_overall_dn0(
  resistance_level = 0.3,
  py_only = 0.4,
  py_pbo = 0.3,
  py_pyrrole = 0.2,
  py_ppf = 0.1
)
cat("dn0:", result$dn0, "itn_use:", result$itn_use, "\n")
} # }
```
