with Matrices_Pleines;

generic
   with package Matrices_Pleines_Inst is new Matrices_Pleines (<>);
   with package Vecteurs_Pleins_Inst is new Matrices_Pleines (<>);

package PageRank_Pleine is
    -- Calcule la matrice de transition S à partir de la matrice d'adjacence H.
    procedure Calculer_S(H : in out Matrices_Pleines_Inst.T_Matrice)
        with
            Pre  => Matrices_Pleines_Inst.Lignes_Matrice(H) = Matrices_Pleines_Inst.Colonnes_Matrice(H);

    -- Calcule la matrice G à partir de la matrice de transition S et du paramètre alpha.
    procedure Calculer_G(S : in out Matrices_Pleines_Inst.T_Matrice; alpha : Long_Float);

    -- Calcule le vecteur Pi transpose à partir des poids des pages.
    procedure Calculer_Pi_Transpose (Poids : in out Vecteurs_Pleins_Inst.T_Matrice);

    -- Renvoie le prochain vecteur des poids
    function Prochaine_Iteration (Poids : in Vecteurs_Pleins_Inst.T_Matrice; G : in Matrices_Pleines_Inst.T_Matrice) return Vecteurs_Pleins_Inst.T_Matrice;

    -- Effectue K itérations pour mettre à jour les poids.
    procedure Iterer (Poids : in out Vecteurs_Pleins_Inst.T_Matrice; G : in Matrices_Pleines_Inst.T_Matrice; K : Integer; Epsilon : Long_Float)
        with
            Pre  => K >= 0;

end PageRank_Pleine;