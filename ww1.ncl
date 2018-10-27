begin
dir = "/root/data/data/data/data/"
;files = systemfunc("ls /root/share/data/data/data/gdas1*")    ;pressure from different times
;f = addfiles(files,"r")
;ListSetType(f, "join")
;;print(f)

 filepath = systemfunc("ls  " + dir + "gdas1*")
print(filepath)
 n = dimsizes(filepath)
print(n)
 do ie = 0,n-1
f1 = addfile(filepath(ie),"r")

u = f1->UGRD_P0_L100_GLL0
v = f1->VGRD_P0_L100_GLL0
;p = f1->lv_ISBL0                ;26
;p = (/1000,2000,3000,5000,7000,10000,15000,20000,25000,30000,35000,40000,\
;45000,50000,55000,60000,65000,70000,75000,80000,85000,90000,92500,95000,97500,100000/)
;pres = p*0.01
;pres@units = "hPa"
lat = f1->lat_0
lon = f1->lon_0
vor = (uv2vrG_Wrap(u,v))*1000    ; [lv_ISBL0 | 31] x [lat_0 | 181] x [lon_0 | 360]    10^(-5)

wks = gsn_open_wks("png","500hPa Vorticity"+ie)    ; send graphics to PNG file
 
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
plot = gsn_csm_contour_map(wks,vor(18,:,:),res) 
draw(plot)
frame(wks)
end do
end
