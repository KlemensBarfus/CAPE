module mod_latent_heat_of_solidification

contains


real function latent_heat_of_solidification(T)
! calculates the latent heat of solidification due to 
! Manzato; A. and Morgan Jr, G. (2003)
! Evaluating the sounding instability with the Lifted Parcel Theory.
! Atmospheric Research, 67-68, 455-473, 
! doi:10.1016/S0169-8095(03)00059-0
! incoming parameters are
! T temperature in [K]
! output:
! latent heat of solidification [J/kg]

implicit none

real, intent(in):: T

real:: t_temp

t_temp = T - 273.15

latent_heat_of_solidification = 338200.0 + 2.3 * 10.0**3.0 * t_temp + 3.6 * (t_temp + 35.0)**2.0

end function

end module
