# Tests for rminte package

test_that("minte_available returns logical", {
  result <- minte_available()
  expect_type(result, "logical")
})

test_that("run_minter_scenarios works with single scenario", {
  skip_if_no_python_pkgs()
  
  results <- run_minter_scenarios(
    scenario_tag = "test_scenario",
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
  
  expect_s3_class(results, "minter_results")
  expect_true("prevalence" %in% names(results))
  expect_true("cases" %in% names(results))
  expect_true("scenario_meta" %in% names(results))
  expect_true("eir_valid" %in% names(results))
  
  # Check data frames have expected columns
  expect_true("timestep" %in% names(results$prevalence))
  expect_true("prevalence" %in% names(results$prevalence))
  expect_true("scenario_tag" %in% names(results$prevalence))
})

test_that("run_minter_scenarios works with multiple scenarios", {
  skip_if_no_python_pkgs()
  
  n <- 3
  results <- run_minter_scenarios(
    scenario_tag = paste0("scenario_", 1:n),
    res_use = rep(0.3, n),
    py_only = rep(0.4, n),
    py_pbo = rep(0.3, n),
    py_pyrrole = rep(0.2, n),
    py_ppf = rep(0.1, n),
    prev = c(0.2, 0.3, 0.4),
    Q0 = rep(0.92, n),
    phi = rep(0.85, n),
    season = rep(1, n),
    routine = rep(0.1, n),
    irs = rep(0.0, n),
    irs_future = rep(0.3, n),
    lsm = rep(0.0, n)
  )
  
  expect_s3_class(results, "minter_results")
  expect_equal(nrow(results$scenario_meta), n)
})

test_that("calculate_overall_dn0 returns list with dn0 and itn_use", {
  skip_if_no_python_pkgs()
  
  result <- calculate_overall_dn0(
    resistance_level = 0.3,
    py_only = 0.4,
    py_pbo = 0.3,
    py_pyrrole = 0.2,
    py_ppf = 0.1
  )
  
  expect_type(result, "list")
  expect_true("dn0" %in% names(result))
  expect_true("itn_use" %in% names(result))
  expect_type(result$dn0, "double")
  expect_true(result$dn0 >= 0 && result$dn0 <= 1)
})

test_that("available_net_types returns character vector", {

  skip_if_no_python_pkgs()
  
  net_types <- available_net_types()
  
  expect_type(net_types, "character")
  expect_true(length(net_types) > 0)
  # Check for any pyrethroid-related net type
  expect_true(any(grepl("pyrethroid", net_types, ignore.case = TRUE)))
})

test_that("preload_all_models runs without error", {
  skip_if_no_python_pkgs()
  
  expect_no_error(preload_all_models())
})

test_that("clear_cache runs without error", {
  skip_if_no_python_pkgs()
  
  expect_no_error(clear_cache())
})

test_that("print.minter_results works", {
  skip_if_no_python_pkgs()
  
  results <- run_minter_scenarios(
    scenario_tag = "print_test",
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
  
  expect_output(print(results), "MINTer Results")
})

test_that("run_minter_scenarios works with itn_future parameter", {
  skip_if_no_python_pkgs()
  
  results <- run_minter_scenarios(
    scenario_tag = "itn_future_test",
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
    lsm = 0.0,
    itn_future = 0.8
  )
  
  expect_s3_class(results, "minter_results")
})

test_that("run_minter_scenarios works with net_type_future parameter", {
  skip_if_no_python_pkgs()
  
  results <- run_minter_scenarios(
    scenario_tag = "net_type_future_test",
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
    lsm = 0.0,
    itn_future = 0.8,
    net_type_future = "py_pbo"
  )
  
  expect_s3_class(results, "minter_results")
})

test_that("run_minter_scenarios works with benchmark=TRUE", {
  skip_if_no_python_pkgs()
  
  results <- run_minter_scenarios(
    scenario_tag = "benchmark_test",
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
    lsm = 0.0,
    benchmark = TRUE
  )
  
  expect_s3_class(results, "minter_results")
  expect_true("benchmarks" %in% names(results))
})

test_that("run_minter_scenarios works with single predictor", {
  skip_if_no_python_pkgs()
  
  # Prevalence only
  results_prev <- run_minter_scenarios(
    scenario_tag = "prev_only",
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
    lsm = 0.0,
    predictor = "prevalence"
  )
  
  expect_s3_class(results_prev, "minter_results")
  
  # Cases only
  results_cases <- run_minter_scenarios(
    scenario_tag = "cases_only",
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
    lsm = 0.0,
    predictor = "cases"
  )
  
  expect_s3_class(results_cases, "minter_results")
})

test_that("run_minter_scenarios auto-generates scenario_tag", {
  skip_if_no_python_pkgs()
  
  # Without scenario_tag
  results <- run_minter_scenarios(
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
  
  expect_s3_class(results, "minter_results")
  expect_true("scenario_tag" %in% names(results$prevalence))
})

test_that("run_minter_scenarios with perennial season", {
  skip_if_no_python_pkgs()
  
  results <- run_minter_scenarios(
    scenario_tag = "perennial_test",
    res_use = 0.3,
    py_only = 0.4,
    py_pbo = 0.3,
    py_pyrrole = 0.2,
    py_ppf = 0.1,
    prev = 0.25,
    Q0 = 0.92,
    phi = 0.85,
    season = 0,  # Perennial
    routine = 0.1,
    irs = 0.0,
    irs_future = 0.3,
    lsm = 0.0
  )
  
  expect_s3_class(results, "minter_results")
})

test_that("run_minter_scenarios with LSM intervention", {
  skip_if_no_python_pkgs()
  
  results <- run_minter_scenarios(
    scenario_tag = "lsm_test",
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
    irs_future = 0.0,
    lsm = 0.5  # With LSM
  )
  
  expect_s3_class(results, "minter_results")
})

test_that("run_minter_scenarios with current IRS", {
  skip_if_no_python_pkgs()
  
  results <- run_minter_scenarios(
    scenario_tag = "irs_test",
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
    irs = 0.3,  # Current IRS
    irs_future = 0.5,
    lsm = 0.0
  )
  
  expect_s3_class(results, "minter_results")
})
