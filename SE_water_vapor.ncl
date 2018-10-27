begin
dir = "/mnt/g/NCL/data/nasha0.25/"
f1 = addfile(dir + "gdas1.fnl0p25.2017072812.f00.grib2","r")    ;pressure from different times
f2 = addfile(dir + "gdas1.fnl0p25.2017072818.f00.grib2","r")
f3 = addfile(dir + "gdas1.fnl0p25.2017072900.f00.grib2","r")
f4 = addfile(dir + "gdas1.fnl0p25.2017072906.f00.grib2","r")
f5 = addfile(dir + "gdas1.fnl0p25.2017072912.f00.grib2","r")
f6 = addfile(dir + "gdas1.fnl0p25.2017072918.f00.grib2","r")
f7 = addfile(dir + "gdas1.fnl0p25.2017073000.f00.grib2","r")
f8 = addfile(dir + "gdas1.fnl0p25.2017073006.f00.grib2","r")

g = 9.80665
g@units = "m/(s*s)"
p0 = (/300,350,400,450,500,550,600,650,700,750,800,850,900,925,950,975,1000/)
p0@units = "hPa"

;3D,1D is lv_ISBL0(pressure),length is 26,from 1000(0,10hPa) to 100000(25,100010hPa)
ps = f1->PRES_P0_L1_GLL0
ps = ps*0.01       ;2D
ps@units = "hPa"
u = f1->UGRD_P0_L100_GLL0(14:30,:,:)
v = f1->VGRD_P0_L100_GLL0(14:30,:,:)
Uw = f1->RH_P0_L100_GLL0(14:30,:,:)   ;a = f1->lv_ISBL4      ;21
T = f1->TMP_P0_L100_GLL0(14:30,:,:)   ;b = f1->lv_ISBL0      ;26
lat = f1->lat_0
lon = f1->lon_0

p = new((/17,721,1440/),"float")
do i = 0,720
p(:,i,:) = lat(i)
end do
do j = 0,1439
p(:,:,j) = lon(j)
end do
do k = 0,12
p(k,:,:) = 300 + k*50
end do
delete(k)
do k = 13,16
p(k,:,:) = 900 + (k-12)*25
end do

p!0 = "lv_ISBL0"
p!1 = "lat_0"
p!2 = "lon_0"

es= 6.1078*exp(17.2693882*(T-273.16)/(T-35.86))
q = 0.622*Uw*es/p

qu = u*q/g
qv = v*q/g

qu!0 = "lv_ISBL0"
qu!1 = "lat_0"
qu!2 = "lon_0"
qv!0 = "lv_ISBL0"
qv!1 = "lat_0"
qv12 = "lon_0"

dp = dpres_plevel(p0,ps,300,0)
;fint1 = dim_sum_n(qu*dp,0)/dim_sum_n(dp,0)
;fint2 = dim_sum_n(qv*dp,0)/dim_sum_n(dp,0)

Qu = dim_sum_n(qu*dp,0)*0.01
Qv = dim_sum_n(qv*dp,0)*0.01

res = True
res@vcMinFracLengthF = 0.33
res@vcRefMagnitudeF = 20.0
res@vcRefLengthF = 0.045
;res@vcFillArrowsOn = True
res@vcMonoLineArrowColor = False
res@vcFillArrowWidthF = 0.095
res@vcGlyphStyle = "CurlyVector"
res@vcLevelSelectionMode = "ManualLevels"
res@vcMaxLevelValF = 28.
res@vcMinLevelValF = 0.
res@vcLevelSpacingF = 2.

res@vfXCStartV = lon(0)
res@vfXCEndV = lon(dimsizes(lon)-1)
res@vfYCStartV = lat(0)
res@vfYCEndV = lat(dimsizes(lat)-1)

res@pmLabelBarDisplayMode = "Always"
;res@pmLabelBarWidthF = 0.1
res@lbPerimOn = False

res@mpFillOn = False
res@mpOutlineOn = True         ; Turn on map outlines
res@mpGridMaskMode = "MaskLand"  ; Don't draw grid over land.
res@mpGeophysicalLineColor =   "black"
res@mpOutlineOn = True         ; Tur

res@mpCenterLonF = 117.5
res@mpMinLonF = 100
res@mpMaxLonF = 135
res@mpMinLatF = 0
res@mpMaxLatF = 40

wks = gsn_open_wks("png","moisture")
plot = gsn_csm_vector_map(wks,Qu,Qv,res)
end
