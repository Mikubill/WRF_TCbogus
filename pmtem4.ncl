begin
dir = "/mnt/g/NCL/WRFOut/"
f1 = addfile(dir + "wrfout_d01_2017-07-28_12_00_00.nc","r")
f2 = addfile(dir + "wrfout_d01_2017-07-28_12__00_00.nc","r")  
do time=0,7
    ;time = 0
  lat = wrf_user_getvar(f1,"lat",time)
  lon = wrf_user_getvar(f1,"lon",time)
  theta_kz = wrf_user_getvar(f1,"th",time)
  theta_mg = wrf_user_getvar(f2,"th",time)
  p =  wrf_user_getvar(f1,"P",time)
  pb =  wrf_user_getvar(f1,"PB",time)
  p = p+pb
  theta = theta_kz - theta_mg

  ;plevel = (/1000.,2000.,3000.,5000.,7000.,10000.,15000.,20000.,25000.,30000.,35000.,40000.,45000.,50000.,55000.,60000.,65000.,70000.,75000.,80000.,85000.,90000.,92500.,95000.,97500.,100000./)
  
  itime = 0
  wks = gsn_open_wks("pdf","temd2912"+time) 
     setvalues NhlGetWorkspaceObjectId()
       "wsMaximumSize": 300000000
     end setvalues 

  ;aa = dimsizes(plevel)
  ;mm = dimsizes(lat)
  ;nn = dimsizes(lon)
 ;theta = new((/aa,60,73/),"float")

;do level = 0,aa-1
 ;   theta(level,:,:) = wrf_interp_3d_z(Theta,p,plevel(level))
;end do

  lat@units ="degrees_north"
  lon@units ="degrees_east"
  p@units ="Pa"
  p@long_name = "Pressure(hPa)"
  copy_VarAtts(theta_kz,theta)
  theta!2 ="lon"
  theta!1 ="lat"
  theta!0 ="plevel"
  theta&lat = lat(:,20)
  theta&lon = lon(30,:)
  theta&plevel = p(:,30,20)
  theta@long_name = "temperature departure"
  theta@units     = "K"
  ;copy_VarAtts(theta_kz,theta)
;************************************************
;;;;;;;;               ;;;;;;;;;;;;;;;;;;;;;;;;;;
;************************************
;29122    
  leftlat2  =  (/15.29,14.55,14.87,14.17,15.71,16.94,11.88,13.25/)
  rightlat2 =  (/23.82,25.23,29.51,26.39,28.1,27.78,29.22,27.25/)
  leftlon2  = (/109.58,110.91,112.63,114.29,116.9,118.6,109.06,109.74/)
  rightlon2 =  (/133.75,129.55,127.63,123.14,120.71,119.8,121.11,120/)
  npts     =  20            ; number of points in resulting transect
  dist     = gc_latlon(leftlat2(time),leftlon2(time),rightlat2(time),rightlon2(time),npts,2)
    nLabels      = 10 
    latXsecUser  = dist@gclat      ; convenience
    lonXsecUser  = dist@gclon
    N1           = npts-1
    XBValues    = toint( fspan(0,N1,nLabels) )
    XBLabels    = new(nLabels,"string")
    do i=0,nLabels-1
       x = lonXsecUser(XBValues(i))
       y = latXsecUser(XBValues(i))
       XBLabels(i) = sprintf("%5.1f", y)+"~C~"+sprintf("%5.1f", x)
    end do

  trans = linint2_points(theta&lon,theta&lat,theta,True,dist@gclon,dist@gclat,2)
  copy_VarAtts(theta,trans)
  trans!0      = "plevel"           ; create named dimension and assign
  trans&plevel   = theta&plevel  
  ;printVarSummary(level)

  res                   = True  
  res@gsnDraw = False
  res@gsnFrame = False                 ; plot mods desired
  res@cnFillOn          = True  
res@lbOrientation="Vertical"
       res@tmXBMode   = "Explicit"
       res@tmXBValues = XBValues
       res@tmXBLabels = XBLabels
;res@tiMainString = "temperature departure"
  res@lbLabelAutoStride = True                   ; nice label bar labels
  res@cnLinesOn         = True                  ; no contour lines
  res@gsnAddCyclic = False
  res@cnSmoothingOn               =True
  res@cnSmoothingDistanceF        =0.0005 
  res@cnLevelSelectionMode = "ManualLevels"       ; set manual contour levels
  ;res@cnMinLevelValF       = -4               ; set min contour level
  ;res@cnMaxLevelValF       =  11                  ; set max contour level
  ;res@cnLevelSpacingF      =  1                 ; set contour spacing
  res@cnFillPalette               = "GMT_polar"
    res@lbLabelOffsetF=-0.7
  plot =gsn_csm_pres_hgt(wks,trans,res)  
   draw(wks)
   frame(wks)
end do
end
