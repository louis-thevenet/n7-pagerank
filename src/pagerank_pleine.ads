with Matrices_Pleines;
with PageRank_Result;
generic
   with package Matrices_Pleines_Inst is new Matrices_Pleines (<>);
   with package PageRank_Result_Inst is new PageRank_Result (<>);

package PageRank_Pleine is
    -- Calcule la matrice de transition S à partir de la matrice d'adjacence H.
    procedure Calculer_S(H : in out Matrices_Pleines_Inst.T_Matrice)
        with
            Pre  => Matrices_Pleines_Inst.Lignes_Matrice(H) = Matrices_Pleines_Inst.Colonnes_Matrice(H);

    -- Calcule la matrice G à partir de la matrice de transition S et du paramètre alpha.
    procedure Calculer_G(S : in out Matrices_Pleines_Inst.T_Matrice; alpha : Long_Float);

    -- Calcule le vecteur Pi transpose à partir des poids des pages.
    procedure Calculer_Pi_Transpose (Resultat : in out PageRank_Result_Inst.T_Resultat);

    -- Renvoie le prochain vecteur des poids
function Prochaine_Iteration (Poids : PageRank_Result_Inst.T_Tab_Poids; G : in Matrices_Pleines_Inst.T_Matrice) return PageRank_Result_Inst.T_Tab_Poids;
    -- Effectue K itérations pour mettre à jour les poids.

procedure Iterer (Poids : in out PageRank_Result_Inst.T_Tab_Poids; G : in Matrices_Pleines_Inst.T_Matrice; K : Integer; Epsilon : Long_Float)        with
            Pre  => K >= 0;

end PageRank_Pleine;