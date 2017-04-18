module mod_latent_heat_gas_to_supercooled_water

contains

real function latent_heat_gas_to_supercooled_water(T)

implicit none

! calculation of the latent heat of vapourization (gas -> water) of supercooled water due to
! Murphy, D.M. and Koop T. (2005)
! Review of the vapour pressures of ice and supercooled water for atmospheric applications.
! Quartlerly Journal of the Royal Meteorological Society, 131, 1539-1565, doi: 10.1256/qj.04.94


! written by K.Barfus 5/2014

! input parameters
real, intent(in)::  T    ! temperature in K

! output in J kg^-1

!; valid for 273 K > T > 236 K

real:: latent_heat

latent_heat = 56579.0 - 42.212 * T + exp(0.1149 * (281.6 - T))  ! in J mol^-1

latent_heat = latent_heat / 18.0 ! in J g^-1

latent_heat = latent_heat * 1000.0 ! in J kg^-1

latent_heat_gas_to_supercooled_water = latent_heat


end function

end module