cd F:\\first_unit\\2-Building_the_KcsA_tetramer
mol load pdb 1K4C.pdb
set all [atomselect top all]
$all set segname A
$all writepdb KCSA-A.pdb
set rep [atomselect top "all and not name K"]
$rep set segname B
$rep move {{-1.0 0.0 0.0 310.66} {0.0 -1.0 0.0 310.66} {0.0 0.0 1.0 0.0} {0.0 0.0 0.0 1.0}}
$rep writepdb KCSA-B.pdb
mol delete top
mol load pdb 1K4C.pdb
set rep [atomselect top "all and not name K"]
$rep set segname C
$rep move {{0.0 -1.0 0.0 310.66} {1.0 0.0 0.0 0.0} {0.0 0.0 1.0 0.0} {0.0 0.0 0.0 1.0}}
$rep writepdb KCSA-C.pdb
mol delete top
mol load pdb 1K4C.pdb
set rep [atomselect top "all and not name K"]
$rep set segname D
$rep move {{0.0 1.0 0.0 0.0} {-1.0 0.0 0.0 310.66} {0.0 0.0 1.0 0.0} {0.0 0.0 0.0 1.0}}
$rep writepdb KCSA-D.pdb
exit
