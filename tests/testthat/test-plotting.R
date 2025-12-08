# Tests for plotting.R functions

# Helper to skip matplotlib tests on Windows CI (Tcl/Tk not available)
skip_if_no_matplotlib <- function() {
  skip_if_no_python_pkgs()
  skip_on_os("windows")  # Tcl/Tk issues on Windows CI
  Sys.setenv(MPLBACKEND = "Agg")
}

test_that("create_scenario_plots_mpl works with prevalence data", {
  skip_if_no_matplotlib()
  
  results <- run_minter_scenarios(
    scenario_tag = "plot_test",
    res_use = 0.3,
    py_only = 0.4,
    py_pbo = 0.3,
    py_pyrrole = 0.2,
    py_ppf = 0.1,
    prev = 0.25,
    Q0 = 0.92,
    phi = 0.85,
    season = 1,
    routine = 0.1,
    irs = 0.0,
    irs_future = 0.3,
    lsm = 0.0
  )
  
  # Create temp directory for plots
  temp_dir <- tempdir()
  plot_dir <- file.path(temp_dir, "test_plots")
  dir.create(plot_dir, showWarnings = FALSE)
  
  plots <- create_scenario_plots_mpl(
    results$prevalence,
    output_dir = plot_dir,
    plot_type = "combined"
  )
  
  expect_type(plots, "list")
  
  # Cleanup
  unlink(plot_dir, recursive = TRUE)
})

test_that("create_scenario_plots_mpl works without output_dir", {
  skip_if_no_matplotlib()
  
  results <- run_minter_scenarios(
    scenario_tag = "plot_test2",
    res_use = 0.3,
    py_only = 0.4,
    py_pbo = 0.3,
    py_pyrrole = 0.2,
    py_ppf = 0.1,
    prev = 0.25,
    Q0 = 0.92,
    phi = 0.85,
    season = 1,
    routine = 0.1,
    irs = 0.0,
    irs_future = 0.3,
    lsm = 0.0
  )
  
  # Without output_dir, plots should still be created but not saved
  plots <- create_scenario_plots_mpl(
    results$prevalence,
    plot_type = "individual"
  )
  
  expect_type(plots, "list")
})

test_that("create_scenario_plots_mpl works with predictor specified", {
  skip_if_no_matplotlib()
  
  results <- run_minter_scenarios(
    scenario_tag = "plot_test3",
    res_use = 0.3,
    py_only = 0.4,
    py_pbo = 0.3,
    py_pyrrole = 0.2,
    py_ppf = 0.1,
    prev = 0.25,
    Q0 = 0.92,
    phi = 0.85,
    season = 1,
    routine = 0.1,
    irs = 0.0,
    irs_future = 0.3,
    lsm = 0.0
  )
  
  plots <- create_scenario_plots_mpl(
    results$cases,
    plot_type = "combined",
    predictor = "cases"
  )
  
  expect_type(plots, "list")
})

test_that("plot_prevalence creates ggplot object", {
  skip_if_no_python_pkgs()
  skip_if_not_installed("ggplot2")
  
  results <- run_minter_scenarios(
    scenario_tag = "ggplot_test",
    res_use = 0.3,
    py_only = 0.4,
    py_pbo = 0.3,
    py_pyrrole = 0.2,
    py_ppf = 0.1,
    prev = 0.25,
    Q0 = 0.92,
    phi = 0.85,
    season = 1,
    routine = 0.1,
    irs = 0.0,
    irs_future = 0.3,
    lsm = 0.0
  )
  
  p <- plot_prevalence(results)
  
  expect_s3_class(p, "ggplot")
})

test_that("plot_prevalence works with data frame input", {
  skip_if_no_python_pkgs()
  skip_if_not_installed("ggplot2")
  
  results <- run_minter_scenarios(
    scenario_tag = "df_test",
    res_use = 0.3,
    py_only = 0.4,
    py_pbo = 0.3,
    py_pyrrole = 0.2,
    py_ppf = 0.1,
    prev = 0.25,
    Q0 = 0.92,
    phi = 0.85,
    season = 1,
    routine = 0.1,
    irs = 0.0,
    irs_future = 0.3,
    lsm = 0.0
  )
  
  # Pass data frame directly instead of results object
  p <- plot_prevalence(results$prevalence)
  
  expect_s3_class(p, "ggplot")
})

