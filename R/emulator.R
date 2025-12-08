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
#' Pre-load the neural network models into memory for faster subsequent runs.
#'
#' @param predictor Character. Which models to load: "prevalence", "cases", or "both".
#'
#' @return Invisible NULL
#'
#' @export
load_emulator_models <- function(predictor = "both") {
  minte$load_emulator_models(predictor = predictor)
  invisible(NULL)
}

# Note: generate_scenario_predictions, predict_full_sequence, and batch_predict_scenarios
# are low-level internal functions in the Python API that require model objects as parameters.
# They are not exposed here as the R wrapper signatures would not match the Python API.
# Use run_malaria_emulator() or run_minter_scenarios() instead.
