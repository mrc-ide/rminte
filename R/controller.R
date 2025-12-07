#' Run MINTer Scenarios
#'
#' @description
#' Main entry point for running malaria intervention scenarios using the MINTe
#' neural network emulator. This function takes intervention parameters and
#' returns predicted prevalence and clinical cases over time.
#'
#' @param scenario_tag Character vector. Tags/names for each scenario.
#' @param res_use Numeric vector. Current resistance level (0-1).
#' @param py_only Numeric vector. Pyrethroid-only net coverage (0-1).
#' @param py_pbo Numeric vector. PBO net coverage (0-1).
#' @param py_pyrrole Numeric vector. Pyrrole net coverage (0-1).
#' @param py_ppf Numeric vector. PPF net coverage (0-1).
#' @param prev Numeric vector. Current under-5 prevalence (0-1).
#' @param Q0 Numeric vector. Indoor biting proportion (0-1).
#' @param phi Numeric vector. Bednet usage proportion (0-1).
#' @param season Numeric vector. Seasonality indicator (0 = perennial, 1 = seasonal).
#' @param routine Numeric vector. Routine treatment coverage (0-1).
#' @param irs Numeric vector. Current IRS coverage (0-1).
#' @param irs_future Numeric vector. Future IRS coverage (0-1).
#' @param lsm Numeric vector. LSM (Larval Source Management) coverage (0-1).
#' @param itn_future Numeric vector. Future ITN coverage (0-1). Optional.
#' @param net_type_future Character vector. Future net type. One of "py_only",
#'   "py_pbo", "py_pyrrole", "py_ppf". Optional.
#' @param predictor Character vector. Which predictions to run: "prevalence",
#'   "cases", or both. Default is c("prevalence", "cases").
#' @param benchmark Logical. If TRUE, print timing benchmarks. Default FALSE.
#'
#' @return A list of class "minter_results" containing:
#' \describe{
#'   \item{prevalence}{Data frame of prevalence predictions over time}
#'   \item{cases}{Data frame of clinical case predictions over time}
#'   \item{scenario_meta}{Data frame with per-scenario metadata}
#'   \item{eir_valid}{Logical indicating if EIR is within calibrated range}
#'   \item{benchmarks}{List of timing information (if benchmark=TRUE)}
#' }
#'
#' @examples
#' \dontrun{
#' # Single scenario
#' results <- run_minter_scenarios(
#'   scenario_tag = "example",
#'   res_use = 0.3,
#'   py_only = 0.4,
#'   py_pbo = 0.3,
#'   py_pyrrole = 0.2,
#'   py_ppf = 0.1,
#'   prev = 0.25,
#'   Q0 = 0.92,
#'   phi = 0.85,
#'   season = 1,
#'   routine = 0.1,
#'   irs = 0.0,
#'   irs_future = 0.3,
#'   lsm = 0.0
#' )
#'
#' # Access results
#' head(results$prevalence)
#' head(results$cases)
#' }
#'
#' @export
run_minter_scenarios <- function(scenario_tag = NULL,
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
                                  benchmark = FALSE) {
  
  # Access the delay-loaded minte module (triggers Python init if needed)
  
  # Convert R vectors to Python lists
  args <- list(
    res_use = as.list(res_use),
    py_only = as.list(py_only),
    py_pbo = as.list(py_pbo),
    py_pyrrole = as.list(py_pyrrole),
    py_ppf = as.list(py_ppf),
    prev = as.list(prev),
    Q0 = as.list(Q0),
    phi = as.list(phi),
    season = as.list(as.integer(season)),
    routine = as.list(routine),
    irs = as.list(irs),
    irs_future = as.list(irs_future),
    lsm = as.list(lsm),
    predictor = as.list(predictor),
    benchmark = benchmark
  )
  
  if (!is.null(scenario_tag)) {
    args$scenario_tag <- as.list(scenario_tag)
  }
  
  if (!is.null(itn_future)) {
    args$itn_future <- as.list(itn_future)
  }
  
  if (!is.null(net_type_future)) {
    args$net_type_future <- as.list(net_type_future)
  }
  
  # Call Python function
  py_results <- do.call(minte$run_minter_scenarios, args)
  
  # Convert results to R
  results <- list(
    prevalence = reticulate::py_to_r(py_results$prevalence),
    cases = reticulate::py_to_r(py_results$cases),
    scenario_meta = reticulate::py_to_r(py_results$scenario_meta),
    eir_valid = py_results$eir_valid,
    benchmarks = if (!is.null(py_results$benchmarks)) {
      reticulate::py_to_r(py_results$benchmarks)
    } else {
      NULL
    }
  )
  
  class(results) <- c("minter_results", "list")
  results
}

#' Print method for minter_results
#' @param x A minter_results object
#' @param ... Additional arguments (ignored)
#' @keywords internal
#' @export
print.minter_results <- function(x, ...) {
  cat("MINTer Results\n")
  cat("==============\n")
  cat("Prevalence predictions:", nrow(x$prevalence), "rows\n")
  cat("Cases predictions:", nrow(x$cases), "rows\n")
  cat("Scenarios:", nrow(x$scenario_meta), "\n")
  cat("EIR valid:", x$eir_valid, "\n")
  if (!is.null(x$benchmarks)) {
    cat("\nBenchmarks:\n")
    for (name in names(x$benchmarks)) {
      cat("  ", name, ":", x$benchmarks[[name]], "\n")
    }
  }
  invisible(x)
}
