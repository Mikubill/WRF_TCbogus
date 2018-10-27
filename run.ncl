begin
;f = addfile(dir + "wrfout_d02_2017-07-28_18_00_00.nc","r")  
f = addfile("wrfout_d01_2017-07-28_12:00:00","r")  

do time = 0,15,2
u_1        = wrf_user_getvar(f, "ua", time)     
v_1        = wrf_user_getvar(f, "va", time)  
r          = wrf_user_getvar(f, "QVAPOR", time)
q          = r/(r+1)
q!0 = "bottom_top"
q!1 = "south_north"
q!2 = "west_east"
q@units = "kg kg-1"
p  = wrf_user_getvar(f,"P",time)     
pb  = wrf_user_getvar(f,"PB",time)       ;the average pressure
p = p+pb
ps  = wrf_user_getvar(f,"PSFC",time)
g = 9.80665
g@units = "m s-2"

qu = u_1*q/g
qv = v_1*q/g

qu!0 = "bottom_top"
qu!1 = "south_north"
qu!2 = "west_east"
qv!0 = "bottom_top"
qv!1 = "south_north"
qv!2 = "west_east"

dp = dpres_plevel(p(:,0,0),ps,30000,0)

Qu = dim_sum_n(qu*dp,0)*0.01
Qv = dim_sum_n(qv*dp,0)*0.01

res                         = True      ; plot mods desired
res = wrf_map_resources(f,res)
res@gsnAddCyclic            = False       ; regional data: not cyclic         
res@tfDoNDCOverlay          = True ; set "NDCViewport" for native mapping
res@vcMinFracLengthF = 0.33
res@vcRefMagnitudeF = 20.0
res@vcRefLengthF = 0.045
;res@vcFillArrowsOn = True
res@vcMonoLineArrowColor = False
res@vcFillArrowWidthF = 0.095
res@vcGlyphStyle = "CurlyVector"
res@vcLevelSelectionMode = "ManualLevels"
res@vcMaxLevelValF = 28.
res@vcMinLevelValF = 0.
res@vcLevelSpacingF = 2.

res@pmLabelBarDisplayMode = "Always"
;res@pmLabelBarWidthF = 0.1
res@lbPerimOn = False

res@mpFillOn = False
res@mpOutlineOn = True         ; Turn on map outlines
res@mpGridMaskMode = "MaskLand"  ; Don't draw grid over land.
res@mpGeophysicalLineColor =   "black"
res@mpOutlineOn = True         ; Tur

res@mpCenterLonF = 117.5
res@mpMinLonF = 100
res@mpMaxLonF = 135
res@mpMinLatF = 0
res@mpMaxLatF = 40

wks = gsn_open_wks("pdf","moisture_d01_"+time)
plot = gsn_csm_vector_map(wks,Qu,Qv,res)

u = wrf_interp_3d_z(u_1,p,50000.)
v = wrf_interp_3d_z(v_1,p,50000.)

  wks1 = gsn_open_wks("pdf","vector_d01_"+time)               ; send graphics to PNG file
  cmap = read_colormap_file("BlAqGrYeOrReVi200")

  res                         = True      ; plot mods desired
  res = wrf_map_resources(f,res)
  res@gsnAddCyclic            = False       ; regional data: not cyclic         
  res@tfDoNDCOverlay          = True ; set "NDCViewport" for native mapping
 
  res@lbLabelStride           = 2         ; plot every other colar bar label
  res@vcRefMagnitudeF         = 1.5              ; make vectors larger
  res@vcRefLengthF            = 0.015            ; ref vec length
  res@vcMonoLineArrowColor    = False 
  res@vcMinDistanceF          = 0.007            ; thin out vectors
  res@vcLevelPalette          = cmap(3:150,:)
  res@pmLabelBarDisplayMode   = "Always"
  res@vcLevelSelectionMode = "ManualLevels"
  res@vcMaxLevelValF = 52.
  res@vcMinLevelValF = 0.
  res@vcLevelSpacingF = 2.
  res@mpCenterLonF = 122.5
  res@mpMinLonF = 110
  res@mpMaxLonF = 135
  res@mpMinLatF = 10
  res@mpMaxLatF = 30
   res@vcGlyphStyle            = "CurlyVector"    ; turn on curly vectors
  plot = gsn_csm_vector_map(wks1,u,v,res)  ; create plot

delete(Qu)
delete(Qv)
delete(u_1)
delete(v_1)
delete(r)
delete(p)
delete(ps)
delete(q)
delete(u)
delete(v)
delete(dp)
delete(pb)
delete(qu)
delete(qv)

