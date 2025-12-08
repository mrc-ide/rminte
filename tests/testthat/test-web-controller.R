# Tests for web_controller.R functions

test_that("run_mintweb_controller works with single scenario", {
  skip_if_no_python_pkgs()
  
  results <- run_mintweb_controller(
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
  
  expect_s3_class(results, "mintweb_results")
  expect_true("prevalence" %in% names(results))
  expect_true("cases" %in% names(results))
})

test_that("run_mintweb_controller works with multiple scenarios", {
  skip_if_no_python_pkgs()
  
  n <- 2
  results <- run_mintweb_controller(
    res_use = rep(0.3, n),
    py_only = rep(0.4, n),
    py_pbo = rep(0.3, n),
    py_pyrrole = rep(0.2, n),
    py_ppf = rep(0.1, n),
    prev = c(0.2, 0.4),
    Q0 = rep(0.92, n),
    phi = rep(0.85, n),
    season = rep(1, n),
    routine = rep(0.1, n),
    irs = rep(0.0, n),
    irs_future = rep(0.3, n),
    lsm = rep(0.0, n)
  )
  
  expect_s3_class(results, "mintweb_results")
})

test_that("run_mintweb_controller with clean_output=FALSE", {
  skip_if_no_python_pkgs()
  
  results <- run_mintweb_controller(
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
    clean_output = FALSE
  )
  
  expect_s3_class(results, "mintweb_results")
})

test_that("format_for_json works with minter_results", {
  skip_if_no_python_pkgs()
  
  results <- run_minter_scenarios(
    scenario_tag = "json_test",
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
  
  json_result <- format_for_json(results)
  
  expect_type(json_result, "list")
  expect_true("prevalence" %in% names(json_result))
  expect_true("cases" %in% names(json_result))
  expect_true("eir_valid" %in% names(json_result))
})

test_that("format_for_json works with mintweb_results", {
  skip_if_no_python_pkgs()
  
  results <- run_mintweb_controller(
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
  
  json_result <- format_for_json(results)
  
  expect_type(json_result, "list")
  expect_true("prevalence" %in% names(json_result))
  expect_true("cases" %in% names(json_result))
})

test_that("format_for_json errors on invalid input", {
  expect_error(format_for_json(list(a = 1)), "must be a minter_results")
  expect_error(format_for_json(data.frame(x = 1)), "must be a minter_results")
})

test_that("print.mintweb_results works", {
  skip_if_no_python_pkgs()
  
  results <- run_mintweb_controller(
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
  
  expect_output(print(results), "MINTweb Results")
})
