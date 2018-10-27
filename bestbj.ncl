begin
;dir = "./"
;filename="met_em.d01.2017-07-28_12_00_00.nc.orig"
dir = "/root/sync"
;files = systemfunc("ls /root/share/data/data/data/gdas1*")    ;pressure from different times
;f = addfiles(files,"r")
;ListSetType(f, "join")
;;print(f)

 filepath = systemfunc("ls  " + dir + "/met*")
print(filepath)
 n = dimsizes(filepath)
print(n)

loc=new((/2/), "float")
loc1=new((/2/), "float")
loc2=new((/2/), "float")
opt=True
opt@MAP_PROJ=1
opt@TRUELAT1=0.0
opt@TRUELAT2=10.0
opt@STAND_LON=120.0
opt@REF_LON=119.00
opt@REF_LAT=22.00
opt@KNOWNJ=37.0
opt@KNOWNI=30.5
opt@DX=60000
opt@DY=60000
do i = 0,6
    f = addfile(filepath(i),"r")
    print(filepath(i))
    minlon = 110
    maxlon = 119
    minlat = 10
    maxlat = 21
    exe_1=wrf_user_ll_to_ij(f,maxlon,maxlat,opt)
    exe_2=wrf_user_ll_to_ij(f,minlon,minlat,opt)
    exe1=wrf_user_ij_to_ll(f,exe_1(0),exe_1(1),opt)
    exe2=wrf_user_ij_to_ll(f,exe_2(0),exe_2(1),opt)
    time=0
    slp = f->PMSL(time,:,:)
    u_1       = f->UU(time,0,exe_2(1):exe_1(1),exe_2(0)+1:exe_1(0)+1)   ;lat,lon;+1 because of zuobiao
    v_1       = f->VV(time,0,exe_2(1)+1:exe_1(1)+1,exe_2(0):exe_1(0))
    pre_2     = slp(exe_2(1):exe_1(1),exe_2(0):exe_1(0))
    pre_1     = pre_2*0.01
    pre_1@units = "hPa"
    V_1 = sqrt(u_1*u_1+v_1*v_1)
    V=max(V_1)
    pre=min(pre_1)
    V_2=ndtooned(V_1)  
    c1=maxind(V_2)
    d=mod(c1,(exe_1(0)-exe_2(0)+1));j的位置jingdu
    e=(c1-d)/(exe_1(0)-exe_2(0)+1);i的位置weidu
    loc1 = wrf_user_ij_to_ll(f,exe_2(0)+d+1,exe_2(1)+e+1,True) 
    delete(d)
    delete(e)
    delete(V_2)
    pre_3=ndtooned(pre_1)  
    c2=minind(pre_3)
    d=mod(c2,(exe_1(0)-exe_2(0)+1))
    e=(c2-d)/(exe_1(0)-exe_2(0)+1)
    loc2 = wrf_user_ij_to_ll(f,exe_2(0)+d+1,exe_2(1)+e+1,True)
    dstc=gc_latlon(loc1(1), loc1(0), loc2(1), loc2(0), 2, 4)
    delete(d)
    delete(e)
    delete(pre_3)
    delete(exe_1)
    print(loc1)
    print(loc2)
    print(V)
    print(pre)
    print(dstc)
    delete(slp)
    delete(u_1)
    delete(v_1)
    delete(pre_2)
    delete(pre_1)
    delete(V_1)
    delete(V)