end do

delete(f)

f = addfile("wrfout_d02_2017-07-28_12:00:00","r")  

do time = 0,15,2
u_1        = wrf_user_getvar(f, "ua", time)     
v_1        = wrf_user_getvar(f, "va", time)  
r          = wrf_user_getvar(f, "QVAPOR", time)
q          = r/(r+1)
q!0 = "bottom_top"
q!1 = "south_north"
q!2 = "west_east"
q@units = "kg kg-1"
p  = wrf_user_getvar(f,"P",time)     
pb  = wrf_user_getvar(f,"PB",time)       ;the average pressure
p = p+pb
ps  = wrf_user_getvar(f,"PSFC",time)
g = 9.80665
g@units = "m s-2"

qu = u_1*q/g
qv = v_1*q/g

qu!0 = "bottom_top"
qu!1 = "south_north"
qu!2 = "west_east"
qv!0 = "bottom_top"
qv!1 = "south_north"
qv!2 = "west_east"

dp = dpres_plevel(p(:,0,0),ps,30000,0)

Qu = dim_sum_n(qu*dp,0)*0.01
Qv = dim_sum_n(qv*dp,0)*0.01

res                         = True      ; plot mods desired
res = wrf_map_resources(f,res)
res@gsnAddCyclic            = False       ; regional data: not cyclic         
res@tfDoNDCOverlay          = True ; set "NDCViewport" for native mapping
res@vcMinFracLengthF = 0.33
res@vcRefMagnitudeF = 20.0
res@vcRefLengthF = 0.045
;res@vcFillArrowsOn = True
res@vcMonoLineArrowColor = False
res@vcFillArrowWidthF = 0.095
res@vcGlyphStyle = "CurlyVector"
res@vcLevelSelectionMode = "ManualLevels"
res@vcMaxLevelValF = 28.
res@vcMinLevelValF = 0.
res@vcLevelSpacingF = 2.

res@pmLabelBarDisplayMode = "Always"
;res@pmLabelBarWidthF = 0.1
res@lbPerimOn = False

res@mpFillOn = False
res@mpOutlineOn = True         ; Turn on map outlines
res@mpGridMaskMode = "MaskLand"  ; Don't draw grid over land.
res@mpGeophysicalLineColor =   "black"
res@mpOutlineOn = True         ; Tur

res@mpCenterLonF = 117.5
res@mpMinLonF = 100
res@mpMaxLonF = 135
res@mpMinLatF = 0
res@mpMaxLatF = 40

wks = gsn_open_wks("pdf","moisture_d02_"+time)
plot = gsn_csm_vector_map(wks,Qu,Qv,res)

u = wrf_interp_3d_z(u_1,p,50000.)
v = wrf_interp_3d_z(v_1,p,50000.)

  wks1 = gsn_open_wks("pdf","vector_d02_"+time)               ; send graphics to PNG file
  cmap = read_colormap_file("BlAqGrYeOrReVi200")

  res                         = True      ; plot mods desired
  res = wrf_map_resources(f,res)
  res@gsnAddCyclic            = False       ; regional data: not cyclic         
  res@tfDoNDCOverlay          = True ; set "NDCViewport" for native mapping
 
  res@lbLabelStride           = 2         ; plot every other colar bar label
  res@vcRefMagnitudeF         = 1.5              ; make vectors larger
  res@vcRefLengthF            = 0.015            ; ref vec length
  res@vcMonoLineArrowColor    = False 
  res@vcMinDistanceF          = 0.007            ; thin out vectors
  res@vcLevelPalette          = cmap(3:150,:)
  res@pmLabelBarDisplayMode   = "Always"
  res@vcLevelSelectionMode = "ManualLevels"
  res@vcMaxLevelValF = 52.
  res@vcMinLevelValF = 0.
  res@vcLevelSpacingF = 2.
  res@mpCenterLonF = 122.5
  res@mpMinLonF = 110
  res@mpMaxLonF = 135
  res@mpMinLatF = 10
  res@mpMaxLatF = 30
   res@vcGlyphStyle            = "CurlyVector"    ; turn on curly vectors
  plot = gsn_csm_vector_map(wks1,u,v,res)  ; create plot

delete(Qu)
delete(Qv)
delete(u_1)
delete(v_1)
delete(r)
delete(p)
delete(ps)
delete(q)
delete(u)
delete(v)
delete(dp)
delete(pb)
delete(qu)
delete(qv)
end do

end
