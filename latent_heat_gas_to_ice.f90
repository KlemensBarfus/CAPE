module mod_latent_heat_gas_to_ice

contains

real function latent_heat_gas_to_ice(T)

implicit none

! calculation of the latente heat of sublimation (gas -> solid) of ice due to
! Murphy, D.M. and Koop T. (2005)
! Review of the vapour pressures of ice and supercooled water for atmospheric applications.
! Quarterly Journal of the Royal Meteorological Society, 131, 1539-1565, doi: 10.1256/qj.04.94

! (alternative formula by Rogers and Yau: 
! L_ice(T) = 2834.1 - 0.29 T - 0.004 T^2 [J/g] 

! written by K.Barfus 5/2014

! input parameters
real, intent(in)::  T  ! temperature in K

! output in J kg^-1

! valid for T > 30 K

real:: latent_heat

latent_heat = 46782.5 + 35.8925 * T - 0.07414 * T**2.0 + 541.5 * exp(-1.0*(T/123.75)**2.0)  ! in J mol^-1

latent_heat = latent_heat / 18.0 ! in J g^-1

latent_heat = latent_heat * 1000.0 ! in J kg^-1

latent_heat_gas_to_ice = latent_heat


end function

end module
