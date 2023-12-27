with Matrices_Creuses; use Matrices_Creuses;
with Vecteurs_Creux; use Vecteurs_Creux;

with PageRank_Result;
generic
   with package PageRank_Result_Inst is new PageRank_Result (<>);

package PageRank_Creuse is
    -- Calcule la matrice de transition S à partir de la matrice d'adjacence H.
    procedure Calculer_S(H : in out T_Matrice; Taille : Integer);

    -- Calcule la matrice G à partir de la matrice de transition S et du paramètre alpha.
    procedure Calculer_G(S : in out T_Matrice; alpha : Long_Float; Taille : Integer);

    -- Calcule le vecteur Pi transpose à partir des poids des pages.
    procedure Calculer_Pi_Transpose (Resultat : in out PageRank_Result_Inst.T_Resultat);

    -- Renvoie le prochain vecteur des poids
function Prochaine_Iteration (Poids : PageRank_Result_Inst.T_Tab_Poids; G : in T_Matrice; Alpha : Long_Float; Taille : Integer) return PageRank_Result_Inst.T_Tab_Poids;
    -- Effectue K itérations pour mettre à jour les poids.

procedure Iterer (Poids : in out PageRank_Result_Inst.T_Tab_Poids; G : in T_Matrice; Lignes_Non_Nulles : in T_Vecteur_Creux; K : Integer; Epsilon : Long_Float; Alpha : Long_Float; Taille : Integer)        with
            Pre  => K >= 0;

end PageRank_Creuse;