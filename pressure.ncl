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
P = f1->PRES_P0_L1_GLL0
P0 = P*0.01
P0!0 = "lat"
P0!1 = "lon"
P0&lat = f1->lat_0
P0&lon = f1->lon_0
p0 = new((/721,1440/),"float")

do i = 0,720
do j = 0,1439
if(P0(i,j) .gt. 800) then
p0(i,j) = P0(i,j)
end if
end do
end do

res = True
res@sfXCStartV = min(P0&lon)
res@sfXCEndV = max(P0&lon)
res@sfYCStartV = max(P0&lat)
res@sfYCEndV = min(P0&lat)

res@pmLabelBarDisplayMode = "Always"
res@pmLabelBarWidthF = 0.1
res@lbPerimOn = False
res@gsnDraw = False
res@gsnFrame = False

res@mpCenterLonF = 122.5
res@mpMinLonF = 110
res@mpMaxLonF = 135
res@mpMinLatF = 10
res@mpMaxLatF = 40

;mpres@mpGridLonSpacingF = 100.
wks = gsn_open_wks("png","P0")
plot = gsn_csm_contour_map(wks,p0,res)
;map = gsn_csm_map(wks,mpres)
;plot = gsn_contour(wks,P0,res)
;NhlAddOverlay(map,plot,map)
;draw(map)
draw(plot)
frame(wks)
end
