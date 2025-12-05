#' Create Scenario Plots
#'
#' @description
#' Create visualizations from MINTe results. Generates plots of prevalence
#' and/or cases over time for each scenario.
#'
#' @param data A data frame of results (e.g., from `results$prevalence`).
#' @param output_dir Character. Directory to save plots. If NULL, plots are
#'   returned but not saved.
#' @param plot_type Character. Type of plot: "prevalence", "cases", or "both".
#' @param show_plot Logical. If TRUE, display plots interactively. Default FALSE.
#'
#' @return A list of plot objects (matplotlib figures converted to R).
#'
#' @examples
#' \dontrun{
#' results <- run_minter_scenarios(...)
#' plots <- create_scenario_plots(
#'   results$prevalence,
#'   output_dir = "plots/",
#'   plot_type = "prevalence"
#' )
#' }
#'
#' @export
create_scenario_plots <- function(data,
                                   output_dir = NULL,
                                   plot_type = "prevalence",
                                   show_plot = FALSE) {
  # Convert R data frame to pandas
  py_data <- reticulate::r_to_py(data)
  
  # Build arguments
  args <- list(
    data = py_data,
    plot_type = plot_type,
    show_plot = show_plot
  )
  
  if (!is.null(output_dir)) {
    args$output_dir <- output_dir
  }
  
  # Call Python function
  py_plots <- do.call(minte$create_scenario_plots, args)
  
  # Return the plot dictionary
  reticulate::py_to_r(py_plots)
}

#' Plot Emulator Results
#'
#' @description
#' Alternative plotting function for emulator results.
#'
#' @param results Results from `run_malaria_emulator()` or similar.
#' @param output_dir Character. Directory to save plots.
#' @param ... Additional arguments passed to the Python function.
#'
#' @return Plot objects
#'
#' @export
plot_emulator_results <- function(results, output_dir = NULL, ...) {
  py_results <- reticulate::r_to_py(results)
  
  args <- list(results = py_results, ...)
  if (!is.null(output_dir)) {
    args$output_dir <- output_dir
  }
  
  py_plots <- do.call(minte$plot_emulator_results, args)
  reticulate::py_to_r(py_plots)
}

#' Plot Prevalence Over Time (R native)
#'
#' @description
#' Create a ggplot2 visualization of prevalence over time. This is a native
#' R implementation that doesn't require Python plotting.
#'
#' @param results A minter_results object or data frame with prevalence data.
#' @param scenarios Character vector. Which scenarios to plot. If NULL, plot all.
#' @param title Character. Plot title.
#'
#' @return A ggplot2 object
#'
#' @examples
#' \dontrun{
#' results <- run_minter_scenarios(...)
#' p <- plot_prevalence(results)
#' print(p)
#' }
#'
#' @export
plot_prevalence <- function(results, scenarios = NULL, title = "Prevalence Over Time") {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package 'ggplot2' is required for this function. Please install it.")
  }
  
  # Extract prevalence data
  if (inherits(results, "minter_results") || inherits(results, "mintweb_results")) {
    data <- results$prevalence
  } else {
    data <- results
  }
  
  # Filter scenarios if specified
  if (!is.null(scenarios)) {
    data <- data[data$scenario_tag %in% scenarios, ]
  }
  
  # Create plot
  p <- ggplot2::ggplot(data, ggplot2::aes(x = .data$timestep, 
                                           y = .data$prevalence, 
                                           color = .data$scenario_tag)) +
    ggplot2::geom_line(linewidth = 1) +
    ggplot2::labs(
      title = title,
      x = "Timestep (14-day periods)",
      y = "Prevalence (under-5)",
      color = "Scenario"
    ) +
    ggplot2::theme_minimal() +
    ggplot2::theme(legend.position = "bottom")
  
  p
}

#' Plot Cases Over Time (R native)
#'
#' @description
#' Create a ggplot2 visualization of clinical cases over time.
#'
#' @param results A minter_results object or data frame with cases data.
#' @param scenarios Character vector. Which scenarios to plot. If NULL, plot all.
#' @param title Character. Plot title.
#'
#' @return A ggplot2 object
#'
#' @export
plot_cases <- function(results, scenarios = NULL, title = "Clinical Cases Over Time") {
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package 'ggplot2' is required for this function. Please install it.")
  }
  
  # Extract cases data
  if (inherits(results, "minter_results") || inherits(results, "mintweb_results")) {
    data <- results$cases
  } else {
    data <- results
  }
  
  # Filter scenarios if specified
  if (!is.null(scenarios)) {
    data <- data[data$scenario_tag %in% scenarios, ]
  }
  
  # Create plot
  p <- ggplot2::ggplot(data, ggplot2::aes(x = .data$timestep, 
                                           y = .data$cases, 
                                           color = .data$scenario_tag)) +
    ggplot2::geom_line(linewidth = 1) +
    ggplot2::labs(
      title = title,
      x = "Timestep (14-day periods)",
      y = "Clinical Cases (per 1000)",
      color = "Scenario"
    ) +
    ggplot2::theme_minimal() +
    ggplot2::theme(legend.position = "bottom")
  
  p
}
