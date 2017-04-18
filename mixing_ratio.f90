module mod_mixing_ratio

contains

real function mixing_ratio(e, ev, T)
use mod_density_of_water_vapour
use mod_density_of_dry_air

implicit none

! calculates the mixing ratio of water vapour in units of
! g water vapour / g dry air
! incoming variables are
! e: overall pressure in hPa
! ev: water vapour pressure in hPa
! absolute temperature in K

! written by K.Barfus 12/2009

real, intent(in):: e
real, intent(in):: ev
real, intent(in):: T

real:: g_water_vapour, g_dry_air

g_water_vapour = (density_of_water_vapour(ev, T)) * 1000.0
g_dry_air = (density_of_dry_air((e-ev), T)) * 1000.0
mixing_ratio = g_water_vapour / g_dry_air


end function

end module