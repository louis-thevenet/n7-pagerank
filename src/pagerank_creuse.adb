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
                                  S : in Matrices_Creuses_Inst.T_Matrice;
                                  Alpha : Long_Float;
                                  Taille : Integer
                                 ) return PageRank_Result_Inst.T_Tab_Poids is
        Tmp : Long_Float;
        Resultat : PageRank_Result_Inst.T_Tab_Poids;
        Taille_Float : constant Long_Float := Long_Float(Taille);

        Tete : T_Vecteur_Creux; -- pointeur sur la colonne vecteur creux
        beta : Long_Float;

    begin
        beta := (1.0 - Alpha) / Taille_Float;
        for colonne in 1..Taille loop
            Resultat(colonne) := 0.0;
            Tete := S(colonne);
            for I in 1..Taille loop
                if Tete = Null then
                    Tmp := 0.0;
                elsif Tete.Indice = I then
                    Tmp := Tete.Valeur;
                    Tete := Tete.Suivant;
                else
                    while Tete /= Null and then Tete.Indice < I loop
                        Tete := Tete.Suivant;
                    end loop;
                    Tmp := 0.0;
                end if;

                Resultat(colonne) := Resultat(colonne) + (Alpha * Tmp+ beta) * Poids(I);

            end loop;
        end loop;

        return Poids;
    end Prochaine_Iteration;



procedure Iterer (Poids : in out PageRank_Result_Inst.T_Tab_Poids; S : in Matrices_Creuses_Inst.T_Matrice; Lignes_Non_Nulles : T_Vecteur_Creux; K : Integer; Epsilon : Long_Float;Alpha : Long_Float; Taille : Integer) is

-- Le début c'est juste pondérer les lignes toute nulle en les remplissant avec 1/n
-- je l'avais mis ici pour optimiser mais avant c'était dans LIRE_GRAPHE
-- sinon juste on itère en appelant Prochaine_Itération

  I : Integer := 0;
  old : PageRank_Result_Inst.T_Tab_Poids := Poids;

  Tete, Tete_Lignes_Non_Nulles  : T_Vecteur_Creux;
  Nombre_Cellules : Long_Float;
  begin


      for colonne in 1..Taille loop
          Tete := S(colonne);
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
      end loop;

      -- Itérations de PageRank
      while I < K and then PageRank_Result_Inst.Norme_Au_Carre(PageRank_Result_Inst.Combi_Lineaire(1.0, Poids, -1.0, Old))>=Epsilon*Epsilon loop
          Old := Poids;
          Poids := Prochaine_Iteration(Poids, S, Alpha, Poids'Length);
          put(I, 1);
          new_line;
          I := I + 1;
      end loop;
  end Iterer;


end PageRank_Creuse;
