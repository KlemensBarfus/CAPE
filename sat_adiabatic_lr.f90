module mod_sat_adiabatic_lr

contains

real function sat_adiabatic_lr(p, T)
use mod_saturation_vapour_pressure
use mod_saturation_mixing_ratio

implicit none

! calculates the saturated adiabatic lapse rate after
! Stull, Meteorology for Scientists and Engineers. Eq 5.33a
! incoming parameters are
! p pressure in hPa
! T temperature in K
! output is in K m**-1

! written by K.Barfus, 12/2009

real, intent(in):: p
real, intent(in):: T

real:: g, Cpd, e, es, rs, Cp, Lv, Rd

g = -9.807  ! [m/s**-2]
Cpd = 1004.67 ![J*kg**-1*K**-1]
e = 0.622 ! Rd/Rv [g_vapor/g_dry_air]
es = saturation_vapour_pressure(T) ! [hPa]
rs = saturation_mixing_ratio(p,es) ! saturation mixing ratio [g_vapor/g_dryair]
Cp = Cpd * (1.0 + 0.84 * rs)
Lv = 2.5*10**6.0 ![J*kg**-1]
Rd = 287.053    ![J*K**-1*kg*-1]

sat_adiabatic_lr = (g / Cp) * ((1.0+((rs*Lv)/(Rd*T)))/(1.0+((Lv**2.0*rs*e)/(Cp*Rd*T**2.0))))

end function

end module
