begin
dir = "/root/share/data/data/data/"
;files = systemfunc("ls /root/share/data/data/data/gdas1*")    ;pressure from different times
;f = addfiles(files,"r")
;ListSetType(f, "join")
;;print(f)

 filepath = systemfunc("ls  " + dir + "gdas1*")
print(filepath)
 n = dimsizes(filepath)
print(n)
 do ie = 0,n-1
f = addfile(filepath(ie),"r")

u = f->UGRD_P0_L100_GLL0
v = f->VGRD_P0_L100_GLL0
p = f->lv_ISBL0     ;31
T = f->TMP_P0_L100_GLL0 
u = u(:,::-1,:)
v = v(:,::-1,:)
T = T(:,::-1,:)
lat = T&lat_0
PV = pot_vort_isobaric(p,u,v,T,lat,0,0)   ;500hPa is 18
PV = PV*1000000 
PV@units = "PUV"

wks = gsn_open_wks("png","Potential Vorticity30"+ie)    ; send graphics to PNG file
 
res                      = True
res@gsnDraw              = False           ; don't draw
res@gsnFrame             = False           ; don't advance frame
res@cnFillOn             = True            ; turn on color
res@cnFillPalette        = "CBR_wet"      ; set color map
res@cnLinesOn            = False
res@cnLineLabelsOn       = False
res@cnLevelSelectionMode = "ManualLevels"   
res@lbLabelBarOn         = True        ; turn off individual cb's
res@mpCenterLonF         = 120
res@mpMinLonF            = 112
res@mpMaxLonF            = 130
res@mpMinLatF            = 12
res@mpMaxLatF            = 30
res@cnLevelSpacingF      = 0.4

;res@gsnLeftString = "PV: NCL derived"
plot = gsn_csm_contour_map(wks,PV(18,:,:),res) 
draw(plot)
frame(wks)
end do
end
