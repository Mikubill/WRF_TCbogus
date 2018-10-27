begin

  a = addfile("./auxinput1_d01_2017-07-28_12:00:00.nc","r")   ; Open a file

; a = addfile("met_em.d01.2017-07-28_12:00:00.nc","r")
; type = "x11"
 type = "pdf"
; type = "ps"
; type = "ncgm"
  wks = gsn_open_wks(type,"plt_geo_4")       ; Create a plot workstation


  opts = True                                ; Set some Basic Plot options
  opts@MainTitle = "GEOGRID FIELDS"

  ter = a->PMSL(0,:,:)                      ; Read the variable to memory

  res = opts                                 ; Use basic options for this field
  res@cnFillOn = True                        ; Create a color fill plot
  res@ContourParameters = (/ 99000., 101500., 100. /) 
  contour = wrf_contour(a,wks,ter,res)

  pltres = True                              ; Set plot options
  mpres = True                               ; Set map options
  plot = wrf_map_overlays(a,wks,(/contour/),pltres,mpres)  ; Plot the data over a map background

end
