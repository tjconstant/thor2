# thor2
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/tjconstant/thor2?branch=master&svg=true)](https://ci.appveyor.com/project/tjconstant/thor2)[![Build Status](https://travis-ci.org/tjconstant/thor2.svg?branch=master)](https://travis-ci.org/tjconstant/thor2)


Optical response of various thorlab components for use in R

The main function is named `thorlabs_filter()` and will return the fractional transmission given the wavelength(s) of a named filter. For example:

```r
thorlabs_filter(name = "FEL0450", wavelength_nm = 200:700)
```

Returns the transmission of a long-pass 450 nm cut-off filter in the range 200 nm to 700 nm. 

To quickly see the data and fit for any filter use `thorlabs_filter.plot()`.

To export a filter's function to the global enviroment (following the naming convention of functions from the orginal `thor` package), you can do the following:

```r
thorlabs_filter.import("FES0650")
# Then just use,
FES0650(wavelength_nm = 500)
# as before
```

For backwards compatibility with thor (v1), the FEL0550, FEL0600 and FES550 filters are exported to to the global enviroment automatically when the package loads. The APD120A2 photodetetor is also avaliable.

--------

## To Do

* Implement fuzzy search in the internal thorlabs_filter.exists() function.
* Abstract functions further to automatically deal with parameter other than wavelength / transmission
