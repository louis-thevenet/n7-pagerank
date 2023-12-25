
with PageRank_Result;
with Vecteurs_Creux; use Vecteurs_Creux;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Long_Float_Text_IO; use Ada.Long_Float_Text_IO;

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

function Prochaine_Iteration (Poids : PageRank_Result_Inst.T_Tab_Poids;
                                G : in T_Matrice;
                                Lignes_Non_Nulles : in T_Vecteur_Creux;
                                Alpha : Long_Float;
                                Taille : Integer
                                ) return PageRank_Result_Inst.T_Tab_Poids is
Tmp : Long_Float;
Resultat : PageRank_Result_Inst.T_Tab_Poids;
Taille_Float : Long_Float := Long_Float(Taille);

Tete, Tete_Lignes_Non_Nulles  : T_Vecteur_Creux;
Ligne  : T_Matrice;
beta : Long_Float;
Nombre_Cellules : Long_Float;
begin
Ligne := G;
beta := (1.0 - Alpha) / Taille_Float;


while Ligne /= Null and then Ligne.Indice <= Taille loop
    Resultat(Ligne.Indice) := 0.0;
    Tete := Ligne.Valeur;
    Tete_Lignes_Non_Nulles := Lignes_Non_Nulles;

    for I in 1..Taille loop
        if Tete = Null then
            Tmp := 0.0;
        elsif Tete.Indice = I then
            --  if Tete_Lignes_Non_Nulles = Null then

            --      Nombre_Cellules := 1.0;
            --  elsif Tete_Lignes_Non_Nulles.Indice = I then
            --          Nombre_Cellules := Tete_Lignes_Non_Nulles.Valeur;
            --          Tete_Lignes_Non_Nulles := Tete_Lignes_Non_Nulles.Suivant;
            --  else
            --      while Tete_Lignes_Non_Nulles /= Null and then Tete_Lignes_Non_Nulles.Indice < I loop
            --          Tete_Lignes_Non_Nulles := Tete_Lignes_Non_Nulles.Suivant;
            --      end loop;
            --      if Tete_Lignes_Non_Nulles /= Null and then Tete_Lignes_Non_Nulles.Indice = I then
            --          Nombre_Cellules := Tete_Lignes_Non_Nulles.Valeur;
            --      else
            --          Nombre_Cellules := 1.0;
            --      end if;
            --  end if;

            Nombre_Cellules := 1.0;

            Tmp := Tete.Valeur / Nombre_Cellules;
            Tete := Tete.Suivant;
        else
            while Tete /= Null and then Tete.Indice < I loop
                Tete := Tete.Suivant;
            end loop;
            Tmp := 0.0;
        end if;


        Resultat(Ligne.Indice) := Resultat(Ligne.Indice) + (Alpha * Tmp+ beta) * Poids(I);

    end loop;
    Ligne := Ligne.Suivant;
end loop;

return Resultat;
end Prochaine_Iteration;



procedure Iterer (Poids : in out PageRank_Result_Inst.T_Tab_Poids; G : in T_Matrice; Lignes_Non_Nulles : T_Vecteur_Creux; K : Integer; Epsilon : Long_Float;Alpha : Long_Float; Taille : Integer) is
I : Integer := 0;
old : PageRank_Result_Inst.T_Tab_Poids := Poids;

Tete, Tete_Lignes_Non_Nulles  : T_Vecteur_Creux;
Ligne  : T_Matrice;
Nombre_Cellules : Long_Float;
begin
    Ligne := G;

    while Ligne /= Null and then Ligne.Indice <= Taille loop
        Tete := Ligne.Valeur;
        Tete_Lignes_Non_Nulles := Lignes_Non_Nulles;

        -- on pondère les lignes non nulles
        for I in 1..Taille loop
            if Tete = Null then
                null;
            elsif Tete.Indice = I then
                if Tete_Lignes_Non_Nulles = Null then

                    Nombre_Cellules := 1.0;
                elsif Tete_Lignes_Non_Nulles.Indice = I then
                        Nombre_Cellules := Tete_Lignes_Non_Nulles.Valeur;
                        Tete_Lignes_Non_Nulles := Tete_Lignes_Non_Nulles.Suivant;
                else
                    while Tete_Lignes_Non_Nulles /= Null and then Tete_Lignes_Non_Nulles.Indice < I loop
                        Tete_Lignes_Non_Nulles := Tete_Lignes_Non_Nulles.Suivant;
                    end loop;
                    if Tete_Lignes_Non_Nulles /= Null and then Tete_Lignes_Non_Nulles.Indice = I then
                        Nombre_Cellules := Tete_Lignes_Non_Nulles.Valeur;
                    else
                        Nombre_Cellules := 1.0;
                    end if;
                end if;


                Tete.Valeur := Tete.Valeur / Nombre_Cellules;
                Tete := Tete.Suivant;
            else
                while Tete /= Null and then Tete.Indice < I loop
                    Tete := Tete.Suivant;
                end loop;
            end if;
        end loop;
        Ligne := Ligne.Suivant;
    end loop;


    while I < K and then PageRank_Result_Inst.Norme_Au_Carre(PageRank_Result_Inst.Combi_Lineaire(1.0, Poids, -1.0, Old))>=Epsilon*Epsilon loop
        Old := Poids;
        Poids := Prochaine_Iteration(Poids, G, Lignes_Non_Nulles, Alpha, Poids'Length);
        put(I, 1);
        new_line;
        I := I + 1;
    end loop;
end Iterer;

end PageRank_Creuse;