begin
dir = "/mnt/g/NCL/data/leijijiangshui/"
f = addfile(dir + "gdas1.fnl0p25.2017073000.f06.grib2","r") 
PWAT = f->PWAT_P0_L200_GLL0
T = f->TMP_P0_L104_GLL0 
Lv = 0.25
pwat = Lv*PWAT
pwat@units = "10^7*J/m2"

res = True
res@gsnDraw = False
res@gsnFrame = False
res@cnLevelSelectionMode = "ManualLevels"
res@cnMaxLevelValF       = 24.
res@cnMinLevelValF       = 0.
res@cnLevelSpacingF = 2.
res@cnFillOn             = True            ; turn on color   
res@cnFillPalette        = "WhiteBlue"      ; set color map
res@sfXCStartV           = min(PWAT&lon_0)
res@sfXCEndV             = max(PWAT&lon_0)
res@sfYCStartV           = max(PWAT&lat_0)
res@sfYCEndV             = min(PWAT&lat_0)
res@mpCenterLonF = 122.5
res@mpMinLonF = 110
res@mpMaxLonF = 135
res@mpMinLatF = 10
res@mpMaxLatF = 40
wks = gsn_open_wks("png","Precipitable water")
plot = gsn_csm_contour_map(wks,pwat,res)
;plot = gsn_csm_contour_map(wks,PWAT,res)
draw(plot)
frame(wks)
end
