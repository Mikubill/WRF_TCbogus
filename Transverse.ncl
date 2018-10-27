;************************************
; trans_1.ncl
;************************************
;
; Concepts illustrated:
;   - Calculating and plotting a transect
;   - Using gc_latlon to calculate a great circle path
;   - Using linint2_points to interpolate rectilinear grid values to set of lat/lon points
;   - Attaching polylines to a map plot
;   - Explicitly setting tickmarks and labels on the bottom X axis
;************************************
; These files are loaded by default in NCL V6.2.0 and newer
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
;************************************
;begin
 ; in = addfile("h_avg_Y0191_D000.00.nc","r")
  ;t  = in->T(0,:,:,:)
;************************************
; calculate great circle along transect
;************************************

begin
dir_file = "/mnt/g/NCL/data/nasha/"
f1 = addfile(dir_file + "fnl_20170728_12_00.grib2","r")    ;pressure from different times
f2 = addfile(dir_file + "fnl_20170728_18_00.grib2","r")
f3 = addfile(dir_file + "fnl_20170729_00_00.grib2","r")
f4 = addfile(dir_file + "fnl_20170729_06_00.grib2","r")
f5 = addfile(dir_file + "fnl_20170729_12_00.grib2","r")
dir = "/mnt/g/NCL/data/Goni/"
f = addfile(dir + "fnl_20090808_12_00.grib2","r")
u = f->UGRD_P0_L100_GLL0
v = f->VGRD_P0_L100_GLL0
p = f->lv_ISBL0                ;26
;p = (/1000,2000,3000,5000,7000,10000,15000,20000,25000,30000,35000,40000,\
;45000,50000,55000,60000,65000,70000,75000,80000,85000,90000,92500,95000,97500,100000/)
pres = p*0.01
pres@units = "hPa"
lat = f->lat_0
lon = f->lon_0
vor = uv2vrG_Wrap(u,v)    ; [lv_ISBL0 | 26] x [lat_0 | 181] x [lon_0 | 360]    10^(-5)


  leftlat  =  15.0
  rightlat =  30.0

  leftlon  =  110.0
  rightlon =   130.0

  npts     =   100                    ; number of points in resulting transect

  dist     = gc_latlon(leftlat,leftlon,rightlat,rightlon,npts,2)
  points   = ispan(0,npts-1,1)*1.0 
;********************************
; interpolate data to great circle
;********************************
  trans   = linint2_points(vor&lon_0,vor&lat_0,vor,True,dist@gclon,dist@gclat,2)    ;\\\\\\wrong
  copy_VarAtts(vor,trans)          ; copy attributes

  trans!0      = "pres"           ; create named dimension and assign
  ;trans&z_t    = t&z_t           ; coordinate variable for 0th dimension only
;********************************
; create plot
;********************************
  wks = gsn_open_wks("png","trans")       ; send graphics to PNG file

  res                     = True          ; plot mods desired
  res@tmXBMode            = "Explicit"    ; explicitly label x-axis
  res@tmXBValues          = (/points(0),points(npts-1)/) ; points to label
; label values
  res@tmXBLabels          = (/leftlat +", "+leftlon,rightlat+", "+rightlon/)

  res@cnFillOn            = True         ; turn on color
  res@cnFillPalette       = "BlAqGrYeOrReVi200"  ; set color map
  res@cnLinesOn           = False        ; turn off countour lines
  res@lbOrientation       = "vertical"   ; vertical label bar
  res@pmLabelBarOrthogonalPosF = -0.05        ; move label bar closer to plot
 
  res@tiMainString        = "Transect"   ; add title
  res@tiXAxisString       = "lat/lon along transect"
  res@trYReverse          = True         ; reverse y axis
;  res@trXReverse          = True         ; reverse x axis (neg longitudes)
  ;res@cnLevelSpacingF     = 1.0          ; set contour spacing
  
  plot = gsn_csm_contour(wks,trans,res)  ; create plot
;********************************
; show transect on a map
;********************************
  mres              = True                ; plot mods desired
  mres@gsnFrame     = False               ; don't turn page yet
  mres@gsnDraw      = False               ; don't draw yet
  mres@tiMainString = "Transect Location" ; title
  map = gsn_csm_map(wks,mres)         ; create map

; add polyline to map
  pres                  = True           ; polyline mods desired
  pres@gsLineColor      = "red"          ; color of lines
  pres@gsLineThicknessF = 2.0            ; line thickness   
  id = gsn_add_polyline(wks,map,(/leftlon,rightlon/),(/leftlat,rightlat/),pres)
  draw(map)    ; draws map and polyline
  frame(wks)
end