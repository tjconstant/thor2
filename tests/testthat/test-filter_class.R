context("filter_class")

test_that("Class returns name", {
  thorlabs_filter_import("FEL0550")
  expect_equal(FEL0550$name, "FEL0550")
})

test_that("Filter data returned is correct length", {
  thorlabs_filter_import("FEL0550")
  expect_length(FEL0550$data[,1], 2401)
})

test_that("Filter returns correct transmission", {
  thorlabs_filter_import("FEL0550")
  expect_equal(round(FEL0550$Transmission(555),3), round(0.8538235,3))
})

test_that("Filter returns correct optical density", {
  thorlabs_filter_import("FEL0550")
  expect_equal(round(FEL0550$OpticalDensity(555),3), round(-log10(0.8538235),3))
})


test_that("Filter returns error on intialization when filter doesn't exist",{
  expect_error(thorlabs_filter_import("FEL590"))
})

test_that("Filter returns error on intialization when filter doesn't exist, with no suggestions",{
  expect_error(thorlabs_filter_import("bobcat"))
})

test_that("Filter spectra can be plotted",{
  thorlabs_filter_import("FEL0550")
  expect_error(FEL0550$plot(),NA)
})

test_that("Warning appears for value outside dataset",{
  thorlabs_filter_import("FEL0550")
  expect_warning(FEL0550$Transmission(550000))
})

test_that("All Filters can be loaded", {
  expect_error({
    for(f in unique(filters$filter)){
      thorlabs_filter_import(f)
    }
  }, NA)
})

test_that("APD works", {
  expect_equal(round(APD120A2(550),2),round(465.7747,2))
})

