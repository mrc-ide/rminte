#' Run Malaria Emulator Directly
#'
#' @description
#' Direct interface to the neural network emulator for scenario predictions.
#' This provides lower-level access compared to `run_minter_scenarios()`.
#'
#' @param scenarios A data frame of scenarios created by `create_scenarios()`.
#' @param predictor Character. Which prediction to run: "prevalence" or "cases".
#' @param benchmark Logical. If TRUE, print timing benchmarks. Default FALSE.
#'
#' @return A data frame with predictions
#'
#' @examples
#' \dontrun{
#' scenarios <- create_scenarios(
#'   eir = c(50, 100, 150),
#'   dn0_use = c(0.5, 0.4, 0.3),
#'   dn0_future = c(0.6, 0.5, 0.4),
#'   Q0 = c(0.92, 0.92, 0.92),
#'   phi_bednets = c(0.85, 0.85, 0.85),
#'   seasonal = c(1, 1, 1),
#'   routine = c(0.1, 0.1, 0.1),
#'   itn_use = c(0.6, 0.5, 0.4),
#'   irs_use = c(0.0, 0.0, 0.0),
#'   itn_future = c(0.7, 0.6, 0.5),
#'   irs_future = c(0.3, 0.3, 0.3),
#'   lsm = c(0.0, 0.0, 0.0)
#' )
#' results <- run_malaria_emulator(scenarios, predictor = "prevalence")
#' }
#'
#' @export
run_malaria_emulator <- function(scenarios, predictor = "prevalence", benchmark = FALSE) {
  # Convert R data frame to pandas DataFrame
  py_scenarios <- reticulate::r_to_py(scenarios)
  
  # Call Python function
  py_results <- minte$run_malaria_emulator(
    scenarios = py_scenarios,
    predictor = predictor,
    benchmark = benchmark
  )
  
  # Convert back to R
  reticulate::py_to_r(py_results)
}

#' Create Scenarios DataFrame
#'
#' @description
#' Helper function to create a scenarios data frame for use with
#' `run_malaria_emulator()`.
#'
#' @param eir Numeric vector. Entomological Inoculation Rate.
#' @param dn0_use Numeric vector. Current net effectiveness.
#' @param dn0_future Numeric vector. Future net effectiveness.
#' @param Q0 Numeric vector. Indoor biting proportion.
#' @param phi_bednets Numeric vector. Bednet usage proportion.
#' @param seasonal Numeric vector. Seasonality indicator.
#' @param routine Numeric vector. Routine treatment coverage.
#' @param itn_use Numeric vector. Current ITN coverage.
#' @param irs_use Numeric vector. Current IRS coverage.
#' @param itn_future Numeric vector. Future ITN coverage.
#' @param irs_future Numeric vector. Future IRS coverage.
#' @param lsm Numeric vector. LSM coverage.
#'
#' @return A data frame suitable for `run_malaria_emulator()`
#'
#' @export
create_scenarios <- function(eir,
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
                              lsm) {
  
  py_result <- minte$create_scenarios(
    eir = as.list(eir),
    dn0_use = as.list(dn0_use),
    dn0_future = as.list(dn0_future),
    Q0 = as.list(Q0),
    phi_bednets = as.list(phi_bednets),
    seasonal = as.list(as.integer(seasonal)),
    routine = as.list(routine),
    itn_use = as.list(itn_use),
    irs_use = as.list(irs_use),
    itn_future = as.list(itn_future),
    irs_future = as.list(irs_future),
    lsm = as.list(lsm)
  )
  
  reticulate::py_to_r(py_result)
}

#' Load Emulator Models
#'
#' @description
#' Load the neural network models into memory. Returns an EmulatorModels object
#' that can be passed to `generate_scenario_predictions()` for lower-level control,
#' or models are cached automatically for use by `run_malaria_emulator()`.
#'
#' @param predictor Character. Which models to load: "prevalence" or "cases".
#' @param device Character. Device to load models on ("cpu" or "cuda"). 
#'   If NULL, auto-detected.
#' @param verbose Logical. Print loading messages. Default TRUE.
#' @param force_reload Logical. Force reload even if cached. Default FALSE.
#'
#' @return An EmulatorModels object containing loaded models and configuration.
#'   This can be passed to `generate_scenario_predictions()`.
#'
#' @seealso [generate_scenario_predictions()], [run_malaria_emulator()]
#'
#' @examples
#' \dontrun{
#' # Load prevalence models
#' models <- load_emulator_models(predictor = "prevalence")
#' 
#' # Use with generate_scenario_predictions
#' scenarios <- create_scenarios(...)
#' predictions <- generate_scenario_predictions(scenarios, models)
#' }
#'
#' @export
load_emulator_models <- function(predictor = "prevalence", device = NULL,
                                  verbose = TRUE, force_reload = FALSE) {
  minte$load_emulator_models(
    predictor = predictor,
    device = device,
    verbose = verbose,
    force_reload = force_reload
  )
}

