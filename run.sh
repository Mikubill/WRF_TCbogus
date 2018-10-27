#!/bin/bash
mkdir run
mkdir output
mkdir output1
mkdir output_2
mkdir output1_2
cp print.ncl run/
touch output.html
echo '<head><meta name="viewport" content="width=device-width,initial-scale=1"><meta charset="utf-8"/>' >>output.html
echo '<link rel="stylesheet" href="//cdnjs.loli.net/ajax/libs/mdui/0.4.1/css/mdui.min.css">' >>output.html
echo '</head><body><div class="mdui-container mdui-typo"><div class="container mdui-col-xs-6">' >>output.html
export NCARG_ROOT=`pwd`/ncl
for i in '28' '29' '30'
do
    for j in '00' '06' '12' '18' 
    do
        echo "$i-$j"
        if [ ! -f "namelist-$i$j-remove-1.input" ]; then
            echo "Not Found $i-$j."
        else
            cd run
            echo "---${i}-${j}-1-1-NESAT-REMOVE-"
            echo "<div><h1>---${i}-${j}-1-1-NESAT-REMOVE-</h1></div><br ><pre>" >> ../output.html
            cp ../namelist-${i}${j}-remove-1.input namelist.input
            cp ../met_em.d01.2017-07-${i}_${j}_00_00.nc met_em.d01.2017-07-${i}_${j}\:00\:00.nc
            cp ../tc.exe tc.exe 
            ./tc.exe | grep -E 'TC: Processing|Storm|Estimated central|nstrm|Bogus storm' >> ../output.html
            echo "</pre>">> ../output.html
            #.././ncl/bin/ncl print.ncl 
            #curl -F 'name=@hgt30_4.png' https://x.example.domain/ >> ../output.html
            #curl -F 'name=@plt_geo_4.png' https://x.example.domain/ >> ../output.html
            rm namelist.input

            echo "---${i}-${j}-1-2-HAITANG-REMOVE-"
            echo "<div><h1>---${i}-${j}-1-2-HAITANG-REMOVE-</h1></div><br ><pre>" >> ../output.html
            cp ../namelist-${i}${j}-remove-2.input namelist.input
            ./tc.exe | grep -E 'TC: Processing|Storm|Estimated central|nstrm|Bogus storm' >> ../output.html
            echo "</pre>">> ../output.html
            #.././ncl/bin/ncl print.ncl 
            #curl -F 'name=@hgt30_4.png' https://x.example.domain/ >> ../output.html
            #curl -F 'name=@plt_geo_4.png' https://x.example.domain/ >> ../output.html
            curl -F 'name=@wind_4.png' https://x.example.domain/ >> ../output.html

            echo "---${i}-${j}-1-3-BOTH-REMOVE-"
            echo "<div><h1>---${i}-${j}-1-3-BOTH-REMOVE-</h1></div><br ><pre>" >> ../output.html      
            cp ../met_em.d01.2017-07-${i}_${j}_00_00.nc met_em.d01.2017-07-${i}_${j}\:00\:00.nc      
            cp ../namelist-${i}${j}-remove-1.input namelist.input
            ./tc.exe | grep -E 'TC: Processing|Storm|Estimated central|nstrm|Bogus storm' >> ../output.html
            mv auxinput1_d01_2017-07-${i}_${j}\:00\:00.nc met_em.d01.2017-07-${i}_${j}\:00\:00.nc
            cp ../namelist-${i}${j}-remove-2.input namelist.input
            ./tc.exe | grep -E 'TC: Processing|Storm|Estimated central|nstrm|Bogus storm' >> ../output.html
            echo "</pre>">> ../output.html
            #.././ncl/bin/ncl print.ncl 
            #curl -F 'name=@hgt30_4.png' https://x.example.domain/ >> ../output.html
            #curl -F 'name=@plt_geo_4.png' https://x.example.domain/ >> ../output.html
            #curl -F 'name=@wind_4.png' https://x.example.domain/ >> ../output.html
            cp aux* ../output1

            echo "---${i}-${j}-1-4-INSERT-"
            echo "<div><h1>---${i}-${j}-1-4-INSERT-</h1></div><br ><pre>" >> ../output.html
            cp ../namelist-${i}${j}-insert-1.input namelist.input
            cp auxinput1_d01_2017-07-${i}_${j}\:00\:00.nc aux_bak
            mv auxinput1_d01_2017-07-${i}_${j}\:00\:00.nc met_em.d01.2017-07-${i}_${j}\:00\:00.nc
            ./tc.exe | grep -E 'TC: Processing|Storm|Estimated central|nstrm|Bogus storm' >> ../output.html
            echo "</pre>">> ../output.html
            .././ncl/bin/ncl print.ncl 
            curl -F 'name=@hgt30_4.png' https://x.example.domain/ >> ../output.html
            curl -F 'name=@plt_geo_4.png' https://x.example.domain/ >> ../output.html
            curl -F 'name=@wind_4.png' https://x.example.domain/ >> ../output.html
            cp aux* ../output/
            rm -f met* aux* namelist.input hgt30_4.pdf plt_geo_4.pdf 

            echo "---${i}-${j}-2-1-NESAT-REMOVE- "
            echo "<div><h1>---${i}-${j}-2-1-NESAT-REMOVE-</h1></div><br ><pre>" >> ../output.html
            cp ../namelist-${i}${j}-remove-1.input namelist.input
            cp ../met_em.d02.2017-07-${i}_${j}_00_00.nc met_em.d01.2017-07-${i}_${j}\:00\:00.nc
            cp ../tc.exe tc.exe 
            sed -i 's/e_we = 74,/e_we = /g' namelist.input
            sed -i 's/e_sn = 61,/e_sn = /g' namelist.input
            sed -i 's/dx = 60000,/dx = /g' namelist.input
            sed -i 's/dy = 60000,/dy = /g' namelist.input
            cat namelist.input
            ./tc.exe | grep -E 'TC: Processing|Storm|Estimated central|nstrm|Bogus storm' >> ../output.html
            echo "</pre>">> ../output.html
            #.././ncl/bin/ncl print.ncl 
            #curl -F 'name=@hgt30_4.png' https://x.example.domain/ >> ../output.html
            #curl -F 'name=@plt_geo_4.png' https://x.example.domain/ >> ../output.html
            #curl -F 'name=@wind_4.png' https://x.example.domain/ >> ../output.html
            rm namelist.input

            echo "---${i}-${j}-2-2-HAITANG-REMOVE-" 
            echo "<div><h1>---${i}-${j}-2-2-HAITANG-REMOVE-</h1></div><br ><pre>" >> ../output.html
            cp ../namelist-${i}${j}-remove-2.input namelist.input
            sed -i 's/e_we = 74,/e_we = /g' namelist.input
            sed -i 's/e_sn = 61,/e_sn = /g' namelist.input
            sed -i 's/dx = 60000,/dx = /g' namelist.input
            sed -i 's/dy = 60000,/dy = /g' namelist.input
            cat namelist.input
            ./tc.exe | grep -E 'TC: Processing|Storm|Estimated central|nstrm|Bogus storm' >> ../output.html
            echo "</pre>">> ../output.html
            #.././ncl/bin/ncl print.ncl 
            #curl -F 'name=@hgt30_4.png' https://x.example.domain/ >> ../output.html
            #curl -F 'name=@plt_geo_4.png' https://x.example.domain/ >> ../output.html
            #curl -F 'name=@wind_4.png' https://x.example.domain/ >> ../output.html

            echo "---${i}-${j}-2-3-BOTH-REMOVE-"
            echo "<div><h1>---${i}-${j}-2-3-BOTH-REMOVE-</h1></div><br ><pre>" >> ../output.html      
            cp ../met_em.d02.2017-07-${i}_${j}_00_00.nc met_em.d01.2017-07-${i}_${j}\:00\:00.nc      
            cp ../namelist-${i}${j}-remove-1.input namelist.input
            sed -i 's/e_we = 74,/e_we = /g' namelist.input
            sed -i 's/e_sn = 61,/e_sn = /g' namelist.input
            sed -i 's/dx = 60000,/dx = /g' namelist.input
            sed -i 's/dy = 60000,/dy = /g' namelist.input
            cat namelist.input
            ./tc.exe | grep -E 'TC: Processing|Storm|Estimated central|nstrm|Bogus storm' >> ../output.html
            mv auxinput1_d01_2017-07-${i}_${j}\:00\:00.nc met_em.d01.2017-07-${i}_${j}\:00\:00.nc
            cp ../namelist-${i}${j}-remove-2.input namelist.input
            sed -i 's/e_we = 74,/e_we = /g' namelist.input
            sed -i 's/e_sn = 61,/e_sn = /g' namelist.input
            sed -i 's/dx = 60000,/dx = /g' namelist.input
            sed -i 's/dy = 60000,/dy = /g' namelist.input
            cat namelist.input
            ./tc.exe | grep -E 'TC: Processing|Storm|Estimated central|nstrm|Bogus storm' >> ../output.html
            echo "</pre>">> ../output.html
            #.././ncl/bin/ncl print.ncl 
            #curl -F 'name=@hgt30_4.png' https://x.example.domain/ >> ../output.html
            #curl -F 'name=@plt_geo_4.png' https://x.example.domain/ >> ../output.html
            #curl -F 'name=@wind_4.png' https://x.example.domain/ >> ../output.html
            cp aux* ../output1_2/

            echo "---${i}-${j}-2-4-INSERT-"
            echo "<div><h1>---${i}-${j}-2-4-INSERT-</h1></div><br ><pre>" >> ../output.html
            cp ../namelist-${i}${j}-insert-1.input namelist.input
            sed -i 's/e_we = 74,/e_we = /g' namelist.input
            sed -i 's/e_sn = 61,/e_sn = /g' namelist.input
            sed -i 's/dx = 60000,/dx = /g' namelist.input
            sed -i 's/dy = 60000,/dy = /g' namelist.input
            cat namelist.input
            cp auxinput1_d01_2017-07-${i}_${j}\:00\:00.nc aux_bak
            mv auxinput1_d01_2017-07-${i}_${j}\:00\:00.nc met_em.d01.2017-07-${i}_${j}\:00\:00.nc
            ./tc.exe | grep -E 'TC: Processing|Storm|Estimated central|nstrm|Bogus storm' >> ../output.html
            echo "</pre>">> ../output.html
            .././ncl/bin/ncl print.ncl 
            curl -F 'name=@hgt30_4.png' https://x.example.domain/ >> ../output.html
            curl -F 'name=@plt_geo_4.png' https://x.example.domain/ >> ../output.html
            curl -F 'name=@wind_4.png' https://x.example.domain/ >> ../output.html


            #echo "<div><h1>---${i}-${j}--5-HAITANG-INSERT-</h1></div><br ><pre>" >> ../output.html
            #cp ../namelist-${i}${j}-insert-2.input namelist.input
            #cp aux_bak met_em.d01.2017-07-${i}_${j}\:00\:00.nc
            #./tc.exe | grep -E 'TC: Processing|Storm|Estimated central|nstrm|Bogus storm' >> ../output.html
            #echo "</pre>">> ../output.html
            #.././ncl/bin/ncl print.ncl 
            #curl -F 'name=@hgt30_4.png' https://x.example.domain/ >> ../output.html
            #curl -F 'name=@plt_geo_4.png' https://x.example.domain/ >> ../output.html

            #echo "<div><h1>---${i}-${j}--6-BOTH-INSERT-</h1></div><br ><pre>" >> ../output.html
            #cp ../namelist-${i}${j}-insert-1.input namelist.input
            #cp aux_bak met_em.d01.2017-07-${i}_${j}\:00\:00.nc
            #./tc.exe | grep -E 'TC: Processing|Storm|Estimated central|nstrm|Bogus storm' >> ../output.html
            #mv auxinput1_d01_2017-07-${i}_${j}\:00\:00.nc met_em.d01.2017-07-${i}_${j}\:00\:00.nc
            #cp ../namelist-${i}${j}-insert-2.input namelist.input
            #./tc.exe | grep -E 'TC: Processing|Storm|Estimated central|nstrm|Bogus storm' >> ../output.html
            #echo "</pre>">> ../output.html
            #.././ncl/bin/ncl print.ncl 
            #curl -F 'name=@hgt30_4.png' https://x.example.domain/ >> ../output.html
            #curl -F 'name=@plt_geo_4.png' https://x.example.domain/ >> ../output.html

            cp aux* ../output_2/
            rm -f met* aux* namelist.input hgt30_4.pdf plt_geo_4.pdf 
            cd ..
        fi
    done
