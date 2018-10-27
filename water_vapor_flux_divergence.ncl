begin
dir = "/mnt/g/NCL/data/nasha/"
f = addfile(dir + "wrfout_d02.nc","r") 

;do time = 0,8
time = 0

g = 9.80665
g@units = "m/(s*s)"

u = wrf_user_getvar(f,"ua",time) 
v = wrf_user_getvar(f,"va",time)   
H = wrf_user_getvar(f,"height",time) 

r = f->QVAPOR(time,:,:,:)  
q = r/(r+1)       ;kg/kg
qu = u*q
qv = v*q
qu!0 = "bottom_top"
qu!1 = "south_north"
qu!2 = "west_east"
qv!0 = "bottom_top"
qv!1 = "south_north"
qv!2 = "west_east"
Qu = wrf_interp_3d_z(qu,H,750.)
Qv = wrf_interp_3d_z(qv,H,750.)
lat = Qu(:,0)
lon = Qu(0,:)

F = -(uv2dv_cfd(Qu,Qv,lat,lon,2))*10^7/g 
F!0 = "south_north"
F!1 = "west_east"    
F = smth9_Wrap(F,0.5,0.25,True)

;end do

wks = gsn_open_wks("png","Moisture Dispersion"+time)
res                       = True        ; plot mods desired
res@gsnMaximize           = True        ; maximize plot size
res@cnLineThicknessF      = 1.0         ; make twice as thick as default
res@cnInfoLabelOrthogonalPosF = 0.1     ; move contour info label down
res@cnMinLevelValF        = -32.
res@cnMaxLevelValF        = 32.
res@cnLevelSpacingF       = 2.

vcres = True
;vcres@gsnAddCyclic         = False       ; regional data: not cyclic         
vcres@tfDoNDCOverlay       = True ; set "NDCViewport" for native mapping
vcres@vcMinFracLengthF = 0.33
vcres@vcRefMagnitudeF = 20.0
vcres@vcRefLengthF = 0.045
vcres@vcMonoLineArrowColor = True
vcres@vcFillArrowWidthF = 0.095
vcres@vcGlyphStyle = "CurlyVector"

res = wrf_map_resources(f,res)
res@gsnAddCyclic         = False       ; regional data: not cyclic         
res@tfDoNDCOverlay       = True ; set "NDCViewport" for native mapping
res@gsnDraw              = False           ; don't draw
res@gsnFrame             = False           ; don't advance frame
res@cnFillOn             = True            ; turn on color   
res@cnFillDrawOrder      = "Predraw"    
res@cnFillPalette        = "WhiteBlue"      ; set color map
res@cnLinesOn            = False
res@cnLineLabelsOn       = True
res@cnLevelSelectionMode = "ManualLevels"   
res@lbLabelBarOn         = True        ; turn off individual cb's
res@cnInfoLabelOn        = False
res@cnFillOpacityF       = 0.9
res@lbBoxEndCapStyle     = "TriangleBothEnds"
res@cnInfoLabelSide      = "Right"
res@trGridType           = "TriangularMesh"
res@cnMissingValFillColor = 0 
res@lbLabelAutoStride    = True
res@cnRasterSmoothingOn  = True

plotcn = gsn_csm_contour_map(wks,F,res)
plotvc = wrf_vector(f,wks,Qu,Qv,vcres)
overlay(plotcn,plotvc)
draw(plotcn)
frame(wks)

maximize_output(wks,True)

end
