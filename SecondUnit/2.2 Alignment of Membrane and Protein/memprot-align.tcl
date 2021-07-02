package require membrane
membrane -l POPC -x 80 -y 80 -o popc
set popc [atomselect top all]
set kcsamol [mol load psf kcsa_solv.psf pdb kcsa_solv.pdb]
set kcsa [atomselect $kcsamol all]
$popc moveby [vecinvert [measure center $popc weight mass]]
$popc writepdb popc_TEMP.pdb
set vest [atomselect $kcsamol "protein and resid 97 to 106"]
$kcsa moveby [vecinvert [measure center $vest weight mass]]
display resetview
$kcsa move [transaxis z -25]
$kcsa writepdb kcsa_TEMP.pdb
mol delete all
package require psfgen
resetpsf
readpsf popc.psf
coordpdb popc_TEMP.pdb
readpsf kcsa_solv.psf
coordpdb kcsa_TEMP.pdb
writepsf kcsa_popc_raw.psf
writepdb kcsa_popc_raw.pdb
file delete kcsa_TEMP.pdb
file delete popc_TEMP.pdb



