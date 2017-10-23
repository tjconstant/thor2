context("filters")

test_that("filters return transmission", {
  expect_equal(round(thorlabs_filter("FES0550", 500),3), 0.845)
})

test_that("wavelength out of range gives warning returning transmission", {
  expect_warning(round(thorlabs_filter("FES0550", 50000),3))
})

test_that("can import filter to namespace", {
  thorlabs_filter.import("FES0550")
  result <- round(FES0550(wavelength_nm = 512), 3)
  expect_equal(result, 0.861)
})

test_that("exported function equals base function result", {
  thorlabs_filter.import("FES0550")
  expect_equal(thorlabs_filter("FES0550", wavelength_nm = 200:700), FES0550(200:700))
})
