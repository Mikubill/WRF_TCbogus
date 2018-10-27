;begin
;filename = "wrf_kf.nc"
;  f        = addfile(filename,"r")
begin
dir = "/mnt/g/NCL/data/nasha/"
f = addfile(dir + "wrf_kf.nc","r") 

  time     = 0
  ar       = wrf_user_getvar(f, "P_HYD", time)     ;the actual pressure
  H        = wrf_user_getvar(f, "height", time)    ;height
  ar_1     = wrf_interp_3d_z(H,ar,50000.)      ;point 500hPa
  ar_1@description = "Height"
  ar_1@units = "m"
  ar_1!0 = "south_north"
  ar_1!1 = "west_east"

mpres                      = True
mpres@gsnDraw              = True
mpres@gsnFrame             = True
mpres@cnLevelSpacingF      = 20
mpres@mpCenterLonF         = 122.5
mpres@mpMinLonF            = 110
mpres@mpMaxLonF            = 135
mpres@mpMinLatF            = 10
mpres@mpMaxLatF            = 30
mpres@mpGridMaskMode       = "MaskLand"  ; Don't draw grid over land.
mpres@gsnMaximize            = True
mpres@mpProjection         = "Lambert Conformal" 

;mpres@mpLeftCornerLatF     = 10
;mpres@mpRightCornerLatF    = 40
;mpres@mpLeftCornerLonF     = 110
;mpres@mpRightCornerLonF    = 135
mpres@mpGeophysicalLineColor = "Gray21"
xwks = gsn_open_wks("png","hgt30")
plot = gsn_csm_contour_map(xwks,ar_1,mpres)
;plot = wrf_contour(f,xwks,ar_1,res)
;map = wrf_map_resources(f,mpres)
;output = wrf_map_overlays(f,xwks,(/plot/),True,mpres)
end
