with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Ada.Long_Float_Text_IO;	use Ada.Long_Float_Text_IO;
with Lire_Graphe;
with Matrices_Creuses;
with Matrices_Pleines;
with PageRank_Pleine;
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
            package Matrices_Creuses_Float is new Matrices_Creuses(Taille);
            use Matrices_Creuses_Float;

            package Matrices_Pleines_Float is new Matrices_Pleines(Taille);
            use Matrices_Pleines_Float;

            package Lire_Graphe_Inst is new Lire_Graphe(Matrices_Creuses_Float,Matrices_Pleines_Float); use Lire_Graphe_Inst;

        begin

            if Pleine then
                declare
                    H : Matrices_Pleines_Float.T_Matrice;
                    package PageRank_Pleine_Inst is new PageRank_Pleine(Matrices_Pleines_Float);
                begin
                    Matrices_Pleines_Float.Initialiser(H);
                    Completer_Graphe_Pleine(File,H);

                    Matrices_Pleines_Float.Afficher(H);

                    PageRank_Pleine_Inst.Calculer_S(H);

                    New_Line;
                    Matrices_Pleines_Float.Afficher(H);



                    PageRank_Pleine_Inst.Calculer_G(H, alpha);
                    New_Line;
                    Matrices_Pleines_Float.Afficher(H);
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