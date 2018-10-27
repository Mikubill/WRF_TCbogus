begin
;HAITANG,n = 33    1 is kz ,2 is others
x11= (/18.63,18.25,18,18.25,18.25,19.5,20.5,21.75/)
y11 = (/116,117,116.25,116.75,117.25,118.25,119.25,120.25/)

y12 = (/1179,1173,1167,1162,1157,1157,1163,1169,1175,1179,1182,1188,1194,1200,1203,1205,1205,1204,1198,1190,1182/)*0.1
x12 = (/192,194,195,192,186,180,181,184,188,190,192,196,201,209,217,221,232,243,252,262,272/)*0.1
;NESAT,n = 31
x21 = (/21.73,21.91,21.91,22.08,22.25,22.25,22.6,22.77,22.94,23.11,23.46,23.63,23.8,24.14,24.31,24.48,24.65,24.82,24.99,24.99,25.16,25.33,25.5,25.67,26.01,26.01,26.18,26.35,26.51,26.68,26.85,27.02,27.02,27.18,27.18/)
y21 = (/123.65,123.47,123.28,123.28,123.28,123.28,123.29,123.1,123.1,123.1,123.1,122.92,122.92,122.73,122.55,122.55,122.36,121.99,121.8,121.8,121.61,121.43,121.43,121.43,121.24,121.06,121.06,120.87,120.68,120.68,120.49,120.49,120.31,120.12,120.12/)

y22 = (/1255,1248,1243,1239,1236,1234,1233,1231,1228,1225,1218,1208,1203,1198,1193,1181,1175,1169,1166/)*0.1
x22 = (/194,200,205,210,214,217,221,225,229,234,239,247,247,251,254,257,261,258,254,248/)*0.1

wks = gsn_open_wks("pdf","NESAT")
;gsn_define_colormap(wks,"Rainbow")

res = True
res@gsnDraw = False
res@gsnFrame = False

res@mpCenterLonF = 120
res@mpMinLonF = 112
res@mpMaxLonF = 128
res@mpMinLatF = 14
res@mpMaxLatF = 30

res1 = True
res1@gsnDraw = False
res1@gsnFrame = False
res1@xyLineColors = 10
res1@xyLineThicknesses = 1.5
res1@xyMarkLineModes = ("MarkLines")
res1@xyMarkerColors = 2
res1@xyMarkers = 1
res1@xyMarkerSizeF = 0.005

res2 = True 
res2@gsnDraw = False
res2@gsnFrame = False
res2@xyLineColors = 240
res2@xyLineThicknesses = 1.
res2@xyMarkLineModes = ("MarkLines")
res2@xyMarkerColors =  220
res2@xyMarkers = 1
res2@xyMarkerSizeF = 0.005

res3 = True
res3@gsnDraw = False
res3@gsnFrame = False
res3@xyLineColors = 10
res3@xyLineThicknesses = 1.5
res3@xyMarkLineModes = ("MarkLines")
res3@xyMarkerColors = 2
res3@xyMarkers = 1
res3@xyMarkerSizeF = 0.005

res4 = True
res4@gsnDraw = False
res4@gsnFrame = False
res4@xyLineColors = 180
res4@xyLineThicknesses = 1
res4@xyMarkLineModes = ("MarkLines")
res4@xyMarkerColors = 200
res4@xyMarkers = 1
res4@xyMarkerSizeF = 0.005

map = gsn_csm_map(wks,res)
plot1 = gsn_xy(wks,y11,x11,res1)
plot2 = gsn_xy(wks,y12,x12,res2)
plot3 = gsn_xy(wks,y21,x21,res3)
plot4 = gsn_xy(wks,y22,x22,res4)
    
overlay(map,plot4)
overlay(map,plot2)
overlay(map,plot1) 
overlay(map,plot3)
draw(map)
frame(wks)
maximize_output(wks,True)
end

