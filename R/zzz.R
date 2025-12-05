# Delay-loaded Python module references
# These are populated in .onLoad() with delay_load = TRUE
# Declared as global variables in rminte-package.R to avoid R CMD check notes
minte <- NULL
np <- NULL
pd <- NULL

.onLoad <- function(libname, pkgname) {
  # Declare Python requirements using py_require() - the modern recommended approach
 # This declares dependencies that will be automatically provisioned
 # when Python is initialized (via ephemeral virtual environment if needed)
  reticulate::py_require("minte")
  
  # Use delay_load = TRUE to:
 # 1. Allow package to load even if Python/minte not installed (CRAN testing)
 # 2. Allow users to configure Python environment before first use
 # 3. Defer Python initialization until actually needed
  minte <<- reticulate::import("minte", delay_load = TRUE)
  np <<- reticulate::import("numpy", delay_load = TRUE)
  pd <<- reticulate::import("pandas", delay_load = TRUE)
}

#' Check if minte Python module is available
#'
#' @description
#' Checks if the minte Python package is available and can be loaded.
#' This will trigger Python initialization if not already done.
#'
#' @return Logical indicating if minte is available
#' @export
minte_available <- function() {
  tryCatch({
    # Accessing the module will trigger loading if delay_load was used
    !is.null(minte) && reticulate::py_module_available("minte")
  }, error = function(e) {
    FALSE
  })
}

#' Configure Python environment for minte
#'
#' @description
#' Allows users to specify additional Python requirements or constraints

#' before Python is initialized. Must be called before any minte functions.
#'
#' @param python_version Optional Python version constraint (e.g., ">=3.9").
#' @param gpu Logical. If TRUE, request GPU-enabled torch. Default FALSE.
#' @param ... Additional arguments passed to `reticulate::py_require()`.
#'
#' @return Invisible NULL
#'
#' @examples
#' \dontrun
#' # Request specific Python version
#' configure_minte(python_version = ">=3.10")
#'
#' # Then use minte as normal
#' results <- run_minter_scenarios(...)
#' }
#'
#' @export
configure_minte <- function(python_version = NULL, gpu = FALSE, ...) {
  if (!is.null(python_version)) {
    reticulate::py_require(python_version = python_version)
  }
  
  if (gpu) {
    # Request CUDA-enabled torch if GPU is requested
    reticulate::py_require("torch", action = "remove")
    reticulate::py_require("torch[cuda]")
  }
  
  # Pass through any additional requirements
  dots <- list(...)
  if (length(dots) > 0) {
    do.call(reticulate::py_require, dots)
  }
  
  invisible(NULL)
}

#' Install minte Python package
#'
#' @description
#' Installs the minte Python package. This is typically not needed if using
#' the default reticulate ephemeral environment, as `py_require("minte")`
#' will handle installation automatically.
#'
#' For users who prefer to manually manage their Python environment, this
#' function provides a convenient way to install minte.
#'
#' @param envname Name of the virtual environment. Default is "r-minte".
#' @param method Installation method. Default is "auto".
#' @param ... Additional arguments passed to `reticulate::py_install()`.
#'
#' @return Invisible NULL
#'
#' @examples
#' \dontrun{
#' # Install into a dedicated environment
#' install_minte(envname = "r-minte")
#'
#' # Then activate it before using rminte
#' reticulate::use_virtualenv("r-minte")
#' library(rminte)
#' }
#'
#' @export
install_minte <- function(envname = "r-minte", method = "auto", ...) {
  reticulate::py_install("minte", envname = envname, method = method, ...)
  invisible(NULL)
}
