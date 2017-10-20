#' Power from Thorlabs APD120A2 given signal voltage
#'
#' @description Power from Thorlabs Avalanche PhotoDetector Number APD120A2 for a given signal voltage
#'
#' @param signal_mV signal measured on lock-in amplifier in mV
#' @param wavelength_nm incident wavelength in nanometers
#'
#' @return Returns the incident power (in nW) on the photodetector
#' @export
#'
#' @examples
#' APD120A2(10)
#'
APD120A2 <- function(signal_mV, wavelength_nm = 550){

  APD120A2_Responsivity <- APD120A2_data # from manual
  APD120A2_Responsivity_Function <- stats::splinefun(APD120A2_Responsivity$wavelength_nm, APD120A2_Responsivity$responsivity_ApW)

  Transimpedance_Gain <- 50e3 # V/A with 50 ohm termination (from manual)
  signal_V <- signal_mV * 1e-3

  power_W <- signal_V / (APD120A2_Responsivity_Function(wavelength_nm) * Transimpedance_Gain)

  power_nW <- power_W * 1e9

  return(power_nW)
}
