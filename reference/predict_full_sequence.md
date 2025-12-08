# Predict Full Sequence

Generate full sequence predictions for a single scenario using a loaded
model. This is a very low-level function for advanced use cases.

For most use cases, prefer
[`run_malaria_emulator()`](https://mrc-ide.github.io/rminte/reference/run_malaria_emulator.md)
which handles model loading and batching automatically.

## Usage

``` r
predict_full_sequence(model, full_ts, device, predictor, use_amp = FALSE)
```

## Arguments

- model:

  A loaded PyTorch model (nn.Module).

- full_ts:

  A numpy array of input features with shape `[T, F]`.

- device:

  A torch device object.

- predictor:

  Character. Type of predictor ("prevalence" or "cases").

- use_amp:

  Logical. Use automatic mixed precision. Default FALSE.

## Value

A numpy array of predictions with shape `[T]`.

## See also

[`run_malaria_emulator()`](https://mrc-ide.github.io/rminte/reference/run_malaria_emulator.md),
[`batch_predict_scenarios()`](https://mrc-ide.github.io/rminte/reference/batch_predict_scenarios.md)
