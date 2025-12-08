# Batch Predict Scenarios

Run predictions in batches for large numbers of scenarios.

## Usage

``` r
batch_predict_scenarios(
  scenarios,
  predictor = "prevalence",
  batch_size = 1000L
)
```

## Arguments

- scenarios:

  A data frame of scenarios.

- predictor:

  Character. Which prediction to generate.

- batch_size:

  Integer. Number of scenarios per batch.

## Value

A data frame with predictions
