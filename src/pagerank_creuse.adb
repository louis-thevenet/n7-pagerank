
with PageRank_Result;
with Vecteurs_Creux; use Vecteurs_Creux;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Long_Float_Text_IO; use Ada.Long_Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
-- with PageRank_Result;
--  package body PageRank_Creuse is
--      procedure Calculer_S(H : in out T_Matrice; Taille : Integer) is
--      Est_nul : Boolean;
--      Tmp : T_Matrice := H;
--      Tmp2 : T_Vecteur_Creux;
--      begin
--      while tmp /= Null loop
--          Est_Nul:=true;
--          Tmp2 := Tmp.Valeur;
--          while Tmp2 /= Null loop
--              Est_Nul := Est_Nul and then (Tmp2.Valeur) < 0.00001;
--              Tmp2 := Tmp2.Suivant;
--          end loop;

--          if Est_nul then
--              Tmp2 := Tmp.Valeur;
--              while Tmp2 /= Null loop
--                  Tmp2.Valeur := 1.0/Long_Float(Taille);
--                  Tmp2 := Tmp2.Suivant;
--              end loop;
--          end if;
--          Tmp := Tmp.Suivant;
--      end loop;

--      end Calculer_S;

package body PageRank_Creuse is
    procedure Calculer_S(H : in out T_Matrice; Taille : Integer) is
    Est_nul : Boolean;
    begin

        for I in 1..Taille loop
            Est_nul := true;
            for J in 1..Taille loop
                Est_Nul := Est_Nul and then (Element(H,I,J) < 0.00001);
            end loop;
            if Est_nul then
                for J in 1..Taille loop
                    Modifier(H,I,J,1.0/Long_Float(Taille));
                end loop;
            end if;
        end loop;
    end Calculer_S;

    procedure Calculer_G(S : in out T_Matrice; alpha : Long_Float; Taille : Integer) is
    begin
     for I in 1..Taille loop
            for J in 1..Taille loop
                Modifier(S, I, J, alpha * Element(S, I, J) + (1.0 - alpha) / Long_Float(Taille));
            end loop;
        end loop;
    end Calculer_G;

    procedure Calculer_Pi_Transpose (Resultat : in out PageRank_Result_Inst.T_Resultat; Taille : Integer) is
    begin
        for J in 1..Resultat.Taille loop
            Resultat.Poids(J) := 1.0 / Long_Float(Resultat.Taille);
        end loop;
    end Calculer_Pi_Transpose;


function Prochaine_Iteration (Poids : PageRank_Result_Inst.T_Tab_Poids; G : in T_Matrice; Alpha : Long_Float; Taille : Integer) return PageRank_Result_Inst.T_Tab_Poids is
Tmp : Long_Float;
Resultat : PageRank_Result_Inst.T_Tab_Poids;
Taille_Float : Long_Float := Long_Float(Taille);

Tete : T_Vecteur_Creux;
Cellule_Tmp : T_Vecteur_Creux;
Val : Long_Float;
begin
Tete := G.Valeur;
Cellule_Tmp := Tete;
for J in 1..Taille loop
    Tmp := 0.0;


    while Tete /= Null and then Tete.Indice < J loop
        Tete := Tete.Suivant;
    end loop;

    if Tete = Null or else Tete.Indice > J then
        Cellule_Tmp := Null;
    else
        Cellule_Tmp := Tete;
    end if;

    for I in 1..Taille loop
        while Cellule_Tmp /= Null and then Cellule_Tmp.Indice < I loop
            Cellule_Tmp := Cellule_Tmp.Dessous;
        end loop;

        if Cellule_Tmp = Null or else Cellule_Tmp.Indice > I then
            Val := 0.0;
        else
            Val := Cellule_Tmp.Valeur;
        end if;

        Tmp := Tmp + Val * Poids(J) * Alpha + Poids(J)*(1.0-Alpha)/Taille_Float;

    end loop;

    Resultat(J) := Tmp;

end loop;

return Resultat;


end Prochaine_Iteration;


procedure Iterer (Poids : in out PageRank_Result_Inst.T_Tab_Poids; G : in T_Matrice; K : Integer; Epsilon : Long_Float;Alpha : Long_Float; Taille : Integer) is
I : Integer := 0;
old : PageRank_Result_Inst.T_Tab_Poids := Poids;
begin
    while I < K and then PageRank_Result_Inst.Norme_Au_Carre(PageRank_Result_Inst.Combi_Lineaire(1.0, Poids, -1.0, Old))>=Epsilon*Epsilon loop
        Poids := Prochaine_Iteration(Poids, G, Alpha, Poids'Length);
        I := I + 1;
    end loop;
end Iterer;

end PageRank_Creuse;