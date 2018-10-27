begin
dir="ziliao/"
f=addfile(dir+"gdas1.fnl0p25.2017072812.f00.grib2","r") 
temmean=new((/21/), "float")
  lat     =f->lat_0
  lat=-lat              ; coordinates
  lon     =f->lon_0
  p       =f->lv_ISBL0
  aa=dimsizes(p)
  mm=dimsizes(lat)
  print(mm)
  nn=dimsizes(lon)
  itime=0
  wks  = gsn_open_wks("png","temd2017072812") 
     setvalues NhlGetWorkspaceObjectId()
       "wsMaximumSize": 300000000
     end setvalues 
  ;i=0  v=f->VGRD_P0_L100_GLL0(time,:,:,:)
  ;(level,420:540,)
tem=f->TMP_P0_L100_GLL0(:,:,:)
do level = 10, 30
  tem2=tem(level,400:480,420:540)
  temmean(level-10)=avg(tem2)
  print(temmean(level-10))
  tem(level,:,:)=tem(level,:,:)-temmean(level-10)
end do
  mn=(/21,mm,nn/)
  t=new(mn,"float")
  t(0:20,:,:)=tem(10:30,720:0,:)
  lat@units="degrees_north"
  lon@units="degrees_east"
  p@units="Pa"
  t!2="lon"
  t!1="lat"
  t!0="p"
  t&lat=lat
  t&lon=lon 
  t&p=p(10:30)
  t@long_name = "temperature departure"
  t@units     = "K"
;************************************************
;;;;;;;;开始沿着副中心到台风中心差值;;;;;;;;;;;;;;;;;;;;;;;;;;
;************************************
leftlon2=112.97
rightlon2=128.54
leftlat2=16.78
rightlat2=23.13
  npts     =  20            ; number of points in resulting transect
  dist     = gc_latlon(leftlat2,leftlon2,rightlat2,rightlon2,npts,2)
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
res@tiMainString = "temperature departure"
  res@lbLabelAutoStride = True                   ; nice label bar labels
  res@cnLinesOn         = True                  ; no contour lines
  res@gsnAddCyclic = False
  res@cnSmoothingOn               =True
  res@cnSmoothingDistanceF        =0.0005 
  res@cnLevelSelectionMode = "ManualLevels"       ; set manual contour levels
  res@cnMinLevelValF       = -4               ; set min contour level
  res@cnMaxLevelValF       =  11                  ; set max contour level
  res@cnLevelSpacingF      =  1                 ; set contour spacing
  res@cnFillPalette               = "GMT_polar"
    res@lbLabelOffsetF=-0.7
  plot =gsn_csm_pres_hgt(wks,trans,res)  
   draw(wks)
   frame(wks)
end
