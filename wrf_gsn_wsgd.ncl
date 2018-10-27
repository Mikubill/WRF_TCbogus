begin
dir = "/mnt/g/NCL/data/nasha/"
f = addfile(dir + "wrf_kf.nc","r") 
p = f->P_HYD

time     = 0
ar       = wrf_user_getvar(f, "P_HYD", time)     ;the actual pressure
H        = wrf_user_getvar(f, "height", time)    ;height
ar_1     = wrf_interp_3d_z(H,ar,50000.)      ;point 500hPa

wks = gsn_open_wks("png","hgt30")
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
end
