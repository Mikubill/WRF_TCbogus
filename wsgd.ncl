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

hgt = f->HGT_P0_L100_GLL0
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
mpres@mpMaxLatF = 30
cnres = True
cnres@cnLevelSpacingF = 20
xwks = gsn_open_wks("png","hgt30"+ie)
cn = gsn_csm_contour(xwks,hgt(18,:,:),cnres)
mp = gsn_csm_map(xwks,mpres)
NhlAddOverlay(mp,cn,mp)
draw(mp)
frame(xwks)
end do
end
