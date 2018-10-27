begin
dir="ziliao/"
f=addfile(dir+"gdas1.fnl0p25.2017072912.f00.grib2","r") 
  lat     =f->lat_0
  lat=-lat              ; coordinates
  lon     =f->lon_0
  p       =f->lv_ISBL0
  aa=dimsizes(p)
  mm=dimsizes(lat)
  print(mm)
  nn=dimsizes(lon)
  itime=0
  wks  = gsn_open_wks("pdf","pmwind2912") 
     setvalues NhlGetWorkspaceObjectId()
       "wsMaximumSize": 300000000
     end setvalues 
  ;i=0
  u=f->UGRD_P0_L100_GLL0(:,:,:)
  v=f->VGRD_P0_L100_GLL0(:,:,:)
  scale = 1.e05                                  
  vor   = u                                      ; retain coordinates
;  vor   = uv2vrG_Wrap(u,v) * scale
  vor   = sqrt(u*u+v*v)
  mn=(/21,mm,nn/)
  t=new(mn,"float")
  t(0:20,:,:)=vor(10:30,720:0,:)
  lat@units="degrees_north"
  lon@units="degrees_east"
  p@units="Pa"
  t!2="lon"
  t!1="lat"
  t!0="p"
  t&lat=lat
  t&lon=lon 
  t&p=p(10:30)
  t@long_name = "wind speed"
  t@units     = "m/s-1"
;************************************************
;;;;;;;;开始沿着副中心到台风中心差值;;;;;;;;;;;;;;;;;;;;;;;;;;
;************************************

;3000

;jingdu=4
;weidu=jingdu*(rightlat1-leftlat1)/(rightlon1-leftlon1)
;weidu=4
;jingdu=weidu*(rightlon1-leftlon1)/(rightlat1-leftlat1)
;30062
;29122
leftlat2  =  15.82
  rightlat2 =  28.13
  leftlon2  = 115
  rightlon2 =  125
  npts     =  20            ; number of points in resulting transect
  dist     = gc_latlon(leftlat2,leftlon2,rightlat2,rightlon2,npts,2)
    NPTS         =20                ; (d) user specified number of points
    ptsXsec      = gc_latlon(leftlat2,leftlon2,rightlat2,rightlon2,NPTS,2)
    nLabels      = 10 
    latXsecUser  = ptsXsec@gclat      ; convenience
    lonXsecUser  = ptsXsec@gclon
    N1           = NPTS-1
    XBValues    = toint( fspan(0,N1,nLabels) )
    XBLabels    = new(nLabels,"string")
    do i=0,nLabels-1
       x = lonXsecUser(XBValues(i))
       y = latXsecUser(XBValues(i))
       XBLabels(i) = sprintf("%5.1f", y)+"~C~"+sprintf("%5.1f", x)
    end do
;********************************
; interpolate data to great circle
;********************************
  trans   = linint2_points(t&lon,t&lat,t,True,dist@gclon,dist@gclat,2)
  copy_VarAtts(t,trans)
  trans!0      = "p"           ; create named dimension and assign
  trans&p   = t&p(0:20)   
  printVarSummary(p)
  res                   = True  
  res@gsnDraw = False
  res@gsnFrame = False                 ; plot mods desired
  res@cnFillOn          = True  
res@lbOrientation="Vertical"
       res@tmXBMode   = "Explicit"
       res@tmXBValues = XBValues
       res@tmXBLabels = XBLabels
;res@tiMainString = "chuzhipoumian fengsu"
  res@lbLabelAutoStride = True                   ; nice label bar labels
  res@cnLinesOn         = True                  ; no contour lines
  res@gsnAddCyclic = False
  res@cnSmoothingOn               =True
  res@cnSmoothingDistanceF        =0.0005 
  res@cnLevelSelectionMode = "ManualLevels"       ; set manual contour levels
  res@cnMinLevelValF       = 2               ; set min contour level
  res@cnMaxLevelValF       =  48                  ; set max contour level
  res@cnLevelSpacingF      =  4                 ; set contour spacing
  res@cnFillPalette               = "GMT_polar"
    res@lbLabelOffsetF=-0.7
  plot =gsn_csm_pres_hgt(wks,trans,res)  
   draw(wks)
   frame(wks)
end


