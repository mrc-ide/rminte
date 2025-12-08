# Tests for cache.R functions

test_that("preload_all_models loads models successfully", {
  skip_if_no_python_pkgs()
  
  expect_message(preload_all_models(), "preloaded successfully")
})

test_that("get_cached_model is callable", {
  skip_if_no_python_pkgs()
  
  # First preload
  preload_all_models()
  
  # Just check the function runs without error
  # The actual model retrieval depends on Python implementation
  expect_no_error(get_cached_model("prevalence"))
})

test_that("clear_cache clears models", {
  skip_if_no_python_pkgs()
  
  # Preload first
  preload_all_models()
  
  # Clear cache
  expect_message(clear_cache(), "cache cleared")
})

test_that("cache workflow: preload, use, clear", {
  skip_if_no_python_pkgs()
  
  # Full workflow test
  expect_message(preload_all_models(), "preloaded")
  
  # Run a prediction (should use cached models)
  results <- run_minter_scenarios(
    scenario_tag = "cache_test",
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
  
  # Clear cache
  expect_message(clear_cache(), "cleared")
})
