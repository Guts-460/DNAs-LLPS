#!/bin/bash

gmx=/mnt/c/gmx2022/gmx2022.5_GPU/gromacs/bin/gmx.exe

#gmx trjconv -f hnpdrop_all12.5us.xtc -s box.gro -o hnpdrop_all12us.xtc -e 12000 -tu ns << EOF
#1
#EOF

$gmx trjconv -s .././14/14us.tpr -f .././14/14us.xtc -o "14us_cluster.xtc" -pbc cluster -center << EOF
1
1
1
EOF

$gmx trjconv -s .././14/"14us.tpr" -f "14us_cluster.xtc" -o "14us_mol.xtc" -pbc mol -center << EOF
1
1
EOF

rm "14us_cluster.xtc"

$gmx trjconv -s .././14/"14us.tpr" -f "14us_mol.xtc" -o "14us.xtc" -fit rot+trans << EOF
1
1
EOF

rm "14us_mol.xtc"

$gmx trjconv -s .././14/"14us.tpr" -f "14us.xtc" -o "14ust0.xtc" -t"0" 12000000 << EOF
1
EOF

rm "14us.xtc"

$gmx trjcat -f hnpdrop_all12us.xtc "14ust0.xtc" -o hnpdrop_all14us.xtc