#' Generate Scenario Predictions
#'
#' @description
#' Generate predictions for a set of scenarios using pre-loaded models.
#' This is a lower-level function that requires models to be loaded first
#' using `load_emulator_models()`.
#'
#' For most use cases, prefer `run_malaria_emulator()` which handles model
#' loading automatically.
#'
#' @param scenarios A data frame of scenarios created by `create_scenarios()`.
#' @param models An EmulatorModels object returned by `load_emulator_models()`.
#' @param model_types Character vector. Model types to use. Default `c("LSTM")`.
#' @param time_steps Integer. Number of time steps in days. Default 2190.
#'
#' @return A list of prediction dictionaries.
#'
#' @seealso [load_emulator_models()], [run_malaria_emulator()]
#'
#' @examples
#' \dontrun{
#' models <- load_emulator_models(predictor = "prevalence")
#' scenarios <- create_scenarios(
#'   eir = 50, dn0_use = 0.5, dn0_future = 0.6, Q0 = 0.92,
#'   phi_bednets = 0.85, seasonal = 1, routine = 0.1,
#'   itn_use = 0.6, irs_use = 0.0, itn_future = 0.7,
#'   irs_future = 0.3, lsm = 0.0
#' )
#' predictions <- generate_scenario_predictions(scenarios, models)
#' }
#'
#' @export
generate_scenario_predictions <- function(scenarios, models, 
                                           model_types = c("LSTM"),
                                           time_steps = 2190L) {
  py_scenarios <- reticulate::r_to_py(scenarios)
  py_result <- minte$generate_scenario_predictions(
    scenarios = py_scenarios,
    models = models,
    model_types = as.list(model_types),
    time_steps = as.integer(time_steps)
  )
  
  reticulate::py_to_r(py_result)
}

#' Predict Full Sequence
#'
#' @description
#' Generate full sequence predictions for a single scenario using a loaded model.
#' This is a very low-level function for advanced use cases.
#'
#' For most use cases, prefer `run_malaria_emulator()` which handles model
#' loading and batching automatically.
#'
#' @param model A loaded PyTorch model (nn.Module).
#' @param full_ts A numpy array of input features with shape `[T, F]`.
#' @param device A torch device object.
#' @param predictor Character. Type of predictor ("prevalence" or "cases").
#' @param use_amp Logical. Use automatic mixed precision. Default FALSE.
#'
#' @return A numpy array of predictions with shape `[T]`.
#'
#' @seealso [run_malaria_emulator()], [batch_predict_scenarios()]
#'
#' @export
predict_full_sequence <- function(model, full_ts, device, predictor, use_amp = FALSE) {
  py_result <- minte$predict_full_sequence(
    model = model,
    full_ts = full_ts,
    device = device,
    predictor = predictor,
    use_amp = use_amp
  )
  
  reticulate::py_to_r(py_result)
}

#' Batch Predict Scenarios
#'
#' @description
#' Run batch predictions with the LSTM model. This is a low-level function
#' for advanced use cases where you need fine-grained control over batching.
#'
#' For most use cases, prefer `run_malaria_emulator()` which handles model
#' loading and batching automatically.
#'
#' @param model A loaded PyTorch LSTM model (nn.Module).
#' @param X A numpy array of input features with shape `[B, T, F]` 
#'   (batch, timesteps, features).
#' @param device A torch device object.
#' @param predictor Character. Type of predictor ("prevalence" or "cases").
#' @param batch_size Integer. Batch size for inference. Default 32.
#' @param use_amp Logical. Use automatic mixed precision. Default FALSE.
#'
#' @return A numpy array of predictions with shape `[B, T]`.
#'
#' @seealso [run_malaria_emulator()], [predict_full_sequence()]
#'
#' @export
batch_predict_scenarios <- function(model, X, device, predictor, 
                                     batch_size = 32L, use_amp = FALSE) {
  py_result <- minte$batch_predict_scenarios(
    model = model,
    X = X,
    device = device,
    predictor = predictor,
    batch_size = as.integer(batch_size),
    use_amp = use_amp
  )
  
  reticulate::py_to_r(py_result)
}
