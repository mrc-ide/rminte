# Tests for emulator.R functions

test_that("create_scenarios creates valid data frame", {
  skip_if_no_python_pkgs()
  
  scenarios <- create_scenarios(
    eir = c(50, 100),
    dn0_use = c(0.5, 0.4),
    dn0_future = c(0.6, 0.5),
    Q0 = c(0.92, 0.92),
    phi_bednets = c(0.85, 0.85),
    seasonal = c(1, 0),
    routine = c(0.1, 0.1),
    itn_use = c(0.6, 0.5),
    irs_use = c(0.0, 0.1),
    itn_future = c(0.7, 0.6),
    irs_future = c(0.3, 0.2),
    lsm = c(0.0, 0.1)
  )
  
  expect_s3_class(scenarios, "data.frame")
  expect_equal(nrow(scenarios), 2)
})

test_that("run_malaria_emulator works with scenarios", {
  skip_if_no_python_pkgs()
  
  scenarios <- create_scenarios(
    eir = 50,
    dn0_use = 0.5,
    dn0_future = 0.6,
    Q0 = 0.92,
    phi_bednets = 0.85,
    seasonal = 1,
    routine = 0.1,
    itn_use = 0.6,
    irs_use = 0.0,
    itn_future = 0.7,
    irs_future = 0.3,
    lsm = 0.0
  )
  
  results <- run_malaria_emulator(scenarios, predictor = "prevalence")
  
  expect_s3_class(results, "data.frame")
  expect_true(nrow(results) > 0)
})

test_that("load_emulator_models runs without error", {
  skip_if_no_python_pkgs()
  
  expect_no_error(load_emulator_models(predictor = "prevalence"))
  expect_no_error(load_emulator_models(predictor = "cases"))
})

# Note: generate_scenario_predictions, predict_full_sequence, and batch_predict_scenarios
# are low-level internal functions in the Python API that require model objects.
# They have been removed from the R package as the wrapper signatures don't match the API.

test_that("run_malaria_emulator works with cases predictor", {
  skip_if_no_python_pkgs()
  
  scenarios <- create_scenarios(
    eir = 50,
    dn0_use = 0.5,
    dn0_future = 0.6,
    Q0 = 0.92,
    phi_bednets = 0.85,
    seasonal = 1,
    routine = 0.1,
    itn_use = 0.6,
    irs_use = 0.0,
    itn_future = 0.7,
    irs_future = 0.3,
    lsm = 0.0
  )
  
  results <- run_malaria_emulator(scenarios, predictor = "cases")
  
  expect_s3_class(results, "data.frame")
  expect_true(nrow(results) > 0)
})

test_that("run_malaria_emulator works with benchmark", {
  skip_if_no_python_pkgs()
  
  scenarios <- create_scenarios(
    eir = 50,
    dn0_use = 0.5,
    dn0_future = 0.6,
    Q0 = 0.92,
    phi_bednets = 0.85,
    seasonal = 1,
    routine = 0.1,
    itn_use = 0.6,
    irs_use = 0.0,
    itn_future = 0.7,
    irs_future = 0.3,
    lsm = 0.0
  )
  
  # benchmark=TRUE should still return results
  results <- run_malaria_emulator(scenarios, predictor = "prevalence", benchmark = TRUE)
  
  expect_s3_class(results, "data.frame")
  expect_true(nrow(results) > 0)
})
