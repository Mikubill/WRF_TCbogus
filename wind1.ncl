begin
	;;;;;mdzz
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 	;f1 = addfile("ziliao/gdas1.fnl0p25.2017073006.f00.grib2","r")
	;var
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
	u = f->UGRD_P0_L100_GLL0(18,:,:);500hpa
	v = f->VGRD_P0_L100_GLL0(18,:,:)
;;---Create plot
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
  ;vcres@vcLevelPalette          = "cosam"
  vcres@pmLabelBarDisplayMode   = "Always"
  vcres@mpCenterLonF = 122.5
  vcres@mpMinLonF = 110
  vcres@mpMaxLonF = 135
  vcres@mpMinLatF = 10
  vcres@mpMaxLatF = 30
  vcres@tiMainString            = "Vectors colored by a scalar map"
  plot = gsn_csm_vector_map(wks,u,v,vcres)  ; create plot
end do
end
