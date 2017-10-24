#' Title
#'
# #' @param name The ThorLabs designation of the filter (for example FEL0550)
#'
#' @return $new() returns a thorlabs_filter object
#' @export thorlabs_filter
#' @exportClass thorlabs_filter
#'
#' @field name name
#' @field data data
#'
#' @method plot plot
#'
#' @examples
#'
thorlabs_filter <- setRefClass("thorlabs_filter",
                               fields = list(name = "character", data = "data.frame"),
                               methods = list(
                                ### initialize object
                                initialize = function(name){
                                   .self$name <- name
                                   .exists()

                                   ## Data Tidy
                                   .self$data <- as.data.frame(subset(thor2:::filters, filter == name))
                                   .self$data <- na.omit(.self$data)
                                   .self$data[[2]] <- .self$data[[2]]/100 # fractional transmission
                                   rownames(.self$data) <- seq(length=nrow(.self$data))
                                 },
                                 ### Exists: Does the filter exist in the database? ###
                                 .exists = function(){
                                   if(any(name == unique(thor2:::filters$filter))){

                                     return(TRUE)

                                   }else{

                                     fail_message <- "Filter name does not exist in thor2 database."
                                     possibles <- agrep(pattern = .self$name, x = unique(thor2:::filters$filter), value = TRUE, ignore.case = TRUE)

                                     if(length(possibles) > 0){
                                       stop(paste(fail_message, "\n Did you mean one of these?", paste(possibles, collapse = ", ")))
                                     }else{
                                       stop(fail_message)
                                     }

                                   }
                                 },
                                 ### Fit a spline to the filter data ###
                                 .spline = function(){

                                   transmission_function <- function(wavelength_nm) {

                                     if((max(wavelength_nm) > max(data[[1]]) | (min(wavelength_nm) < min(data[[1]])))){
                                       warning("Wavelength is outside dataset range")
                                     }

                                     return(stats::splinefun(data[[1]], data[[2]])(wavelength_nm))
                                   }

                                   return(transmission_function)
                                 },
                                 ### Plot the recorded filter response and fit ###
                                 plot = function(...){

                                   graphics::plot(data$`Wavelength (nm)`, data$`% Transmission`, xlab = "wavelength (nm)", ylab = "T", pch = 16, ...)
                                   graphics::lines(data$`Wavelength (nm)`, .spline()(data$`Wavelength (nm)`), type='l', lwd = 2, col = 2)

                                 },
                                 ### Return the Filter's transmission for a given wavelength ###
                                 Transmission = function(wavelength_nm){

                                   transmission_frac <- .spline()(wavelength_nm)

                                   return(transmission_frac)
                                 },
                                 ### Return the Filter's optical density for a given wavelength ###
                                 OpticalDensity = function(wavelength_nm){
                                   return(-log10(Transmission(wavelength_nm = wavelength_nm)))
                                   }
                               )
                               )

#' Import Filter
#'
#' Create filter object given the thorlabs designation
#'
#' @param name The ThorLabs designation of the filter (for example FEL0550)
#'
#' @return loads the specified thorlabs_filter object into the GlobalEnv
#' @export
#'
#' @examples
#' thorlabs_filter_import("FEL0650")
#' FEL0650$Transmission(wavelength_nm = 500)

thorlabs_filter_import <- function(name){
  eval(parse(text = paste(gsub(pattern = "-", replacement = "_", name), "<- thorlabs_filter$new(name = '",name,"')", sep="")), envir = globalenv())
}



