begin
filename = "gd.bin"
f        = addfile(filename,"r")
do i=0,7;kaishixunhuan
time     = i
ar1       = wrf_user_getvar(f, "PB", time)     ;the actual pressure
ar2       = wrf_user_getvar(f, "P", time)
ar=ar1+ar2
H1        = wrf_user_getvar(f, "PHB", time)    ;height
H2        = wrf_user_getvar(f, "PH", time)    ;height
H        = wrf_user_getvar(f, "geopt", time)    ;height
H_1=H/9.81
;ar_1     = wrf_interp_3d_z(H_1,ar,50000.)      ;point 500hPa
ar_1     = wrf_user_intrp3d(H_1(:,:,:),ar(:,:,:),"h",50000.,time,False)
wks = gsn_open_wks("png","hgt30"+i)
res                       = True        ; plot mods desired
res@gsnMaximize           = True        ; maximize plot size
res@cnLineThicknessF      = 1.0         ; make twice as thick as default
res@cnInfoLabelOrthogonalPosF = 0.1     ; move contour info label down
res = wrf_map_resources(f,res)
res@gsnAddCyclic          = False       ; regional data: not cyclic         
res@tfDoNDCOverlay        = True ; set "NDCViewport" for native mapping
                                          ; will result in faster plotting
;res@tfDoNDCOverlay        = True      ; old method
plot = gsn_csm_contour_map(wks,ar_1,res)
delete(ar_1)
end do;xunhaunjieshu
end

