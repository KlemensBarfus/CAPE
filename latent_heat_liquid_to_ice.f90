module mod_latent_heat_liquid_to_ice

contains

real function latent_heat_liquid_to_ice(T)

implicit none

! computes the latent heat of fusion (liquid -> ice) due to Iribarne and Godson (1981)
! input: T in Kelvin, scalar, real
! output in J/kg

! written by K.Barfus 5/2014

real, intent(in):: T  ! temperature in K

real:: latent_heat

latent_heat = (0.3337 + 0.00216*(T-273.15) - 0.981 * 10.0**(-6.0) * (T-273.15)**2.0 + &
              0.159 * 10.0**(-6.0) * (T-273.15)**3.0) * 10.0**6.0
              
latent_heat_liquid_to_ice = latent_heat

end function

end module