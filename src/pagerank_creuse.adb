with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Long_Float_Text_IO; use Ada.Long_Float_Text_IO;

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
                                Taille : Integer
                                ) return PageRank_Result_Inst.T_Tab_Poids is
Tmp : Long_Float;
Resultat : PageRank_Result_Inst.T_Tab_Poids;
Tete : T_Vecteur_Creux;
beta : Long_Float := (1.0 - Alpha) / Long_Float(Taille);

begin
    for J in 1..Taille loop
        Resultat(J) := 0.0;
        Tete := S(J);
        for I in 1..Taille loop
            if Tete = Null then
                Tmp := 0.0;
            elsif Tete.Indice = I then
                Tmp := Tete.Valeur/Facteurs(I);
                Tete := Tete.Suivant;
            else
                while Tete /= Null and then Tete.Indice < I loop
                    Tete := Tete.Suivant;
                end loop;
                Tmp := 0.0;
            end if;
            Resultat(J) := Resultat(J) + (Alpha * Tmp+ beta) * Poids(I);

        end loop;
    end loop;
    return Resultat;
end Prochaine_Iteration;



procedure Iterer (Poids : in out PageRank_Result_Inst.T_Tab_Poids; S : in Matrices_Creuses_Inst.T_Matrice; Facteurs : Matrices_Creuses_Inst.T_Facteurs; K : Integer; Epsilon : Long_Float;Alpha : Long_Float; Taille : Integer) is

  I : Integer := 0;
  old : PageRank_Result_Inst.T_Tab_Poids := Poids;
  Norme : Long_Float := 0.0;
begin
-- Itérations de PageRank
    while I < K  loop
        Old := Poids;
        Poids := Prochaine_Iteration(Poids, S, Facteurs, Alpha, Poids'Length);
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
