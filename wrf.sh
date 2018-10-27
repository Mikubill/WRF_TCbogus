#!/bin/bash
wget https://x.example.domain/7a/715f771531a273db50a73b724432889bc66ee0.zip
unzip 715f771531a273db50a73b724432889bc66ee0.zip
wget http://www2.mmm.ucar.edu/wrf/OnLineTutorial/Graphics/NCL/Examples/LEVELS_MODEL/wrf_EtaLevels.ncl
mv wrf_EtaLevels.ncl output_data/
export NCARG_ROOT=`pwd`/ncl
cd output_data
mv wrfout_d01_2017-07-28_12:00:00 wrfout_d01_2017-07-28_12:00:00.nc
sed -i 's/..\/wrfout_d01_2000-01-24_12:00:00.nc/.\/wrfout_d01_2017-07-28_12:00:00.nc/g' wrf_EtaLevels.ncl  
sed -i 's/type = "x11"/;type = "x11"/g' wrf_EtaLevels.ncl  
sed -i 's/; type = "pdf"/type = "pdf"/g' wrf_EtaLevels.ncl
../ncl/bin/ncl wrf_EtaLevels.ncl
curl -F 'name=@plt_EtaLevels.pdf' https://x.example.domain
wget https://files.rki.moe/45/93bd71734f0731325271bbe5a964c172ed419b
mv 93bd71734f0731325271bbe5a964c172ed419b wind.ncl
../ncl/bin/ncl wind.ncl
curl -F 'name=@debugging_wind_8_.pdf' https://x.example.domain