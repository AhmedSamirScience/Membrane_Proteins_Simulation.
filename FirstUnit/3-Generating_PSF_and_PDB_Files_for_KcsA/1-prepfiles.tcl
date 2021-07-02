cd F:\\first_unit\\3-Generating_PSF_and_PDB_Files_for_KcsA

mol load pdb KCSA-ALL.pdb

foreach S {A B C D} {
set seg [atomselect top "segname $S and chain C and protein"]
$seg writepdb seg$S.pdb
$seg delete
}

set pot [atomselect top "name K and resid 3001 3003 3005 3006"]

$pot set name POT
$pot set resname POT
$pot writepdb pot.pdb

set npot [atomselect top "name K and resid 3002 3004 3007"]
$npot set name OH2
$npot set resname TIP3
$npot writepdb filtwat.pdb

foreach S {A B C D} { 
set wat [atomselect top "segname $S and resname HOH and within 10 of (chain C and protein)"]
$wat writepdb crystwat$S.pdb
$wat delete
}

exit
