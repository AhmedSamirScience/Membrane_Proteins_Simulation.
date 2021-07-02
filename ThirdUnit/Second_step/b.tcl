mol new D:\\VMD\\03-MINEQ\\kcsa_popcwi.psf 
mol addfile D:\\VMD\\03-MINEQ\\kcsa_popcwi.pdb 
set all [atomselect top "all"] 
$all set beta 0 
set prot [atomselect top "protein"] 
$prot set beta 1 
$all writepdb kcsa_popcwi.cnst