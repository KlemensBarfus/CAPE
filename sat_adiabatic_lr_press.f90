module mod_sat_adiabatic_lr_press

! written by K.Barfus 08/10/2014

contains

real function sat_adiabatic_lr_press(p, T)
use mod_saturation_vapour_pressure
use mod_saturation_mixing_ratio

implicit none
! calculates the saturated adiabatic lapse rate for an increment of 1 hPa
! after Stull, Meteorology for Scientists and Engineers. Eq 5.34a
! incoming parameters are
! T; temperature in K
! P: pressure in hPa

! output is in K hPa**-1

real, intent(in):: p
real, intent(in):: T

real:: Cpd, e, es, rs, Cp, Lv, Rd, k1, k2


Cpd = 1004.67 ![J*kg**-1*K**-1]
e = 0.622 ! Rd/Rv [g_vapor/g_dry_air]
es = saturation_vapour_pressure(T) ! [hPa]
rs = saturation_mixing_ratio(p,es) ! saturation mixing ratio [g_vapor/g_dryair]
Cp = Cpd * (1.0 + 0.84 * rs)
Lv = 2.5*10**6.0 ![J*kg**-1]
Rd = 287.053    ![J*K**-1*kg*-1]

k1 = (Rd / Cp) * T + (Lv / Cp) * rs
k2 = p * (1.0+(Lv**2.0*rs*e)/(Cp*Rd*T**2.0))

sat_adiabatic_lr_press = k1 / k2

end function

end module mod_sat_adiabatic_lr_press
