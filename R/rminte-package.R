#' @keywords internal
"_PACKAGE"

#' rminte: R Interface to Python's MINTe Package
#'
#' @description
#' An R interface to the Python 'minte' package, providing neural network-based
#' malaria scenario predictions for evaluating intervention strategies including
#' ITNs (Insecticide-Treated Nets), IRS (Indoor Residual Spraying), and LSM
#' (Larval Source Management).
#'
#' @section Main Functions:
#' \itemize{
#'   \item \code{\link{run_minter_scenarios}}: Main entry point for running scenarios
#'   \item \code{\link{run_mintweb_controller}}: Simplified web interface controller
#'   \item \code{\link{run_malaria_emulator}}: Direct emulator interface
#'   \item \code{\link{create_scenario_plots}}: Create visualizations
#' }
#'
#' @section Utility Functions:
#' \itemize{
#'   \item \code{\link{calculate_overall_dn0}}: Calculate net effectiveness
#'   \item \code{\link{available_net_types}}: Get supported net types
#'   \item \code{\link{preload_all_models}}: Pre-load models into cache
#'   \item \code{\link{clear_cache}}: Clear model cache
#' }
#'
#' @section Setup:
#' \itemize{
#'   \item \code{\link{minte_available}}: Check if minte is available
#'   \item \code{\link{minte_init}}: Initialize the Python module
#'   \item \code{\link{install_minte}}: Install minte Python package
#' }
#'
#' @docType package
#' @name rminte-package
#' @aliases rminte
#'
#' @importFrom reticulate import py_available py_install py_to_r r_to_py
NULL

# Global variable declarations to avoid R CMD check notes
# Package-level Python module references (set in .onLoad with delay_load)
# and ggplot2 .data pronoun
utils::globalVariables(c(
 "minte", "np", "pd",
 ".data", "timestep", "prevalence", "cases", "scenario_tag"
))