end do
do i=7,11
    f = addfile(filepath(i),"r")
    print(filepath(i))
    minlon = 110
    maxlon = 121
    minlat = 10
    maxlat = 22
    exe_1=wrf_user_ll_to_ij(f,maxlon,maxlat,opt)
    exe_2=wrf_user_ll_to_ij(f,minlon,minlat,opt)
    exe1=wrf_user_ij_to_ll(f,exe_1(0),exe_1(1),opt)
    exe2=wrf_user_ij_to_ll(f,exe_2(0),exe_2(1),opt)
    time=0
    slp = f->PMSL(time,:,:)
    u_1       = f->UU(time,0,exe_2(1):exe_1(1),exe_2(0)+1:exe_1(0)+1)   ;lat,lon;+1 because of zuobiao
    v_1       = f->VV(time,0,exe_2(1)+1:exe_1(1)+1,exe_2(0):exe_1(0))
    pre_2     = slp(exe_2(1):exe_1(1),exe_2(0):exe_1(0))
    pre_1     = pre_2*0.01
    pre_1@units = "hPa"
    V_1 = sqrt(u_1*u_1+v_1*v_1)
    V=max(V_1)
    pre=min(pre_1)
    V_2=ndtooned(V_1)  
    c1=maxind(V_2)
    d=mod(c1,(exe_1(0)-exe_2(0)+1));j的位置jingdu
    e=(c1-d)/(exe_1(0)-exe_2(0)+1);i的位置weidu
    loc1 = wrf_user_ij_to_ll(f,exe_2(0)+d+1,exe_2(1)+e+1,True) 
    delete(d)
    delete(e)
    delete(V_2)
    pre_3=ndtooned(pre_1)  
    c2=minind(pre_3)
    d=mod(c2,(exe_1(0)-exe_2(0)+1))
    e=(c2-d)/(exe_1(0)-exe_2(0)+1)
    loc2 = wrf_user_ij_to_ll(f,exe_2(0)+d+1,exe_2(1)+e+1,True)
    dstc=gc_latlon(loc1(1), loc1(0), loc2(1), loc2(0), 2, 4)
    delete(d)
    delete(e)
    delete(pre_3)
    delete(exe_2)
    delete(exe1)
    delete(exe2)
    print(loc1)
    print(loc2)
    print(V)
    print(pre)
    print(dstc)

    delete(slp)
    delete(u_1)
    delete(v_1)
    delete(pre_2)
    delete(pre_1)
    delete(V_1)
    delete(V)
end do
do i = 12,14
    f = addfile(filepath(i),"r")
    print(filepath(i))
    minlon = 110
    maxlon = 124
    minlat = 10
    maxlat = 23
    exe_1=wrf_user_ll_to_ij(f,maxlon,maxlat,opt)
    exe_2=wrf_user_ll_to_ij(f,minlon,minlat,opt)
    exe1=wrf_user_ij_to_ll(f,exe_1(0),exe_1(1),opt)
    exe2=wrf_user_ij_to_ll(f,exe_2(0),exe_2(1),opt)
    time=0
    slp = f->PMSL(time,:,:)
    u_1       = f->UU(time,0,exe_2(1):exe_1(1),exe_2(0)+1:exe_1(0)+1)   ;lat,lon;+1 because of zuobiao
    v_1       = f->VV(time,0,exe_2(1)+1:exe_1(1)+1,exe_2(0):exe_1(0))
    pre_2     = slp(exe_2(1):exe_1(1),exe_2(0):exe_1(0))
    pre_1     = pre_2*0.01
    pre_1@units = "hPa"
    V_1 = sqrt(u_1*u_1+v_1*v_1)
    V=max(V_1)
    pre=min(pre_1)
    V_2=ndtooned(V_1)  
    c1=maxind(V_2)
    d=mod(c1,(exe_1(0)-exe_2(0)+1));j的位置jingdu
    e=(c1-d)/(exe_1(0)-exe_2(0)+1);i的位置weidu
    loc1 = wrf_user_ij_to_ll(f,exe_2(0)+d+1,exe_2(1)+e+1,True) 
    delete(d)
    delete(e)
    delete(V_2)
    pre_3=ndtooned(pre_1)  
    c2=minind(pre_3)
    d=mod(c2,(exe_1(0)-exe_2(0)+1))
    e=(c2-d)/(exe_1(0)-exe_2(0)+1)
    loc2 = wrf_user_ij_to_ll(f,exe_2(0)+d+1,exe_2(1)+e+1,True)
    dstc=gc_latlon(loc1(1), loc1(0), loc2(1), loc2(0), 2, 4)
    delete(d)
    delete(e)
    delete(pre_3)
    print(loc1)
    print(loc2)
    print(V)
    print(pre)
    print(dstc)
    delete(slp)
    delete(u_1)
    delete(v_1)
    delete(pre_2)
    delete(pre_1)
    delete(V_1)
    delete(V)
end do
end
