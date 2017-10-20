#' Transmission of ThorLabs Dielectric Filters
#'
#' @param name The ThorLabs designation of the filter (for example FEL0550)
#' @param wavelength_nm The wavelength(s) incident on the filter
#'
#' @return The fractional transmission through the filter
#' @export
#'
#' @examples
#' thorlabs_filter("FEL0450", 200:700)
#'
#' plot(200:700, thorlabs_filter("FES0550", 200:700), xlab = "wavelength (nm)", ylab = "T")
#'
thorlabs_filter <- function(name, wavelength_nm){

  thorlabs_filter.exists(name)

  transmission_function <- thorlabs_filter.spline(name)

  transmission_pct <- transmission_function(wavelength_nm)
  transmission_frac <- transmission_pct/100

  return(transmission_frac)
}

#' Plot the Transmission Spectra of Thorlabs Filter
#'
#' @inheritParams thorlabs_filter
#' @param ... graphical arguments
#'
#' @return Plots to current device the provided transmission spectra (points) and the spline fit (line).
#' @export
#'
#' @examples
#' thorlabs_filter.plot("FEL0700")
thorlabs_filter.plot <- function(name, ...){

  thorlabs_filter.exists(name)
  filter <- subset(filters, filter == name)

  plot(filter$`Wavelength (nm)`, 0.01*filter$`% Transmission`, xlab = "wavelength (nm)", ylab = "T", pch = 16, ...)
  lines(filter$`Wavelength (nm)`, thorlabs_filter(name, filter$`Wavelength (nm)`), type='l', lwd = 2, col = 2)

}


#' Export filter to global enivroment
#'
#' @description
#' Exports the given filter as a spline function to the global enviroment, under it's own named function.
#'
#' @inheritParams thorlabs_filter
#'
#' @return a spline function named after the filter
#' @export
#'
#' @examples
#' thorlabs_filter.import("FES0650")
#' FES0650(500)
#'
thorlabs_filter.import <- function(name){
  thorlabs_filter.exists(name)
  eval(parse(text = paste(name, "<- function(wavelength_nm) thorlabs_filter.spline('",name,"')(wavelength_nm)/100", sep="")), envir = globalenv())
}


#  #### Internal Functions #####


#' Get spline function from Transmission data
#'
#' @inheritParams thorlabs_filter
#'
#' @return A sspline function accepting wavelength_nm argument
#' @note This is an internal function for thor2, and not intended for use outside of it
#' @export
#' @examples
#' FEL0450 <- thorlabs_filter.spline("FEL0450")
#'
thorlabs_filter.spline <- function(name){

  transmission <- subset(filters, filter == name)  # from manual

  transmission_function <- function(wavelength_nm) {

    if((max(wavelength_nm) > max(transmission[[1]]) | (min(wavelength_nm) < min(transmission[[1]])))){
      warning("wavelength is outside dataset range")
    }

    return(stats::splinefun(transmission[[1]], transmission[[2]])(wavelength_nm))

  }

  return(transmission_function)

}

#' Check filter exists
#'
#' @inheritParams thorlabs_filter
#'
#' @return NULL
#' @note This is an internal function for thor2, and not intended for use outside of it
#'
#' @examples
thorlabs_filter.exists <- function(name){
  if(any(name == unique(filters$filter))){

  }else{
    stop("Filter name does not exist in thor2 database")
  }
}





