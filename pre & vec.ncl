begin
dir = "/mnt/g/NCL/data/nasha/"
f = addfile(dir + "wrf_kf.nc","r") 

u = new((/9/),"float")
v = new((/9/),"float")   ;t needs defining,its about times
V = new((/9/),"float")
pre = new((/9/),"float")
t = ((/1,2,3,4,5,6,7,8,9/))

minlon = 121
maxlon = 125
minlat = 20.5
maxlat = 24

do time = 0,8
;time = 0
ar = f->P_HYD(time,:,26:31,56:64)   ;j,i
Hi = wrf_user_getvar(f, "height", time)    ;height
H = Hi(:,26:31,56:64)
;ar = wrf_user_getvar(f, "P_HYD", time)     ;the actual pressure
ar_1 = wrf_interp_3d_z(H,ar,50000.) 

a = dim_min_n_Wrap(ar_1,0)
b = dim_min_n_Wrap(a,0)  

do j = 0,5
do i = 0,8
if(ar_1(j,i) .eq. b) then
;lc = wrf_user_ij_to_ll(f,i,j,True)
j_1 = j-3+26
j_2 = j+2+26
i_1 = i-4+56
i_2 = i+6+56       
end if
end do
end do
delete(i)
delete(j)

u_1       = f->U10(time,j_1:j_2,i_1:i_2)   ;lat,lon
v_1       = f->V10(time,j_1:j_2,i_1:i_2)
pre_2     = f->PSFC(time,j_1:j_2,i_1:i_2)
pre_1     = pre_2*0.01 
pre_1@units = "hPa"

V_1 = sqrt(u_1*u_1+v_1*v_1)
a1 = dim_max_n_Wrap(V_1,0)
a2 = dim_max_n_Wrap(a1,0)
b1 = dim_min_n_Wrap(pre_1,0)
b2 = dim_min_n_Wrap(b1,0)

do i = 0,4
do j = 0,10 
if(V_1(i,j) .eq. a2) then
V(time) = V_1(i,j)
loc = wrf_user_ij_to_ll(f,i_1+j,j_1+i,True)
print(loc)   ;0,9

end if
if(pre_1(i,j) .eq. b2) then
pre(time) = pre_1(i,j)
lc = wrf_user_ij_to_ll(f,i_1+j,j_1+i,True)
print(lc)
end if
end do
end do
end do

xyres = True
xyres@xyLineThicknesses = 1.
xyres@xyMarkLineModes = "MarkLines"
xyres@xyMarkerColors = 3
xyres@xyMarkers = 1
xyres@xyMarkerSizeF = 0.05

wks = gsn_open_wks("png","pre")
xwks = gsn_open_wks("png","vec")
plot1 = gsn_xy(wks,t,pre,xyres)
plot2 = gsn_xy(xwks,t,V,xyres)

end
