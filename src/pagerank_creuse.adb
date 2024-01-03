with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

package body PageRank_Creuse is
    procedure Calculer_Pi_Transpose (Resultat : in out PageRank_Result_Inst.T_Resultat) is
    begin
        for J in 1..Resultat.Taille loop
            Resultat.Poids(J) := 1.0 / Long_Float(Resultat.Taille);
        end loop;
    end Calculer_Pi_Transpose;

function Prochaine_Iteration (Poids : PageRank_Result_Inst.T_Tab_Poids;
                                G : in Matrices_Creuses_Inst.T_Matrice;
                                Alpha : Long_Float;
                                Taille : Integer
                                ) return PageRank_Result_Inst.T_Tab_Poids is
--  Tmp : Long_Float;
--  Resultat : PageRank_Result_Inst.T_Tab_Poids;
--  Taille_Float : constant Long_Float := Long_Float(Taille);

--  Tete : T_Vecteur_Creux;
--  Ligne  : Matrices_Creuses_Inst.T_Matrice;
--  beta : Long_Float;
begin

 -- PSEUDO CODE

--  beta := (1.0 - Alpha) / Taille_Float;

 -- POUR J de 1 à Taille faire
 -- Pour I de 1 à Taille faire
    -- Resultat(J) := Resultat(J) + (Alpha * G(I, J) + beta) * Poids(I);








--  Ligne := G;
--  beta := (1.0 - Alpha) / Taille_Float;


--  while Ligne /= Null and then Ligne.Indice <= Taille loop
--      Resultat(Ligne.Indice) := 0.0;
--      Tete := Ligne.Valeur;
--      for I in 1..Taille loop
--          if Tete = Null then
--              Tmp := 0.0;
--          elsif Tete.Indice = I then
--              Tmp := Tete.Valeur;
--              Tete := Tete.Suivant;
--          else
--              while Tete /= Null and then Tete.Indice < I loop
--                  Tete := Tete.Suivant;
--              end loop;
--              Tmp := 0.0;
--          end if;

--          Resultat(Ligne.Indice) := Resultat(Ligne.Indice) + (Alpha * Tmp+ beta) * Poids(I);

--      end loop;
--      Ligne := Ligne.Suivant;
--  end loop;

return Poids;
end Prochaine_Iteration;



procedure Iterer (Poids : in out PageRank_Result_Inst.T_Tab_Poids; G : in Matrices_Creuses_Inst.T_Matrice; Lignes_Non_Nulles : T_Vecteur_Creux; K : Integer; Epsilon : Long_Float;Alpha : Long_Float; Taille : Integer) is


-- PSEUDO CODE

-- Le début c'est juste pondérer les lignes toute nulle en les remplissant avec 1/n
-- je l'avais mis ici pour optimiser mais avant c'était dans LIRE_GRAPHE
-- sinon juste on itère en appelant Prochaine_Itération





--  I : Integer := 0;
--  old : PageRank_Result_Inst.T_Tab_Poids := Poids;

--  Tete, Tete_Lignes_Non_Nulles  : T_Vecteur_Creux;
--  Ligne  : T_Matrice;
--  Nombre_Cellules : Long_Float;
--  begin
--      Ligne := G;

--      while Ligne /= Null and then Ligne.Indice <= Taille loop
--          Tete := Ligne.Valeur;
--          Tete_Lignes_Non_Nulles := Lignes_Non_Nulles;

--          -- on pondère les lignes non nulles
--          for I in 1..Taille loop
--              if Tete = Null then
--                  null;
--              elsif Tete.Indice = I then
--                  if Tete_Lignes_Non_Nulles = Null then

--                      Nombre_Cellules := 1.0;
--                  elsif Tete_Lignes_Non_Nulles.Indice = I then
--                          Nombre_Cellules := Tete_Lignes_Non_Nulles.Valeur;
--                          Tete_Lignes_Non_Nulles := Tete_Lignes_Non_Nulles.Suivant;
--                  else
--                      while Tete_Lignes_Non_Nulles /= Null and then Tete_Lignes_Non_Nulles.Indice < I loop
--                          Tete_Lignes_Non_Nulles := Tete_Lignes_Non_Nulles.Suivant;
--                      end loop;
--                      if Tete_Lignes_Non_Nulles /= Null and then Tete_Lignes_Non_Nulles.Indice = I then
--                          Nombre_Cellules := Tete_Lignes_Non_Nulles.Valeur;
--                      else
--                          Nombre_Cellules := 1.0;
--                      end if;
--                  end if;


--                  Tete.Valeur := Tete.Valeur / Nombre_Cellules;
--                  Tete := Tete.Suivant;
--              else
--                  while Tete /= Null and then Tete.Indice < I loop
--                      Tete := Tete.Suivant;
--                  end loop;
--              end if;
--          end loop;
--          Ligne := Ligne.Suivant;
--      end loop;

--      -- Itérations de PageRank
--      while I < K and then PageRank_Result_Inst.Norme_Au_Carre(PageRank_Result_Inst.Combi_Lineaire(1.0, Poids, -1.0, Old))>=Epsilon*Epsilon loop
--          Old := Poids;
--          Poids := Prochaine_Iteration(Poids, G, Alpha, Poids'Length);
--          put(I, 1);
--          new_line;
--          I := I + 1;
--      end loop;
--  end Iterer;
null;

end PageRank_Creuse;