with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;

with Lire_Graphe;
with Matrices_Creuses;
with Matrices_Pleines;
with PageRank_Pleine;
with PageRank_Result;

package body PageRank is
       procedure Algorithme_PageRank(Alpha : in Long_Float;
                                    K : in Integer;
                                    Epsilon : in Long_Float;
                                    Pleine : in Boolean;
                                    Prefixe : in String;
                                    Fichier_Nom : in String) is
                                    File : Ada.Text_IO.File_Type;
                                    Taille : Integer;
    begin
        open (File, In_File, Fichier_Nom);
        Get (File, Taille);
        declare
            -- changer pour prendre des matrices n*p au lieu de n*n
            package Matrices_Creuses_Float is new Matrices_Creuses(Taille);
            use Matrices_Creuses_Float;

            package Matrices_Pleines_Float is new Matrices_Pleines(Taille, Taille);
            use Matrices_Pleines_Float;



            --  package Vecteurs_Pleins_Float is new Matrices_Pleines(Taille, 1);
            --  package Vecteurs_Pleins_Integer is new Matrices_Pleines(Taille, 1);


            package Lire_Graphe_Inst is new Lire_Graphe(Matrices_Creuses_Float,Matrices_Pleines_Float); use Lire_Graphe_Inst;


            package PageRank_Result_Inst is new PageRank_Result(Taille);
            use PageRank_Result_Inst;
        begin

            if Pleine then
                declare
                    package PageRank_Pleine_Inst is new PageRank_Pleine(Matrices_Pleines_Float, PageRank_Result_Inst);
                    --package Trier_Vecteur_Plein_Inst is new Trier_Vecteur_Plein(Vecteurs_Pleins_Float);

                    G : Matrices_Pleines_Float.T_Matrice;
                    Resultat : T_Resultat;

                begin
                    Matrices_Pleines_Float.Initialiser(G);
                    Completer_Graphe_Pleine(File,G);
                    PageRank_Pleine_Inst.Calculer_S(G);
                    PageRank_Pleine_Inst.Calculer_G(G, alpha);

                    PageRank_Result_Inst.Initialiser(Resultat);
                    PageRank_Pleine_Inst.Calculer_Pi_Transpose(Resultat);

                    PageRank_Pleine_Inst.Iterer(Resultat.Poids, G, K, Epsilon);
                    PageRank_Result_Inst.Trier(Resultat);
                    PageRank_Result_Inst.Enregistrer(Resultat, Prefixe, Alpha, K);
                end;
            else
                declare
                    G : Matrices_Creuses_Float.T_Matrice;
                begin
                    Matrices_Creuses_Float.Initialiser(G);
                    Completer_Graphe_Creuse(File,G);
                    Matrices_Creuses_Float.Afficher(G);
                    -- Partie Creuse non terminée
                end;
            end if;
        end;
    end Algorithme_PageRank;
end PageRank;