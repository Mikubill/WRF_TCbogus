begin
dir = "/mnt/g/NCL/WRFOut/"
f = addfile(dir + "wrfout_d01_2017-07-28_12_00_00.nc","r")  

do time = 0,15,2
;time     = 0

u_1       = wrf_user_getvar(f, "ua", time)     
v_1       = wrf_user_getvar(f, "va", time)    
p  = wrf_user_getvar(f,"P",time)     
pb  = wrf_user_getvar(f,"PB",time)       ;the average pressure
p = p+pb
u = wrf_interp_3d_z(u_1,p,50000.)
v = wrf_interp_3d_z(v_1,p,50000.)

;var
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;---Create plot
  wks = gsn_open_wks("png","vector"+time)               ; send graphics to PNG file
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
  plot = gsn_csm_vector_map(wks,u,v,res)  ; create plot
end do
end