test_that("plot_prevalence filters scenarios correctly", {
  skip_if_no_python_pkgs()
  skip_if_not_installed("ggplot2")
  
  results <- run_minter_scenarios(
    scenario_tag = c("scenario_a", "scenario_b"),
    res_use = c(0.3, 0.5),
    py_only = c(0.4, 0.4),
    py_pbo = c(0.3, 0.3),
    py_pyrrole = c(0.2, 0.2),
    py_ppf = c(0.1, 0.1),
    prev = c(0.25, 0.35),
    Q0 = c(0.92, 0.92),
    phi = c(0.85, 0.85),
    season = c(1, 1),
    routine = c(0.1, 0.1),
    irs = c(0.0, 0.0),
    irs_future = c(0.3, 0.3),
    lsm = c(0.0, 0.0)
  )
  
  # Filter to just one scenario
  p <- plot_prevalence(results, scenarios = "scenario_a")
  
  expect_s3_class(p, "ggplot")
})

test_that("plot_prevalence accepts custom title", {
  skip_if_no_python_pkgs()
  skip_if_not_installed("ggplot2")
  
  results <- run_minter_scenarios(
    scenario_tag = "title_test",
    res_use = 0.3,
    py_only = 0.4,
    py_pbo = 0.3,
    py_pyrrole = 0.2,
    py_ppf = 0.1,
    prev = 0.25,
    Q0 = 0.92,
    phi = 0.85,
    season = 1,
    routine = 0.1,
    irs = 0.0,
    irs_future = 0.3,
    lsm = 0.0
  )
  
  p <- plot_prevalence(results, title = "Custom Title")
  
  expect_s3_class(p, "ggplot")
  expect_equal(p$labels$title, "Custom Title")
})

test_that("plot_cases creates ggplot object", {
  skip_if_no_python_pkgs()
  skip_if_not_installed("ggplot2")
  
  results <- run_minter_scenarios(
    scenario_tag = "cases_test",
    res_use = 0.3,
    py_only = 0.4,
    py_pbo = 0.3,
    py_pyrrole = 0.2,
    py_ppf = 0.1,
    prev = 0.25,
    Q0 = 0.92,
    phi = 0.85,
    season = 1,
    routine = 0.1,
    irs = 0.0,
    irs_future = 0.3,
    lsm = 0.0
  )
  
  p <- plot_cases(results)
  
  expect_s3_class(p, "ggplot")
})

test_that("plot_cases works with data frame input", {
  skip_if_no_python_pkgs()
  skip_if_not_installed("ggplot2")
  
  results <- run_minter_scenarios(
    scenario_tag = "cases_df_test",
    res_use = 0.3,
    py_only = 0.4,
    py_pbo = 0.3,
    py_pyrrole = 0.2,
    py_ppf = 0.1,
    prev = 0.25,
    Q0 = 0.92,
    phi = 0.85,
    season = 1,
    routine = 0.1,
    irs = 0.0,
    irs_future = 0.3,
    lsm = 0.0
  )
  
  p <- plot_cases(results$cases)
  
  expect_s3_class(p, "ggplot")
})

test_that("plot_cases filters scenarios correctly", {
  skip_if_no_python_pkgs()
  skip_if_not_installed("ggplot2")
  
  results <- run_minter_scenarios(
    scenario_tag = c("case_a", "case_b"),
    res_use = c(0.3, 0.5),
    py_only = c(0.4, 0.4),
    py_pbo = c(0.3, 0.3),
    py_pyrrole = c(0.2, 0.2),
    py_ppf = c(0.1, 0.1),
    prev = c(0.25, 0.35),
    Q0 = c(0.92, 0.92),
    phi = c(0.85, 0.85),
    season = c(1, 1),
    routine = c(0.1, 0.1),
    irs = c(0.0, 0.0),
    irs_future = c(0.3, 0.3),
    lsm = c(0.0, 0.0)
  )
  
  p <- plot_cases(results, scenarios = "case_b")
  
  expect_s3_class(p, "ggplot")
})
