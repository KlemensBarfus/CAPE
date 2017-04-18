module mod_N_ice

contains


real function N_ice(T)
! calculates the concentration of ice nuclei dependent on temperature
! due to:
! Meyers, M.P., DeMott, P.J. and Cotton, W.R. (1992) New primary ice-nucleation parametrizations in an explicit cloud model.
! Journal of Applied Meteorology, 31, 708-721.
! incoming parameters are:
! T temperature [K] 

implicit none

real, intent(in):: T

real:: t_temp

t_temp = T - 273.15
N_ice = exp(-2.8 - 0.262 * t_temp)
 
end function

end module
