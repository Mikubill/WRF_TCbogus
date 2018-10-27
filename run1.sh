#!/bin/bash
mkdir run
mkdir output
mkdir output_2
cp print.ncl run/
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
            echo "---${i}-${j}-1-3-BOTH-REMOVE-"   
            cp ../tc.exe tc.exe 
            cp ../met_em.d01.2017-07-${i}_${j}_00_00.nc met_em.d01.2017-07-${i}_${j}\:00\:00.nc      
            cp ../namelist-${i}${j}-remove-1.input namelist.input
            ./tc.exe | grep -E 'TC: Processing|Storm|Estimated central|nstrm|Bogus storm' 
            mv auxinput1_d01_2017-07-${i}_${j}\:00\:00.nc met_em.d01.2017-07-${i}_${j}\:00\:00.nc
            cp ../namelist-${i}${j}-remove-2.input namelist.input
            ./tc.exe | grep -E 'TC: Processing|Storm|Estimated central|nstrm|Bogus storm' 

            echo "---${i}-${j}-1-4-INSERT-"
            cp ../namelist-${i}${j}-insert-1.input namelist.input
            cp auxinput1_d01_2017-07-${i}_${j}\:00\:00.nc aux_bak
            mv auxinput1_d01_2017-07-${i}_${j}\:00\:00.nc met_em.d01.2017-07-${i}_${j}\:00\:00.nc
            ./tc.exe | grep -E 'TC: Processing|Storm|Estimated central|nstrm|Bogus storm' 
            cp aux* ../output/
            rm -f met* aux* namelist.input hgt30_4.pdf plt_geo_4.pdf 

            echo "---${i}-${j}-2-3-BOTH-REMOVE-"   
            cp ../met_em.d02.2017-07-${i}_${j}_00_00.nc met_em.d01.2017-07-${i}_${j}\:00\:00.nc      
            cp ../namelist-${i}${j}-remove-1.input namelist.input
            sed -i 's/e_we = 74,/e_we = /g' namelist.input
            sed -i 's/e_sn = 61,/e_sn = /g' namelist.input
            sed -i 's/dx = 60000,/dx = /g' namelist.input
            sed -i 's/dy = 60000,/dy = /g' namelist.input
            sed -i 's/grid_id = 1,/grid_id = /g' namelist.input
            sed -i 's/i_parent_start = 1,/i_parent_start = /g' namelist.input
            sed -i 's/j_parent_start = 1,/j_parent_start = /g' namelist.input
            sed -i 's/parent_grid_ratio = 1,/parent_grid_ratio = /g' namelist.input
            sed -i 's/parent_time_step_ratio = 1,/parent_time_step_ratio =/g' namelist.input
            ./tc.exe | grep -E 'TC: Processing|Storm|Estimated central|nstrm|Bogus storm' 
            mv auxinput1_d01_2017-07-${i}_${j}\:00\:00.nc met_em.d01.2017-07-${i}_${j}\:00\:00.nc
            cp ../namelist-${i}${j}-remove-2.input namelist.input
            sed -i 's/e_we = 74,/e_we = /g' namelist.input
            sed -i 's/e_sn = 61,/e_sn = /g' namelist.input
            sed -i 's/dx = 60000,/dx = /g' namelist.input
            sed -i 's/dy = 60000,/dy = /g' namelist.input
            sed -i 's/grid_id = 1,/grid_id = /g' namelist.input
            sed -i 's/i_parent_start = 1,/i_parent_start = /g' namelist.input
            sed -i 's/j_parent_start = 1,/j_parent_start = /g' namelist.input
            sed -i 's/parent_grid_ratio = 1,/parent_grid_ratio = /g' namelist.input
            sed -i 's/parent_time_step_ratio = 1,/parent_time_step_ratio =/g' namelist.input
            ./tc.exe | grep -E 'TC: Processing|Storm|Estimated central|nstrm|Bogus storm' 

            echo "---${i}-${j}-2-4-INSERT-"
            cp ../namelist-${i}${j}-insert-1.input namelist.input
            sed -i 's/e_we = 74,/e_we = /g' namelist.input
            sed -i 's/e_sn = 61,/e_sn = /g' namelist.input
            sed -i 's/dx = 60000,/dx = /g' namelist.input
            sed -i 's/dy = 60000,/dy = /g' namelist.input
            sed -i 's/grid_id = 1,/grid_id = /g' namelist.input
            sed -i 's/i_parent_start = 1,/i_parent_start = /g' namelist.input
            sed -i 's/j_parent_start = 1,/j_parent_start = /g' namelist.input
            sed -i 's/parent_grid_ratio = 1,/parent_grid_ratio = /g' namelist.input
            sed -i 's/parent_time_step_ratio = 1,/parent_time_step_ratio =/g' namelist.input
            cp auxinput1_d01_2017-07-${i}_${j}\:00\:00.nc aux_bak
            mv auxinput1_d01_2017-07-${i}_${j}\:00\:00.nc met_em.d01.2017-07-${i}_${j}\:00\:00.nc
            ./tc.exe  | grep -E 'TC: Processing|Storm|Estimated central|nstrm|Bogus storm' 
            cp aux* ../output_2/
            rm -f met* aux* namelist.input hgt30_4.pdf plt_geo_4.pdf 
            cd ..
        fi
    done
done
zip output.zip output -r
zip output_2.zip output_2 -r
echo "output"
curl -F 'name=@output.zip' https://x.example.domain/
echo "outpu_2"
curl -F 'name=@output_2.zip' https://x.example.domain/