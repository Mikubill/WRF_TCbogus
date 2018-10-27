begin
  filepath = systemfunc("ls auxinput*")
  f = addfile(filepath(0),"r")
  type = "png"
  wks = gsn_open_wks(type,"plt_geo_4")       ; Create a plot workstation
  wks1 = gsn_open_wks(type,"hgt30_4")
  wks2 = gsn_open_wks(type,"wind_4")

  opts = True                                ; Set some Basic Plot options
  opts@MainTitle = "GEOGRID FIELDS"
  cmap = read_colormap_file("BlAqGrYeOrReVi200")

  ter = f->PMSL(0,:,:)                      ; Read the variable to memory
  ar = f->GHT(0,13,:,:)
  u= f->UU(0,0,1:60,1:72)   
  v = f->VV(0,0,1:60,1:72)
  
  res = opts                                 ; Use basic options for this field
  res@cnFillOn = True                        ; Create a color fill plot
  res@ContourParameters = (/ 96000., 105000., 250. /) 
  res1 = opts                                 ; Use basic options for this field
  res1@cnFillOn = True                        ; Create a color fill plot
  res1@ContourParameters = (/ 5700., 6100., 10. /) 
  vcres                         = True      ; plot mods desired
  vcres@lbLabelStride           = 2         ; plot every other colar bar label
  vcres@vcRefMagnitudeF         = 5.0              ; make vectors larger
  vcres@vcRefLengthF            = 0.050            ; ref vec length
  vcres@vcMonoLineArrowColor    = False 
  vcres@vcGlyphStyle            = "CurlyVector"    ; turn on curly vectors
  vcres@vcMinDistanceF          = 0.017            ; thin out vectors
  vcres@vcLevelPalette         = cmap(3:150,:)
  vcres@pmLabelBarDisplayMode   = "Always"
  vcres@tiMainString            = "Vectors colored by a scalar map"


  contour = wrf_contour(f,wks,ter,res)
  contour1 = wrf_contour(f,wks1,ar,res1)
  
  pltres = True                              ; Set plot options
  mpres = True                               ; Set map options
  plot = wrf_overlays(f,wks,(/contour/),pltres)
  plot = wrf_overlays(f,wks1,(/contour1/),pltres)
  plot = gsn_csm_vector(wks2,u,v,vcres)  ; create plot
  
end
