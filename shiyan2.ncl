begin
dir = "typhoon/"
filename="wrf_seckf.nc"
f = addfile( dir+filename,"r") 
u = new((/15/),"float")
v = new((/15/),"float")   ;t needs defining,its about times
V = new((/15/),"float")
pre = new((/15/),"float")
loc=new((/15,2/), "float")
loc1=new((/15,2/), "float")
loc2=new((/15,2/), "float")
i_1=new((/15/),"integer")
j_1=new((/15/),"integer")
i_2=new((/15/),"integer")
j_2=new((/15/),"integer")
t = ((/1,2,3,4,5,6,7,8,9,10,11,12,13,14,15/))
dstc=new((/15/),"float")
minlon = 110
maxlon = 130
minlat = 5
maxlat = 30
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
;print(exe_1)
;print(exe_2)
;print(exe1)
;print(exe2)
do time = 0,14
;time = 0
       P  = f->P(time,:,:,:)
       PB = f->PB(time,:,:,:)
       p  = ( P + PB )
ar = p(:,exe_2(1):exe_1(1),exe_2(0):exe_1(0))   ;j,i(weidu,jingdu)
Hi = wrf_user_getvar(f, "geopt", time)    ;height
H = Hi(:,exe_2(1):exe_1(1),exe_2(0):exe_1(0))
slp = wrf_user_getvar(f,"slp",time)  ; calculate SLP
;slp1=slp(exe_2(1):exe_1(1),exe_2(0):exe_1(0)) 
;printVarSummary(slp1)
;ar = f->P_HYD(time,:,exe_2(1):exe_1(1),exe_2(0):exe_1(0))    ;the actual pressure
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
j_1(time) = e-5+exe_2(1);i的范围weidu
j_2(time) = e+5+exe_2(1)
i_1(time) = d-5+exe_2(0);j的范围jingdu
i_2(time) = d+5+exe_2(0)
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
pre_2     = slp(j_1(time):j_2(time),i_1(time):i_2(time))
pre_1     = pre_2*1.0
pre_1@units = "hPa"
V_1 = sqrt(u_1*u_1+v_1*v_1)
V(time)=max(V_1)
pre(time)=min(pre_1)
V_2=ndtooned(V_1)  
c1=maxind(V_2)
;print(c1)
d=mod(c1,11);jingdu
e=(c1-d)/11;weidu
;print(d);3是dimsize(j)，是这一范围内j有多少个位置点（经度）
;print(e)
loc1(time,:) = wrf_user_ij_to_ll(f,i_1(time)+d,j_1(time)+e,True) 
delete(d)
delete(e)
delete(V_2)
pre_3=ndtooned(pre_1)  
c2=minind(pre_3)
;print(c2)
d=mod(c2,11)
e=(c2-d)/11
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
