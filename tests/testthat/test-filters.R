context("filters")

test_that("filters return correct transmission", {
  expect_equal(round(thorlabs_filter("FES0550", 500),3), 0.845)
})

test_that("wavelength out of range gives warning returning transmission", {
  expect_warning(round(thorlabs_filter("FES0550", 50000),3))
})

test_that("can import filter to global enviroment", {
  thorlabs_filter.import("FES0550")
  result <- round(FES0550(wavelength_nm = 512), 3)
  expect_equal(result, 0.861)
})

test_that("exported function equals base function result", {
  thorlabs_filter.import("FES0550")
  expect_equal(thorlabs_filter("FES0550", wavelength_nm = 200:700), FES0550(200:700))
})


test_that("all exported functions equals base function result", {
  for(name in unique(filters$filter)){
    thorlabs_filter.import(name)
    expect_equal(thorlabs_filter(name, 500:600),
                 eval(parse(text=paste(gsub(pattern = "-", replacement = "_", x = name),"(",500,":","600)", sep=""))))
  }
})

test_that("filter can be plotted", {
  expect_error(thorlabs_filter.plot("FES0550"), NA)
})

test_that("filter data is returned", {
  expect_equal(thorlabs_filter.data("FEL0550")[1,1], 2600)
})

test_that("filter typo is noticed", {
  expect_error(thorlabs_filter.exists("FEL0552"))
})

test_that("filter typo is noticed, but the typo is so bad no suggestions are returned", {
  expect_error(thorlabs_filter.exists("FEL055d2"))
})

test_that("the legacy photodiode function works", {
  expect_equal(round(APD120A2(555)), 470)
})

