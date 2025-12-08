# Tests for zzz.R functions

test_that("minte_available returns logical", {
  result <- minte_available()
  expect_type(result, "logical")
})

test_that("minte_available returns TRUE when Python is available", {
  skip_if_no_python_pkgs()
  
  result <- minte_available()
  expect_true(result)
})

test_that("configure_minte runs without error", {
  skip_if_no_python_pkgs()
  
  # Basic call without arguments

  expect_no_error(configure_minte())
})

test_that("configure_minte with python_version", {
  skip_if_no_python_pkgs()
  
  # This should not error even if version is already satisfied
  expect_no_error(configure_minte(python_version = ">=3.9"))
})

test_that("configure_minte with gpu=FALSE (default)", {
  skip_if_no_python_pkgs()
  
  expect_no_error(configure_minte(gpu = FALSE))
})

# Note: We don't test gpu=TRUE as it would try to install CUDA torch
# which is not available in CI environments

test_that("install_minte function exists and is callable",
{
  # Just check the function exists and has correct signature
  expect_true(is.function(install_minte))
  expect_true("envname" %in% names(formals(install_minte)))
  expect_true("method" %in% names(formals(install_minte)))
})
