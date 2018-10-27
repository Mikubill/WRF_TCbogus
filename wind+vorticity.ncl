begin
dir = "/mnt/g/NCL/data/nasha0.25/"
f1 = addfile(dir + "gdas1.fnl0p25.2017072812.f00.grib2","r")    ;pressure from different times
f2 = addfile(dir + "gdas1.fnl0p25.2017072818.f00.grib2","r")
f3 = addfile(dir + "gdas1.fnl0p25.2017072900.f00.grib2","r")
f4 = addfile(dir + "gdas1.fnl0p25.2017072906.f00.grib2","r")
f5 = addfile(dir + "gdas1.fnl0p25.2017072912.f00.grib2","r")
f6 = addfile(dir + "gdas1.fnl0p25.2017072918.f00.grib2","r")
f7 = addfile(dir + "gdas1.fnl0p25.2017073000.f00.grib2","r")
;3D,1D is lv_ISBL0(pressure),length is 26,from 1000(0,10hPa) to 100000(25,100010hPa)
u = f1->UGRD_P0_L100_GLL0(25,:,:)
v = f1->VGRD_P0_L100_GLL0(25,:,:)

res = True
res@vcMinFracLengthF = 0.33
res@vcRefMagnitudeF = 20.0
res@vcRefLengthF = 0.045
;res@vcFillArrowsOn = True
res@vcMonoLineArrowColor = False
res@vcFillArrowWidthF = 0.095
res@vcGlyphStyle ="CurlyVector"

;res@tiMainString = "moisture"
;res@tiXAxisString = "longitude"
;res@tiYAxisString = "lattitude"

res@pmLabelBarDisplayMode = "Always"
res@pmLabelBarWidthF = 0.1
res@lbPerimOn = False

res1 = True
res1@gsnDraw = False
res1@gsnFrame = False
res1@mpFillOn = False
res1@mpOutlineOn = True         ; Turn on map outlines
res1@mpGridMaskMode = "MaskLand"  ; Don't draw grid over land.
res1@mpGeophysicalLineColor =   "black"
res1@mpOutlineOn = True         ; Tur

res1@mpCenterLonF = 122.5
res1@mpMinLonF = 110
res1@mpMaxLonF = 135
res1@mpMinLatF = 10
res1@mpMaxLatF = 40
wks = gsn_open_wks("png","wind")
map = gsn_csm_map(wks,res1)
plot = gsn_vector(wks,u,v,res)
NhlAddOverlay(map,plot,map)
draw(map)
frame(wks)
end



















begin
dir_file = "/mnt/g/NCL/data/nasha/"
f1 = addfile(dir_file + "fnl_20170728_12_00.grib2","r")    ;pressure from different times
f2 = addfile(dir_file + "fnl_20170728_18_00.grib2","r")
f3 = addfile(dir_file + "fnl_20170729_00_00.grib2","r")
f4 = addfile(dir_file + "fnl_20170729_06_00.grib2","r")
f5 = addfile(dir_file + "fnl_20170729_12_00.grib2","r")

u = f1->UGRD_P0_L100_GLL0
v = f1->VGRD_P0_L100_GLL0
p = f1->lv_ISBL0                ;26
;p = (/1000,2000,3000,5000,7000,10000,15000,20000,25000,30000,35000,40000,\
;45000,50000,55000,60000,65000,70000,75000,80000,85000,90000,92500,95000,97500,100000/)
pres = p*0.01
pres@units = "hPa"
lat = f1->lat_0
lon = f1->lon_0
vor = uv2vrG_Wrap(u,v)    ; [lv_ISBL0 | 26] x [lat_0 | 181] x [lon_0 | 360]    10^(-5)
wks = gsn_open_wks("png","Vorticity")    ; send graphics to PNG file
 
res                      = True
res@gsnDraw              = False           ; don't draw
res@gsnFrame             = False           ; don't advance frame
res@cnFillOn             = True            ; turn on color
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
;res@cnLevelSpacingF      = 0.4

;res@gsnLeftString = "PV: NCL derived"
plot = gsn_csm_contour_map(wks,vor(25,:,:),res) 
draw(plot)
frame(wks)
end