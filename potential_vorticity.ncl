begin
dir = "/mnt/g/NCL/data/nasha0.25/"
  filepath = systemfunc("ls " + dir +"gdas*")
do number = 0,7
  f1 = addfile(filepath(number),"r")

u = f1->UGRD_P0_L100_GLL0
v = f1->VGRD_P0_L100_GLL0
p = f1->lv_ISBL0     ;31
T = f1->TMP_P0_L100_GLL0 
u = u(:,::-1,:)
v = v(:,::-1,:)
T = T(:,::-1,:)
lat = T&lat_0
PV = pot_vort_isobaric(p,u,v,T,lat,0,0)   ;500hPa is 18
Pv = new((/721,1440/),"float")
Pv = PV(18,:,:)*1000000 
PV@units = "PVU"
pv = new((/721,1440/),"float")
wks = gsn_open_wks("pdf","Potential Vorticity fnl"+number)    ; send graphics to PNG file

do i = 0,720
do j = 0,1439
if(Pv(i,j) .gt. 0 .and. Pv(i,j) .lt. 16) then
pv(i,j) = Pv(i,j)
end if   
end do
end do

pv!0 = "lat_0"
pv!1 = "lon_0"
pv&lat_0 = f1->lat_0
pv&lon_0 = f1->lon_0

    cmap = (/                     \
            (/ 255./255, 255./255, 255./255 /),    \  ; 0 - White background.
            (/ 0./255  , 0./255  , 0./255   /),         \  ; 1 - Black foreground.
            (/ 255./255, 0./255  , 0./255   /),        \  ; 2 - Red.
            (/ 0./255  , 0./255  , 255./255 /),        \  ; 3 - Blue.
            (/ 164./255, 244./255, 131./255 /),      \  ; 4 - Ocean Blue.
            (/ 0./255  , 0./255  , 255./255   /),         \  ; 5 - Bar 1
         (/ 0./255  , 153./255, 255./255 /),      \  ; 6 - Bar 2
            (/ 0./255, 153./255, 153./255 /),        \  ; 7 - Bar 3 
            (/ 0./255  , 255./255, 0./255  /),       \  ; 8 - Bar 4   
            (/ 255./255, 255./255  , 102./255 /),        \  ; 9 - Bar 5 
            (/ 255./255, 153./255  , 102./255   /),        \  ; 10 - Bar 6
            (/ 255./255, 0./255  , 255./255   /)        \  ; 11 - Bar 7   
         /)
 
res                      = True
res@cnMinLevelValF       = -10
res@cnMaxLevelValF       = 18
res@sfXCStartV           = min(pv&lon_0)
res@sfXCEndV             = max(pv&lon_0)
res@sfYCStartV           = max(pv&lat_0)
res@sfYCEndV             = min(pv&lat_0)

res@gsnDraw              = False           ; don't draw
res@gsnFrame             = False           ; don't advance frame
res@cnFillOn             = True            ; turn on color         
;res@cnFillPalette        = "CBR_wet"      ; set color map
res@cnFillPalette        = "cmap"
res@cnLinesOn            = False
res@cnLineLabelsOn       = True
res@cnLevelSelectionMode = "ManualLevels"   
res@lbLabelBarOn         = True        ; turn off individual cb's
res@mpCenterLonF         = 122.5
res@mpMinLonF            = 110
res@mpMaxLonF            = 135
res@mpMinLatF            = 10
res@mpMaxLatF            = 40
res@cnLevelSpacingF      = 0.4

plot = gsn_csm_contour_map(wks,pv(:,:),res) 
draw(plot)
frame(wks)
end do
end