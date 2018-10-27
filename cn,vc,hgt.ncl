begin
dir_file = "/mnt/g/NCL/data/nasha/"
f = addfile(dir_file + "fnl_20170728_12_00.grib2","r")
p = f->lv_ISBL0
rh = f->RH_P0_L100_GLL0(25,:,:)
u = f->UGRD_P0_L100_GLL0(25,:,:)
v = f->VGRD_P0_L100_GLL0(25,:,:)
hgt = f->HGT_P0_L100_GLL0(25,:,:)
RH = new((/181,360/),"float")

do i = 0,180
do j = 0,359
if(rh(i,j) .gt. 60.) Then
RH(i,j) = rh(i,j)
end if
end do
end do

vcres = True
vcres@vcMinFracLengthF = 0.33
vcres@vcRefMagnitudeF = 20.0
vcres@vcRefLengthF = 0.02
vcres@vcMonoLineArrowColor = True
vcres@vcFillArrowWidthF = 0.075
vcres@vcGlyphStyle = "CurlyVector"
vcres@lbLabelAutoStride    = True

cnres                      = True
cnres@sfXCStartV           = min(rh&lon_0)
cnres@sfXCEndV             = max(rh&lon_0)
cnres@sfYCStartV           = max(rh&lat_0)
cnres@sfYCEndV             = min(rh&lat_0)
cnres@gsnDraw              = False           ; don't draw
cnres@gsnFrame             = False           ; don't advance frame
cnres@cnFillOn             = True            ; turn on color   
cnres@cnFillDrawOrder      = "Predraw"    
cnres@cnFillPalette        = "WhiteBlue"      ; set color map
cnres@cnLinesOn            = False
cnres@cnLineLabelsOn       = True
cnres@cnLevelSelectionMode = "ManualLevels"   
cnres@lbLabelBarOn         = True        ; turn off individual cb's
cnres@cnInfoLabelOn        = False
cnres@cnFillOpacityF       = 0.9
cnres@lbBoxEndCapStyle     = "TriangleBothEnds"
cnres@cnInfoLabelSide      = "Right"
cnres@trGridType           = "TriangularMesh"
cnres@cnMissingValFillColor = 0 
cnres@lbLabelAutoStride    = True

mpres = True
mpres@mpFillOn = False
mpres@mpOutlineOn = True         ; Turn on map outlines
;res@mpGridMaskMode = "MaskLand"  ; Don't draw grid over land.
mpres@mpGeophysicalLineColor =   "black"
mpres@mpOutlineOn = True         ; Tur
mpres@mpCenterLonF = 117.5
mpres@mpMinLonF = 100
mpres@mpMaxLonF = 135
mpres@mpMinLatF = 0
mpres@mpMaxLatF = 40

wks = gsn_open_wks("png","850 hPa situation")
map = gsn_csm_map(wks,mpres)
plotvc = gsn_csm_vector(wks,u,v,vcres)
plotrh = gsn_csm_contour(wks,RH,cnres)
plothgt = gsn_csm_contour(wks,hgt,False)

overlay(map,plotrh)
overlay(map,plothgt)
overlay(map,plotvc)
draw(map)
frame(wks)
maximize_output(wks,True)

end
