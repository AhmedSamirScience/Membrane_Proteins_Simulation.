set all [atomselect top all] 
measure center $all 
measure minmax $all
set wat [atomselect top water] 
measure minmax $wat
molinfo top set a 77 
molinfo top set b 77 
molinfo top set c 90 