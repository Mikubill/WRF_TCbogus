begin
dir = "/mnt/g/NCL/data/nasha0.25/"
f1 = addfile(dir + "gdas1.fnl0p25.2017072812.f00.grib2","r")    ;pressure from different times
f2 = addfile(dir + "gdas1.fnl0p25.2017072818.f00.grib2","r")
f3 = addfile(dir + "gdas1.fnl0p25.2017072900.f00.grib2","r")
f4 = addfile(dir + "gdas1.fnl0p25.2017072906.f00.grib2","r")
f5 = addfile(dir + "gdas1.fnl0p25.2017072912.f00.grib2","r")
f6 = addfile(dir + "gdas1.fnl0p25.2017072918.f00.grib2","r")
f7 = addfile(dir + "gdas1.fnl0p25.2017073000.f00.grib2","r")

;u1 = f1->UGRD_P0_L100_GLL0(18,264:296,480:508)     ;read V
;v1 = f1->VGRD_P0_L100_GLL0(18,264:296,480:508)
;u2 = f2->UGRD_P0_L100_GLL0(18,264:296,480:512)    
;v2 = f2->VGRD_P0_L100_GLL0(18,264:296,480:512)
;u3 = f3->UGRD_P0_L100_GLL0(18,256:292,484:512)    
;v3 = f3->VGRD_P0_L100_GLL0(18,256:292,484:512)
;u4 = f4->UGRD_P0_L100_GLL0(18,256:272,488:596)    
;v4 = f4->VGRD_P0_L100_GLL0(18,256:272,488:596)
;u5 = f5->UGRD_P0_L100_GLL0(18,246:276,470:500)    
;v5 = f5->VGRD_P0_L100_GLL0(18,246:276,470:500)
;u6 = f6->UGRD_P0_L100_GLL0(18,236:268,472:500)    
;v6 = f6->VGRD_P0_L100_GLL0(18,236:268,472:500)
;u7 = f7->UGRD_P0_L100_GLL0(18,250:268,472:496)    
;v7 = f7->VGRD_P0_L100_GLL0(18,250:268,472:496)
u1 = f1->UGRD_P0_L100_GLL0(18,275:290,455:485)     ;read V
v1 = f1->VGRD_P0_L100_GLL0(18,275:290,455:485)
u2 = f2->UGRD_P0_L100_GLL0(18,275:290,455:485)    
v2 = f2->VGRD_P0_L100_GLL0(18,275:290,455:485)
u3 = f3->UGRD_P0_L100_GLL0(18,275:290,455:485)    
v3 = f3->VGRD_P0_L100_GLL0(18,275:290,455:485)
u4 = f4->UGRD_P0_L100_GLL0(18,275:290,455:485)    
v4 = f4->VGRD_P0_L100_GLL0(18,275:290,455:485)
u5 = f5->UGRD_P0_L100_GLL0(18,275:290,455:485)    
v5 = f5->VGRD_P0_L100_GLL0(18,275:290,455:485)
u6 = f6->UGRD_P0_L100_GLL0(18,275:290,455:485)    
v6 = f6->VGRD_P0_L100_GLL0(18,275:290,455:485)
u7 = f7->UGRD_P0_L100_GLL0(18,275:290,455:485)    
v7 = f7->VGRD_P0_L100_GLL0(18,275:290,455:485)

vor1 = uv2vrG_Wrap(u1,v1)         ;calculate vorticity
vor2 = uv2vrG_Wrap(u2,v2)
vor3 = uv2vrG_Wrap(u3,v3)
vor4 = uv2vrG_Wrap(u4,v4)
vor5 = uv2vrG_Wrap(u5,v5)
vor6 = uv2vrG_Wrap(u6,v6)
vor7 = uv2vrG_Wrap(u7,v7)

;x = (/2812,2818,2900,2906,2912,2918,3000/)
x = (/1,2,3,4,5,6,7/)
;y = (/(/vor1(2,1),vor2(27,18),vor3(31,5),vor4(1,39),vor5(10,2),vor6(12,1),vor7(7,12)/)/)*1000000
y = (/(/vor1(10,8),vor2(12,8),vor3(12,10),vor4(10,13),vor5(9,15),vor6(7,18),vor7(4,23)/)/)*1000000

x@long_name = "date"
y@long_name = "vorticy"

wks = gsn_open_wks("png","vorticy_time")
res = True
res@xyLineColor = 2
res@xyMarkLineModes = "MarkLines"
res@xyMarkers = 1
res@xyMarkerSizeF = 0.03
plot = gsn_xy(wks,x,y,res)
;pict = gsn_add_polyline(wks,plot,x,y,res)
end