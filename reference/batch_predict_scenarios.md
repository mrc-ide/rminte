# Batch Predict Scenarios

Run batch predictions with the LSTM model. This is a low-level function
for advanced use cases where you need fine-grained control over
batching.

For most use cases, prefer
[`run_malaria_emulator()`](https://mrc-ide.github.io/rminte/reference/run_malaria_emulator.md)
which handles model loading and batching automatically.

## Usage

``` r
batch_predict_scenarios(
  model,
  X,
  device,
  predictor,
  batch_size = 32L,
  use_amp = FALSE
)
```

## Arguments

- model:

  A loaded PyTorch LSTM model (nn.Module).

- X:

  A numpy array of input features with shape `[B, T, F]` (batch,
  timesteps, features).

- device:

  A torch device object.

- predictor:

  Character. Type of predictor ("prevalence" or "cases").

- batch_size:

  Integer. Batch size for inference. Default 32.

- use_amp:

  Logical. Use automatic mixed precision. Default FALSE.

## Value

A numpy array of predictions with shape `[B, T]`.

## See also

[`run_malaria_emulator()`](https://mrc-ide.github.io/rminte/reference/run_malaria_emulator.md),
[`predict_full_sequence()`](https://mrc-ide.github.io/rminte/reference/predict_full_sequence.md)
