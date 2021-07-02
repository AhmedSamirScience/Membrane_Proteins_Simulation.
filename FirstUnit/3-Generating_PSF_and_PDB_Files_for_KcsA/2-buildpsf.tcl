package require psfgen
topology top_all27_prot_lipid.rtf
pdbalias residue HIS HSE
pdbalias atom ILE CD1 CD
pdbalias atom HOH O OH2
pdbalias residue HOH TIP3
foreach S {A B C D} {
segment $S {
pdb seg$S.pdb
}
coordpdb seg$S.pdb $S
patch GLUP $S:71
regenerate angles dihedrals
segment WC$S {
auto none
pdb crystwat$S.pdb
}
coordpdb crystwat$S.pdb WC$S
}
segment I {
pdb pot.pdb
}
coordpdb pot.pdb I
segment WF {
auto none
pdb filtwat.pdb
}
coordpdb filtwat.pdb WF
guesscoord
writepdb kcsav.pdb
writepsf kcsav.psf
exit
