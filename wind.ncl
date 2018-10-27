begin

;;;;;mdzz

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;dir = "/root/data/data/"
dir = "/mnt/g/NCL/data/nasha0.25/"
f1 = addfile(dir + "gdas1.fnl0p25.2017072812.f00.grib2","r")    ;pressure from different times
f2 = addfile(dir + "gdas1.fnl0p25.2017072818.f00.grib2","r")
f3 = addfile(dir + "gdas1.fnl0p25.2017072900.f00.grib2","r")
f4 = addfile(dir + "gdas1.fnl0p25.2017072906.f00.grib2","r")
f5 = addfile(dir + "gdas1.fnl0p25.2017072912.f00.grib2","r")
f6 = addfile(dir + "gdas1.fnl0p25.2017072918.f00.grib2","r")
f7 = addfile(dir + "gdas1.fnl0p25.2017073000.f00.grib2","r")
f8 = addfile(dir + "gdas1.fnl0p25.2017073006.f00.grib2","r")

;var
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

u = f2->UGRD_P0_L100_GLL0(18,:,:)
v = f2->VGRD_P0_L100_GLL0(18,:,:)

;;---Create plot
  wks = gsn_open_wks("png","vector")               ; send graphics to PNG file

  cmap = read_colormap_file("BlAqGrYeOrReVi200")

  vcres                         = True      ; plot mods desired
  vcres@lbLabelStride           = 2         ; plot every other colar bar label
  vcres@vcRefMagnitudeF         = 5.0              ; make vectors larger
  vcres@vcRefLengthF            = 0.050            ; ref vec length
  vcres@vcMonoLineArrowColor    = False 
  vcres@vcGlyphStyle            = "CurlyVector"    ; turn on curly vectors
  vcres@vcMinDistanceF          = 0.017            ; thin out vectors
  vcres@vcLevelPalette         = cmap(3:150,:)
  ;vcres@vcLevelPalette          = "cosam"
  res@vcLevelSelectionMode = "ManualLevels"
  res@vcMaxLevelValF = 44.
  res@vcMinLevelValF = 0.
  vcres@pmLabelBarDisplayMode   = "Always"
  vcres@mpCenterLonF = 122.5
  vcres@mpMinLonF = 110
  vcres@mpMaxLonF = 135
  vcres@mpMinLatF = 10
  vcres@mpMaxLatF = 30
  ;vcres@lbLabelConstantSpacingF = 5

  vcres@tiMainString            = "Vectors colored by a scalar map"

  plot = gsn_csm_vector_map(wks,U,V,vcres)  ; create plot
end