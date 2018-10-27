begin
dir = "typhoon/"
filename="wrf_okf.nc"
f = addfile( dir+filename,"r") 
u = new((/9/),"float")
v = new((/9/),"float")   ;t needs defining,its about times
V = new((/9/),"float")
pre = new((/9/),"float")
loc=new((/9,2/), "float")
loc1=new((/9,2/), "float")
loc2=new((/9,2/), "float")
i_1=new((/9/),"integer")
j_1=new((/9/),"integer")
i_2=new((/9/),"integer")
j_2=new((/9/),"integer")
t = ((/1,2,3,4,5,6,7,8,9/))
dstc=new((/9/),"float")
minlon = 121
maxlon = 125
minlat = 20.5
maxlat = 24
opt=True
opt@MAP_PROJ=1
opt@TRUELAT1=0.0
opt@TRUELAT2=10.0
opt@STAND_LON=120.0
opt@REF_LON=119.00
opt@REF_LAT=22.00
opt@KNOWNJ=37.0
opt@KNOWNI=30.5
opt@DX=25600
opt@DY=25600
exe_1=wrf_user_ll_to_ij(f,maxlon,maxlat,opt)
exe_2=wrf_user_ll_to_ij(f,minlon,minlat,opt)
exe1=wrf_user_ij_to_ll(f,exe_1(0),exe_1(1),opt)
exe2=wrf_user_ij_to_ll(f,exe_2(0),exe_2(1),opt)
print(exe_1)
print(exe_2)
print(exe1)
print(exe2)
do time = 0,8
;time = 0
ar = f->P_HYD(time,:,exe_2(1):exe_1(1),exe_2(0):exe_1(0))   ;j,i(weidu,jingdu)
Hi = wrf_user_getvar(f, "height", time)    ;height
H = Hi(:,exe_2(1):exe_1(1),exe_2(0):exe_1(0))
;ar = wrf_user_getvar(f, "P_HYD", time)     ;the actual pressure
ar_1 = wrf_interp_3d_z(H,ar,50000.) 
ar_2=ndtooned(ar_1)  
c=minind(ar_2)
;print(c)
d=mod(c,(exe_1(0)-exe_2(0)+1));j的位置jingdu
e=(c-d)/(exe_1(0)-exe_2(0)+1);i的位置weidu
;print(d);9是dimsize(j)(第二个维度)
;print(e)
x=exe_2(1)+e;j
;exe_2(1):exe_1(1),exe_2(0):exe_1(0)
;(exe_1(0)-exe_2(0)+1)
y=exe_2(0)+d;i
loc(time,:) = wrf_user_ij_to_ll(f,y,x,opt);经度，纬度
j_1(time) = e-3+exe_2(1);i的范围weidu
j_2(time) = e+2+exe_2(1)
i_1(time) = d-2+exe_2(0);j的范围jingdu
i_2(time) = d+3+exe_2(0)
delete(c)
delete(d)
delete(e)
delete(ar_2)
;exe1=wrf_user_ij_to_ll(f,i_1(time),j_1(time),True)
;exe2=wrf_user_ij_to_ll(f,i_2(time),j_2(time),True)
;print(exe1)
;print(exe2)
u_1       = f->U10(time,j_1(time):j_2(time),i_1(time):i_2(time))   ;lat,lon
v_1       = f->V10(time,j_1(time):j_2(time),i_1(time):i_2(time))
pre_2     = f->PSFC(time,j_1(time):j_2(time),i_1(time):i_2(time))
pre_1     = pre_2*0.01 
pre_1@units = "hPa"
V_1 = sqrt(u_1*u_1+v_1*v_1)
V(time)=max(V_1)
pre(time)=min(pre_1)
V_2=ndtooned(V_1)  
c1=maxind(V_2)
;print(c1)
d=mod(c1,6);jingdu
e=(c1-d)/6;weidu
print(d);6是dimsize(j)，是这一范围内j有多少个位置点（经度）
print(e)
loc1(time,:) = wrf_user_ij_to_ll(f,i_1(time)+d,j_1(time)+e,True) 
delete(d)
delete(e)
delete(V_2)
pre_3=ndtooned(pre_1)  
c2=minind(pre_3)
;print(c2)
d=mod(c2,6)
e=(c2-d)/6
;print(d);11是dimsize(i)
;print(e)
loc2(time,:) = wrf_user_ij_to_ll(f,i_1(time)+d,j_1(time)+e,True)
dstc(time)=gc_latlon(loc1(time,1), loc1(time,0), loc2(time,1), loc2(time,0), 2, 4)
delete(d)
delete(e)
delete(pre_3)
end do
xyres = True
xyres@xyLineThicknesses = 1.
xyres@xyMarkLineModes = "MarkLines"
xyres@xyMarkerColors = 3
xyres@xyMarkers = 1
xyres@xyMarkerSizeF = 0.05
wks = gsn_open_wks("png","pre"+"_"+filename)
xwks = gsn_open_wks("png","vec"+"_"+filename)
plot1 = gsn_xy(wks,t,pre,xyres)
plot2 = gsn_xy(xwks,t,V,xyres)
print(loc)
print(loc1)
print(loc2)
print(V)
print(pre)
print(dstc)
end

