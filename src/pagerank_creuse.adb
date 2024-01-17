
with Vecteurs_Creux; use Vecteurs_Creux;

package body PageRank_Creuse is


    procedure Calculer_Pi_Transpose (Resultat : in out PageRank_Result_Inst.T_Resultat) is
    begin
        for J in 1..Resultat.Taille loop
            Resultat.Poids(J) := 1.0 / Long_Float(Resultat.Taille);
        end loop;
    end Calculer_Pi_Transpose;


function Prochaine_Iteration (Poids : PageRank_Result_Inst.T_Tab_Poids;
                                S : in Matrices_Creuses_Inst.T_Matrice;
                                Facteurs : Matrices_Creuses_Inst.T_Facteurs;
                                Alpha : Long_Float;
                                Taille : Integer;
                                Somme : Long_Float
                                ) return PageRank_Result_Inst.T_Tab_Poids is
Resultat : PageRank_Result_Inst.T_Tab_Poids;
Tete : T_Vecteur_Creux;

begin
    for J in 1..Taille loop
        Resultat(J) := Somme;
        Tete := S(J);
        while Tete /= Null loop
            Resultat(J) := Resultat(J) + Alpha * Poids(Tete.Indice) * 1.0/Facteurs(Tete.Indice);
            Tete := Tete.Suivant;
        end loop;
    end loop;
    return Resultat;
end Prochaine_Iteration;



procedure Iterer (Poids : in out PageRank_Result_Inst.T_Tab_Poids; S : in Matrices_Creuses_Inst.T_Matrice; Facteurs : Matrices_Creuses_Inst.T_Facteurs; K : Integer; Epsilon : Long_Float;Alpha : Long_Float; Taille : Integer) is

  I : Integer := 0;
  old : PageRank_Result_Inst.T_Tab_Poids := Poids;
Somme : Long_Float := 0.0;
  Norme : Long_Float := 0.0;
beta : constant Long_Float := (1.0 - Alpha) / Long_Float(Taille);

begin
    for I in 1..Taille loop
        Somme := Somme +  beta * Poids(I);
    end loop;

-- Itérations de PageRank
    while I < K  loop
        Old := Poids;
        Poids := Prochaine_Iteration(Poids, S, Facteurs, Alpha, Taille, Somme);
        for J in 1..Poids'Length loop
            Norme := Norme+(Poids(J)-Old(J))*(Poids(J)-Old(J));
        end loop;
        if Norme <= Epsilon*Epsilon then
            exit;
        else
            null;
        end if;
        I := I + 1;
    end loop;
end Iterer;


end PageRank_Creuse;
