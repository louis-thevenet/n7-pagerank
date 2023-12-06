with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Ada.Long_Float_Text_IO;	use Ada.Long_Float_Text_IO;
with Lire_Graphe;
with Matrices_Creuses;

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

            package Lire_Graphe_Inst is new Lire_Graphe(Matrices_Creuses_Float); use Lire_Graphe_Inst;

            H : T_Matrice;
        begin
            Initialiser(H);
            Completer_Graphe(File, H);
            Afficher(H);
        end;
    end Algorithme_PageRank;
end PageRank;