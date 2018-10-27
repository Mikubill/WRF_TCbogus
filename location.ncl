begin
dir = "/mnt/g/NCL/data/nasha/"
f = addfile(dir + "wrf_kf.nc","r") 

p = f->P_HYD

time     = 0
ar       = wrf_user_getvar(f, "P_HYD", time)     ;the actual pressure
H        = wrf_user_getvar(f, "height", time)    ;height
ar_1     = wrf_interp_3d_z(H,ar,50000.)      ;point 500hPa

res = True
a = dim_min_n_Wrap(ar_1,0)
b = dim_min_n_Wrap(a,0)

do i = 0,59
do j = 0,72
if(ar_1(i,j) .eq. b) then
lc = wrf_user_ij_to_ll(f,i,j,res)
end if
end do
end do
print(lc)
end
