with Matrices_Creuses;
with Vecteurs_Creux; use Vecteurs_Creux;

with PageRank_Result;
generic
    with package Matrices_Creuses_Inst is new Matrices_Creuses (<>);
    with package PageRank_Result_Inst is new PageRank_Result (<>);

package PageRank_Creuse is

    -- Calcule le vecteur Pi transpose à partir des poids des pages.
    procedure Calculer_Pi_Transpose (Resultat : in out PageRank_Result_Inst.T_Resultat);

    -- Renvoie le prochain vecteur des poids
    function Prochaine_Iteration (Poids : PageRank_Result_Inst.T_Tab_Poids; S : in Matrices_Creuses_Inst.T_Matrice; Alpha : Long_Float; Taille : Integer) return PageRank_Result_Inst.T_Tab_Poids;

    -- Effectue K itérations pour mettre à jour les poids ou s'arrête en avance si l'écart entre les normes des Poids est inférieure à Epsilon.
    procedure Iterer (Poids : in out PageRank_Result_Inst.T_Tab_Poids; S : in Matrices_Creuses_Inst.T_Matrice; K : Integer; Epsilon : Long_Float; Alpha : Long_Float; Taille : Integer)        with
            Pre  => K >= 0;

end PageRank_Creuse;
