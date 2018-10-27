begin

  f = addfile(,"r")
  u = f->UGRD_P0_L100_GLL0(18,:,:);500hpa
  v = f->VGRD_P0_L100_GLL0(18,:,:)

  wks = gsn_open_wks("png","wind_8_"+ie)               ; send graphics to PNG file
  cmap = read_colormap_file("BlAqGrYeOrReVi200")
  vcres                         = True      ; plot mods desired
  vcres@lbLabelStride           = 2         ; plot every other colar bar label
  vcres@vcRefMagnitudeF         = 5.0              ; make vectors larger
  vcres@vcRefLengthF            = 0.050            ; ref vec length
  vcres@vcMonoLineArrowColor    = False 
  vcres@vcGlyphStyle            = "CurlyVector"    ; turn on curly vectors
  vcres@vcMinDistanceF          = 0.017            ; thin out vectors
  vcres@vcLevelPalette         = cmap(3:150,:)
  vcres@pmLabelBarDisplayMode   = "Always"
  vcres@mpCenterLonF = 122.5
  vcres@mpMinLonF = 110
  vcres@mpMaxLonF = 135
  vcres@mpMinLatF = 10
  vcres@mpMaxLatF = 30
  vcres@tiMainString            = "Vectors colored by a scalar map"
  plot = gsn_csm_vector(wks,u,v,vcres)  
end
