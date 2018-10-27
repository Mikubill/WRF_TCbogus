begin
dir = "/mnt/g/NCL/data/nasha0.25/"
f1 = addfile(dir + "gdas1.fnl0p25.2017072812.f00.grib2","r")    ;pressure from different times
f2 = addfile(dir + "gdas1.fnl0p25.2017072818.f00.grib2","r")
f3 = addfile(dir + "gdas1.fnl0p25.2017072900.f00.grib2","r")
f4 = addfile(dir + "gdas1.fnl0p25.2017072906.f00.grib2","r")
f5 = addfile(dir + "gdas1.fnl0p25.2017072912.f00.grib2","r")
f6 = addfile(dir + "gdas1.fnl0p25.2017072918.f00.grib2","r")
f7 = addfile(dir + "gdas1.fnl0p25.2017073000.f00.grib2","r")
hgt = f1->HGT_P0_L100_GLL0
mpres = True
mpres@gsnDraw = False
mpres@gsnFrame = False
;mpres@mpFillOn = False
;mpres@mpOutlineOn = True         ; Turn on map outlines
;mpres@mpGridMaskMode = "MaskLand"  ; Don't draw grid over land.
;mpres@mpGeophysicalLineColor =   "black"
;mpres@mpOutlineOn = True         ; Tur
;mpres@mpGridAndLimbDrawOrder = "Predraw"
mpres@mpCenterLonF = 122.5
mpres@mpMinLonF = 110
mpres@mpMaxLonF = 135
mpres@mpMinLatF = 10
mpres@mpMaxLatF = 40
cnres = True
cnres@cnLevelSpacingF = 20
xwks = gsn_open_wks("png","hgt")
cn = gsn_csm_contour(xwks,hgt(18,:,:),cnres)
mp = gsn_csm_map(xwks,mpres)
NhlAddOverlay(mp,cn,mp)
draw(mp)
frame(xwks)
end