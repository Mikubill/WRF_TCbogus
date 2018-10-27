begin

f=addfile("wrfout_d01_2017-07-28_12:00:00.nc","r") 

temmean=new((/21/), "float")

do time=0,7
    
  lat = wrf_user_getvar(f,"lat",time)
  lon = wrf_user_getvar(f,"lon",time)
  plevel = (/10000.,15000.,20000.,25000.,30000.,35000.,40000.,45000.,50000.,55000.,60000.,65000.,70000.,75000.,80000.,85000.,90000.,92500.,95000.,97500.,100000./)
  aa = dimsizes(plevel)
  mm = dimsizes(lat)
  print(mm)
  nn = dimsizes(lon)
  itime = 0
  wks = gsn_open_wks("pdf","temd2912") 
     setvalues NhlGetWorkspaceObjectId()
       "wsMaximumSize": 300000000
     end setvalues 
  ;i=0  v=f->VGRD_P0_L100_GLL0(time,:,:,:)
  ;(level,420:540,)
tem = wrf_user_getvar(f,"T",time)

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
;29122
leftlat2  =  15.82
  rightlat2 =  28.13
  leftlon2  = 115
  rightlon2 =  125
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
