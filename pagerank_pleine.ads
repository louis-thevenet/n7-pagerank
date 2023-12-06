with Matrices_Pleines;

generic

   with package Matrices_Pleines_Inst is new Matrices_Pleines (<>);
package PageRank_Pleine is
    procedure Calculer_S(H : in out Matrices_Pleines_Inst.T_Matrice);
    procedure Calculer_G(S : in out Matrices_Pleines_Inst.T_Matrice; alpha : Long_Float);
gnend PageRank_Pleine;