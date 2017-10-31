# thor2 - dev-eoo
### Experimental Object Oriented Branch

------

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/tjconstant/thor2?branch=dev-eoo&svg=true)](https://ci.appveyor.com/project/tjconstant/thor2) [![Build Status](https://travis-ci.org/tjconstant/thor2.svg?branch=dev-eoo)](https://travis-ci.org/tjconstant/thor2) [![codecov](https://codecov.io/gh/tjconstant/thor2/branch/dev-eoo/graph/badge.svg)](https://codecov.io/gh/tjconstant/thor2/branch/dev-eoo)


Optical response of various thorlab components for use in R

The main function is named `thorlabs_filter_import()` and will return a object of class `thorlabs_filter` and load it into the enviroment.

```r
thorlabs_filter_import("FES0550")

class(FES0550)
[1] "thorlabs_filter"
```

The following fields and methods are currently implemented: `name` `data` `plot()` `Transmission()`. 

To quickly see the data and fit for any filter: 

```r 
FEL0550$plot()
````

To access a fit of the filter's transmission function:

```r
FEL0550$Transmission(200:700)
```

Returns the transmission from 200 nm to 700 nm.

--------

## To Do

* Look into default methods to avoid clunky $Transmission() call
* Write documentation properly
