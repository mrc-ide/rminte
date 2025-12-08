# Convert Resistance to dn0

Convert resistance level to net effectiveness (dn0) for a specific net
type.

## Usage

``` r
resistance_to_dn0(resistance, net_type = "py_only")
```

## Arguments

- resistance:

  Numeric. Resistance level (0-1).

- net_type:

  Character. Type of net (e.g., "py_only", "py_pbo").

## Value

Numeric. The dn0 value.

## Examples

``` r
if (FALSE) { # \dontrun{
dn0 <- resistance_to_dn0(resistance = 0.3, net_type = "py_pbo")
} # }
```
