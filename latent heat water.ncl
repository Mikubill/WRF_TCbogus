begin
dir = "/mnt/g/NCL/data/leijijiangshui/"
f = addfile(dir + "gdas1.fnl0p25.2017072812.f06.grib2","r") 
T = f->TMP_P0_L100_GLL0(18,:,:)                     ;temperature
lt = latent_heat_water(T,(/1,0/),1,False)    ;calculate latent heat
;lt@units = "10^5*J/Kg"
res = True
res@gsnDraw = False
res@gsnFrame = False
res@cnMinLevelValF       = 248000
res@cnMaxLevelValF       = 251000
res@sfXCStartV           = min(lt&lon_0)
res@sfXCEndV             = max(lt&lon_0)
res@sfYCStartV           = max(lt&lat_0)
res@sfYCEndV             = min(lt&lat_0)
res@mpCenterLonF = 122.5
res@mpMinLonF = 110
res@mpMaxLonF = 135
res@mpMinLatF = 10
res@mpMaxLatF = 40
res@cnLevelSpacingF = 0.1
wks = gsn_open_wks("png","latent_heat_water")
cn = gsn_csm_contour_map(wks,lt/100000,res)
draw(cn)
frame(wks)
end