done
sed -i 's/https/<img class="mdui-img-fluid" src="https/g' output.html
sed -i 's/.png/.png" \/>/g' output.html
echo '</div></div></body>' >>output.html
curl -F 'name=@output.html' https://x.example.domain/
zip output.zip output -r
zip output1.zip output1 -r
zip output_2.zip output_2 -r
zip output1_2.zip output1_2 -r
echo "output1" 
curl -F 'name=@output1.zip' https://x.example.domain/
ping www.example.domain
echo "output"
curl -F 'name=@output.zip' https://x.example.domain/
ping www.example.domain
echo "output1_2"
curl -F 'name=@output1_2.zip' https://x.example.domain/
ping www.example.domain
echo "outpu_2"
curl -F 'name=@output_2.zip' https://x.example.domain/
##wget https://x.example.domain/81/31277affbe4cc3af1b590dad8b76f66eaf9735.zip
#unzip 31277affbe4cc3af1b590dad8b76f66eaf9735.zip
#wget http://www2.mmm.ucar.edu/wrf/OnLineTutorial/Graphics/NCL/Examples/LEVELS_MODEL/wrf_EtaLevels.ncl
#mv wrf_EtaLevels.ncl data/
#export NCARG_ROOT=`pwd`/ncl
#cd data
#mv wrfout_d01_2017-07-28_12:00:00 wrfout_d01_2017-07-28_12:00:00.nc
#sed -i 's/..\/wrfout_d01_2000-01-24_12:00:00.nc/.\/wrfout_d01_2017-07-28_12:00:00.nc/g' wrf_EtaLevels.ncl  
#sed -i 's/type = "x11"/;type = "x11"/g' wrf_EtaLevels.ncl  
#sed -i 's/; type = "pdf"/type = "pdf"/g' wrf_EtaLevels.ncl
#../ncl/bin/ncl wrf_EtaLevels.ncl
#curl -F 'name=@plt_EtaLevels.pdf' https://x.example.domain