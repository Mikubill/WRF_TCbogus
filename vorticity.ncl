begin
dir = "/mnt/g/NCL/data/nasha0.25/"
f1 = addfile(dir + "gdas1.fnl0p25.2017072812.f00.grib2","r")    ;pressure from different times
f2 = addfile(dir + "gdas1.fnl0p25.2017072818.f00.grib2","r")
f3 = addfile(dir + "gdas1.fnl0p25.2017072900.f00.grib2","r")
f4 = addfile(dir + "gdas1.fnl0p25.2017072906.f00.grib2","r")
f5 = addfile(dir + "gdas1.fnl0p25.2017072912.f00.grib2","r")
f6 = addfile(dir + "gdas1.fnl0p25.2017072918.f00.grib2","r")
f7 = addfile(dir + "gdas1.fnl0p25.2017073000.f00.grib2","r")

u = f1->UGRD_P0_L100_GLL0
v = f1->VGRD_P0_L100_GLL0

vor = (uv2dvF_Wrap(u,v))*100000    ; [lv_ISBL0 | 31] x [lat_0 | 181] x [lon_0 | 360]    10^(-5)
vor!0 = "lv_ISBL0"
vor!1 = "lat_0"
vor!2 = "lon_0"
vor&lat_0 = f1->lat_0
vor&lon_0 = f1->lon_0

wks = gsn_open_wks("png","500hPa Vorticity")    ; send graphics to PNG file
 
res                      = True
res@gsnDraw              = False           ; don't draw
res@gsnFrame             = False           ; don't advance frame
res@cnMinLevelValF       = -24
res@cnMaxLevelValF       = 36
res@cnFillOn             = True            ; turn on color
res@sfXCStartV           = min(vor&lon_0)
res@sfXCEndV             = max(vor&lon_0)
res@sfYCStartV           = max(vor&lat_0)
res@sfYCEndV             = min(vor&lat_0)
res@cnFillPalette        = "CBR_wet"      ; set color map
res@cnLinesOn            = False
res@cnLineLabelsOn       = False
res@cnLevelSelectionMode = "ManualLevels"   
res@lbLabelBarOn         = True        ; turn off individual cb's
res@mpCenterLonF         = 122.5
res@mpMinLonF            = 110
res@mpMaxLonF            = 135
res@mpMinLatF            = 10
res@mpMaxLatF            = 40
res@cnLevelSpacingF     = 5

plot = gsn_csm_contour_map(wks,vor(18,:,:),res) 
draw(plot)
frame(wks)
end


;下边的还没完成
dimz = dimsizes(vor)
klev = dimz(0)           ;26
nlat = dimz(1)           ;181
mlon = dimz(2)           ;360
;pres!0 ="pres"
;vor!1 = "pres"
;vor&lv_ISBL0 = "pres"
;ml4 = mlon/4              ;arbitrary

wks = gsn_open_wks("png", "vorticity")  

resx = True
resx@cnFillOn = True
resx@cnLinesOn = False
resx@cnLineLabelsOn = False
resx@cnFillPalette = "ncl_default"

nLabels = 8	         ;arbitrary
resx@tmXBLabels = new(nLabels,"string")
resx@tmXBMode = "Explicit"

;**************************************************
; Draw Full cross section at a specified blue grid line
;**************************************************

resx@tmXBValues:= toint(fspan(0,nlat-1,nLabels))
do i = 0,nLabels-1
    x = lon(resx@tmXBValues(i),90)
    y = lat(resx@tmXBValues(i),90)
    resx@tmXBLabels(i) = sprintf("%5.1f", y)+"~C~"+sprintf("%5.1f",x)
end do
   
resx@tiMainString = "vorticity"
plot = gsn_csm_pres_hgt(wks,vor(:,:,90),resx) 
end
