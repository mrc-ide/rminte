# Tests for parser.R functions

test_that("calculate_overall_dn0 works with various inputs", {
  skip_if_no_python_pkgs()
  
  # Test with all net types
  result <- calculate_overall_dn0(
    resistance_level = 0.5,
    py_only = 0.25,
    py_pbo = 0.25,
    py_pyrrole = 0.25,
    py_ppf = 0.25
  )
  
  expect_type(result, "list")
  expect_true("dn0" %in% names(result))
  expect_true("itn_use" %in% names(result))
  expect_type(result$dn0, "double")
  expect_type(result$itn_use, "double")
  expect_true(result$dn0 >= 0 && result$dn0 <= 1)
  expect_equal(result$itn_use, 1.0)  # Sum of all net types
})

test_that("calculate_overall_dn0 works with zero resistance", {
  skip_if_no_python_pkgs()
  
  result <- calculate_overall_dn0(
    resistance_level = 0.0,
    py_only = 0.5,
    py_pbo = 0.5
  )
  
  expect_type(result$dn0, "double")
  expect_true(result$dn0 >= 0)
})

test_that("calculate_overall_dn0 works with high resistance", {
  skip_if_no_python_pkgs()
  
  result <- calculate_overall_dn0(
    resistance_level = 0.9,
    py_only = 0.5,
    py_pbo = 0.5
  )
  
  expect_type(result$dn0, "double")
})

test_that("available_net_types returns expected types", {
  skip_if_no_python_pkgs()
  
  net_types <- available_net_types()
  
  expect_type(net_types, "character")
  expect_true(length(net_types) >= 4)  # At least 4 net types expected
})

# Note: define_bednet_types and resistance_to_dn0 have different signatures
# in the Python API than the R wrappers expect. These are placeholder wrappers
# for future API compatibility.
