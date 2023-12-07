with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Ada.Long_Float_Text_IO;	use Ada.Long_Float_Text_IO;
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


            package Vecteurs_Pleins_Float is new Matrices_Pleines(Taille, 1);
            use Vecteurs_Pleins_Float;



            package Lire_Graphe_Inst is new Lire_Graphe(Matrices_Creuses_Float,Matrices_Pleines_Float); use Lire_Graphe_Inst;


            package PageRank_Result_Inst is new PageRank_Result(Taille);
            use PageRank_Result_Inst;
        begin

            if Pleine then
                declare
                    package PageRank_Pleine_Inst is new PageRank_Pleine(Matrices_Pleines_Float, Vecteurs_Pleins_Float);
                    --use PageRank_Pleine_Inst;


                    H : Matrices_Pleines_Float.T_Matrice;
                    Poids : Vecteurs_Pleins_Float.T_Matrice;
                begin
                    Matrices_Pleines_Float.Initialiser(H);
                    Completer_Graphe_Pleine(File,H);
                    PageRank_Pleine_Inst.Calculer_S(H);
                    PageRank_Pleine_Inst.Calculer_G(H, alpha);


                    Put("G");
                    New_Line;
                    Matrices_Pleines_Float.Afficher(H);
                    New_Line;

                    Vecteurs_Pleins_Float.Initialiser(Poids);
                    PageRank_Pleine_Inst.Calculer_Pi_Transpose(Poids);
                    Vecteurs_Pleins_Float.Afficher(Poids);

                    PageRank_Pleine_Inst.Iterer(Poids, H, K);
                    Put("Après");
                    New_Line;

                    Vecteurs_Pleins_Float.Afficher(Poids);
                end;
            else
                declare
                    H : Matrices_Creuses_Float.T_Matrice;
                begin
                    Matrices_Creuses_Float.Initialiser(H);
                    Completer_Graphe_Creuse(File,H);
                    Matrices_Creuses_Float.Afficher(H);
                end;
            end if;
        end;
    end Algorithme_PageRank;
end PageRank;