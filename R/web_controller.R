#' Run MINTweb Controller
#'
#' @description
#' Simplified controller for web application integration. This provides a
#' streamlined interface suitable for web APIs.
#'
#' @param res_use Numeric vector. Current resistance level (0-1).
#' @param py_only Numeric vector. Pyrethroid-only net coverage (0-1).
#' @param py_pbo Numeric vector. PBO net coverage (0-1).
#' @param py_pyrrole Numeric vector. Pyrrole net coverage (0-1).
#' @param py_ppf Numeric vector. PPF net coverage (0-1).
#' @param prev Numeric vector. Current under-5 prevalence (0-1).
#' @param Q0 Numeric vector. Indoor biting proportion (0-1).
#' @param phi Numeric vector. Bednet usage proportion (0-1).
#' @param season Numeric vector. Seasonality indicator.
#' @param routine Numeric vector. Routine treatment coverage (0-1).
#' @param irs Numeric vector. Current IRS coverage (0-1).
#' @param irs_future Numeric vector. Future IRS coverage (0-1).
#' @param lsm Numeric vector. LSM coverage (0-1).
#' @param clean_output Logical. If TRUE, return cleaned output. Default TRUE.
#' @param tabulate Logical. If TRUE, return tabulated results. Default TRUE.
#'
#' @return A list with web-friendly results
#'
#' @examples
#' \dontrun{
#' results <- run_mintweb_controller(
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
#' }
#'
#' @export
run_mintweb_controller <- function(res_use,
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
                                    tabulate = TRUE) {
  py_results <- minte$run_mintweb_controller(
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
    clean_output = clean_output,
    tabulate = tabulate
  )
  
  # Convert to R
  results <- list(
    prevalence = reticulate::py_to_r(py_results$prevalence),
    cases = reticulate::py_to_r(py_results$cases),
    scenario_meta = if (!is.null(py_results$scenario_meta)) {
      reticulate::py_to_r(py_results$scenario_meta)
    } else {
      NULL
    }
  )
  
  class(results) <- c("mintweb_results", "list")
  results
}

#' Format Results for JSON
#'
#' @description
#' Format MINTe results for JSON serialization, suitable for web APIs.
#'
#' @param results A minter_results or mintweb_results object.
#'
#' @return A list formatted for JSON serialization
#'
#' @export
format_for_json <- function(results) {
  # Convert R results to JSON-friendly format
  if (inherits(results, "minter_results") || inherits(results, "mintweb_results")) {
    # Create a simple list structure suitable for JSON serialization
    json_result <- list(
      prevalence = as.list(as.data.frame(results$prevalence)),
      cases = as.list(as.data.frame(results$cases))
    )
    
    if (!is.null(results$scenario_meta)) {
      json_result$scenario_meta <- as.list(as.data.frame(results$scenario_meta))
    }
    
    if (!is.null(results$eir_valid)) {
      json_result$eir_valid <- results$eir_valid
    }
    
    return(json_result)
  }
  
  stop("Input must be a minter_results or mintweb_results object")
}

#' Print method for mintweb_results
#' @param x A mintweb_results object
#' @param ... Additional arguments (ignored)
#' @keywords internal
#' @export
print.mintweb_results <- function(x, ...) {
  cat("MINTweb Results\n")
  cat("===============\n")
  cat("Prevalence predictions:", nrow(x$prevalence), "rows\n")
  cat("Cases predictions:", nrow(x$cases), "rows\n")
  if (!is.null(x$scenario_meta)) {
    cat("Scenarios:", nrow(x$scenario_meta), "\n")
  }
  invisible(x)
}
