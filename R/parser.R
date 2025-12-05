#' Calculate Overall dn0 (Net Effectiveness)
#'
#' @description
#' Calculate the overall net effectiveness (dn0) from resistance levels
#' and net coverage parameters. Returns both the weighted-average dn0
#' and the total ITN usage proportion.
#'
#' @param resistance_level Numeric. Current resistance level (0-1).
#' @param py_only Numeric. Pyrethroid-only net usage proportion (0-1).
#' @param py_pbo Numeric. PBO net usage proportion (0-1).
#' @param py_pyrrole Numeric. Pyrrole net usage proportion (0-1).
#' @param py_ppf Numeric. PPF net usage proportion (0-1).
#'
#' @return A list with two elements:
#'   \item{dn0}{The weighted-average dn0 at the requested resistance level}
#'   \item{itn_use}{The total usage proportion of pyrethroid-based ITNs}
#'
#' @examples
#' \dontrun{
#' result <- calculate_overall_dn0(
#'   resistance_level = 0.3,
#'   py_only = 0.4,
#'   py_pbo = 0.3,
#'   py_pyrrole = 0.2,
#'   py_ppf = 0.1
#' )
#' cat("dn0:", result$dn0, "itn_use:", result$itn_use, "\n")
#' }
#'
#' @export
calculate_overall_dn0 <- function(resistance_level, py_only = 0, py_pbo = 0, 
                                   py_pyrrole = 0, py_ppf = 0) {
  result <- minte$calculate_overall_dn0(
    resistance_level = resistance_level,
    py_only = py_only,
    py_pbo = py_pbo,
    py_pyrrole = py_pyrrole,
    py_ppf = py_ppf
  )
  
  list(
    dn0 = as.numeric(result$dn0),
    itn_use = as.numeric(result$itn_use)
  )
}

#' Get Available Net Types
#'
#' @description
#' Returns a character vector of available ITN (Insecticide-Treated Net) types.
#'
#' @return Character vector of net type names.
#'
#' @examples
#' \dontrun{
#' net_types <- available_net_types()
#' print(net_types)
#' }
#'
#' @export
available_net_types <- function() {
  py_result <- minte$available_net_types()
  as.character(reticulate::py_to_r(py_result))
}

#' Define Bednet Types
#'
#' @description
#' Get the definition/parameters for different bednet types.
#'
#' @return A list or data frame with bednet type definitions.
#'
#' @export
define_bednet_types <- function() {
  py_result <- minte$define_bednet_types()
  reticulate::py_to_r(py_result)
}

#' Convert Resistance to dn0
#'
#' @description
#' Convert resistance level to net effectiveness (dn0) for a specific net type.
#'
#' @param resistance Numeric. Resistance level (0-1).
#' @param net_type Character. Type of net (e.g., "py_only", "py_pbo").
#'
#' @return Numeric. The dn0 value.
#'
#' @examples
#' \dontrun{
#' dn0 <- resistance_to_dn0(resistance = 0.3, net_type = "py_pbo")
#' }
#'
#' @export
resistance_to_dn0 <- function(resistance, net_type = "py_only") {
  result <- minte$resistance_to_dn0(
    resistance = resistance,
    net_type = net_type
  )
  
  as.numeric(result)
}
