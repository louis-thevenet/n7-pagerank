with Matrices_Pleines;

generic

   with package Matrices_Pleines_Inst is new Matrices_Pleines (<>);
    with package Vecteurs_Pleins_Inst is new Matrices_Pleines (<>);

package PageRank_Pleine is
    procedure Calculer_S(H : in out Matrices_Pleines_Inst.T_Matrice);
    procedure Calculer_G(S : in out Matrices_Pleines_Inst.T_Matrice; alpha : Long_Float);

    procedure Calculer_Pi_Transpose (Poids : in out Vecteurs_Pleins_Inst.T_Matrice);

    procedure Prochaine_Iteration (Poids : in out Vecteurs_Pleins_Inst.T_Matrice; G : in Matrices_Pleines_Inst.T_Matrice);

    procedure Iterer (Poids : in out Vecteurs_Pleins_Inst.T_Matrice; G : in Matrices_Pleines_Inst.T_Matrice; K : Integer);
end PageRank_Pleine;