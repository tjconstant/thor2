context("filter_class")

test_that("filters return correct transmission", {
  thorlabs_filter_import("FEL0550")
  FEL0550$name
  FEL0550$plot()
  FEL0550$data
  FEL0550$Transmission(200:700)


  expect_error(thorlabs_filter_import("FEL590"))
})

