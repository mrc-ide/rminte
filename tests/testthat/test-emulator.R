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

test_that("load_emulator_models returns models object", {
  skip_if_no_python_pkgs()
  
  models <- load_emulator_models(predictor = "prevalence", verbose = FALSE)
  
  # Should return a Python object (EmulatorModels)
  expect_true(!is.null(models))
})

test_that("generate_scenario_predictions works with loaded models", {
  skip_if_no_python_pkgs()
  
  # Load models first
  models <- load_emulator_models(predictor = "prevalence", verbose = FALSE)
  
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
  
  predictions <- generate_scenario_predictions(scenarios, models)
  
  # Should return a list of predictions
  expect_type(predictions, "list")
  expect_true(length(predictions) > 0)
})

# Note: predict_full_sequence and batch_predict_scenarios require very low-level
# PyTorch objects (model, tensors, device) that are difficult to test directly.
# They are exposed for advanced users who need fine-grained control.

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
