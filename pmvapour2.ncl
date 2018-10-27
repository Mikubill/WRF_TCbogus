begin
dir="ziliao/"
f=addfile(dir+"gdas1.fnl0p25.2017072912.f00.grib2","r") 
 lat     =f->lat_0
  lon     =f->lon_0
  p       =f->lv_ISBL0
  aa=dimsizes(p)
  mm=21
  wks  = gsn_open_wks("png","pmvwr")  
u = f->UGRD_P0_L100_GLL0(10:30,:,:)
v = f->VGRD_P0_L100_GLL0(10:30,:,:)
Uw = f->RH_P0_L100_GLL0(10:30,:,:)   ;a = f->lv_ISBL4      ;21
T = f->TMP_P0_L100_GLL0(10:30,:,:)   ;b = f->lv_ISBL0      ;26
p1 = new((/21,721,1440/),"float")
leftlat2  =  22.25
  rightlat2 =  23.5
  leftlon2  =  119.25
  rightlon2 =  126.75
do i = 0,720
p1(:,i,:) = lat(i)
end do
do j = 0,1439
p1(:,:,j) = lon(j)
end do
do k = 0,16
p1(k,:,:) = 100 + k*50
end do
delete(k)
do k = 17,20
p1(k,:,:) = 900 + (k-16)*25
end do
p1!0 = "lv_ISBL0"
p1!1 = "lat_0"
p1!2 = "lon_0"
es= 6.1078*exp(17.2693882*(T-273.16)/(T-35.86))
q = 0.622*Uw*es/p1
qu1 = u*q*0.01
qv1 = v*q*0.01
slatp=floattointeger((leftlat2+90)*4)
slonp=floattointeger(leftlon2*4)
qu=qu1(:,slonp:slonp+mm,slatp:slatp+mm)
qv=qv1(:,slonp:slonp+mm,slatp:slatp+mm)
delete(u)
delete(v)
delete(Uw)
delete(T)
qu!0 = "lv_ISBL0"
qu!1 = "lat_1"
qu!2 = "lon_1"
qv!0 = "lv_ISBL0"
qv!1 = "lat_1"
qv!2 = "lon_1" 
Qup= dim_sum_n(qu,0);jingweidu,gaoduleiji,qv2
Qvp= dim_sum_n(qv,0)
Qud = qu(:,21,:)*(-1);erwei,weidu,gaodu
Qud1=dim_sum_n(Qud, 1)
Qud0=dim_sum_n(Qud, 0);1wei,yanweixan,qv2
Qvn = qu(:,:,0);erwei,jingdu,gaodu
Qvn1=dim_sum_n(Qvn, 1)
Qvn0=dim_sum_n(Qvn, 0);1wei,yanjingxian
Qux = qu(:,0,:)
Qux0=dim_sum_n(Qux, 0)
Qux1=dim_sum_n(Qux, 1)
Qvb = qv(:,:,21)*(-1)
Qvb0=dim_sum_n(Qvb, 0)
Qvb1=dim_sum_n(Qvb, 1)
Qall=Qud1+Qvn1+Qux1+Qvb1
print(Qud1)
print(Qvn1)
print(Qux1)
print(Qvb1)
print(Qall);21ge
Qbian=new((/mm*4+4/), "float")
Qbian(0:21)=Qud0(::-1)
Qbian(22:43)=Qvn0(::-1)
Qbian(44:65)=Qux0(::-1)
Qbian(66:87)=Qvb0(::-1)
print(Qbian);88ge
end
