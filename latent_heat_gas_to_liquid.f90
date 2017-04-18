module mod_latent_heat_gas_to_liquid

contains

real function latent_heat_gas_to_liquid(T)

implicit none

! latent heat of condensation due to Rogers and Yau in J/kg
! valid for 248.15 K < T < 313.15 K
 
!; input parameters: 

real, intent(in):: T  ! temperature in K

real:: T_temp, latent_heat

T_temp = T - 273.15

latent_heat = 2500.8 - 2.36 * T_temp + 0.0016 * T_temp**2.0 - 0.00006 * T_temp**3.0

latent_heat_gas_to_liquid = latent_heat * 1000.0

! alternative approach
! calculates the latent heat of condensation (gas -> liquid) due to
! Fleagle, R.G. and J.A. Businger, (1980)
! An Introduction to Atmospheric Physics.  2d ed.  Academic Press, 432 pp.

! input
! T in K
! output in J kg^-1 K^-1

!t_temp = T - 273.15

!Lv = (25.00 - 0.02274 * t_temp) * 10.0^5.0


end function

end module