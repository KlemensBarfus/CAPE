module mod_potential_temperature

contains

real function potential_temperature(T, p)

implicit none

! calculates the potential temperature
! written by K. Barfus 5/2014

! input values are
real, intent(in):: T  ! temperature [K]
real, intent(in):: p  ! pressure [hPa]

! output: potential temperature [K], scalar float

real:: reference_pressure, Rd, Cp, theta

reference_pressure = 1000.0 ![hPa]
Rd = 287.0 ! [J kg^-1 K^-1] gas constant dry air
Cp = 1003.0 ! [J kg^-1 K^-1] specific heat constant pressure

theta = T * (reference_pressure/p)**(Rd/Cp)
potential_temperature = theta

end function

end module