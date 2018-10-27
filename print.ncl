begin

; f = addfile("./auxinput1_d01_2017-07-28_18:00:00.nc","r")   ; Open a file

filepath = systemfunc("ls auxinput*")
f = addfile(filepath(0),"r")
; f = addfile("met_em.d01.2017-07-29_00_00_00.nc","r")
; type = "x11"
 type = "pdf"
; type = "ps"
; type = "ncgm"
  wks = gsn_open_wks(type,"plt_geo_4")       ; Create a plot workstation
  wks1 = gsn_open_wks(type,"hgt30_4")


  opts = True                                ; Set some Basic Plot options
  opts@MainTitle = "GEOGRID FIELDS"

  ter = f->PMSL(0,:,:)                      ; Read the variable to memory
  ar = f->GHT(0,13,:,:)

  res = opts                                 ; Use basic options for this field
  res@cnFillOn = True                        ; Create a color fill plot
  res@ContourParameters = (/ 96000., 105000., 250. /) 
  res1 = opts                                 ; Use basic options for this field
  res1@cnFillOn = True                        ; Create a color fill plot
  res1@ContourParameters = (/ 5700., 6100., 10. /) 


  contour = wrf_contour(f,wks,ter,res)
  contour1 = wrf_contour(f,wks1,ar,res1)

  pltres = True                              ; Set plot options
  mpres = True                               ; Set map options
  plot = wrf_overlays(f,wks,(/contour/),pltres)
  plot = wrf_overlays(f,wks1,(/contour1/),pltres)
  ;plot = wrf_map_overlays(a,wks,(/contour/),pltres,mpres)  ; Plot the data over a map background

end
