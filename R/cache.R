#' Preload All Models
#'
#' @description
#' Pre-load all neural network models into the cache for faster subsequent
#' predictions. This is useful when you want to minimize latency for the
#' first prediction call.
#'
#' @return Invisible NULL
#'
#' @examples
#' \dontrun{
#' # Pre-load models at startup
#' preload_all_models()
#'
#' # Now predictions will be faster
#' results <- run_minter_scenarios(...)
#' }
#'
#' @export
preload_all_models <- function() {
  minte$preload_all_models()
  message("All models preloaded successfully")
  invisible(NULL)
}

#' Get Cached Model
#'
#' @description
#' Retrieve a specific model from the cache.
#'
#' @param model_name Character. Name of the model to retrieve.
#'
#' @return The cached model object (Python object)
#'
#' @keywords internal
#' @export
get_cached_model <- function(model_name) {
  minte$get_cached_model(model_name)
}

#' Clear Model Cache
#'
#' @description
#' Clear all cached models from memory. This can be useful to free up
#' memory or to force models to be reloaded.
#'
#' @return Invisible NULL
#'
#' @examples
#' \dontrun{
#' # Clear the cache
#' clear_cache()
#'
#' # Models will be reloaded on next use
#' }
#'
#' @export
clear_cache <- function() {
  minte$clear_cache()
  message("Model cache cleared")
  invisible(NULL)
}
