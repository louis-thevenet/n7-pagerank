with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Ada.IO_Exceptions;
with Lire_Graphe;
with Matrices_Pleines;
with Matrices_Creuses;
with PageRank_Pleine;
with PageRank_Creuse;
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
            package Matrices_Pleines_Float is new Matrices_Pleines(Taille, Taille); use Matrices_Pleines_Float;
            package Matrices_Creuses_Float is new Matrices_Creuses(Taille); use Matrices_Creuses_Float;
            package Lire_Graphe_Inst is new Lire_Graphe(Taille, Matrices_Pleines_Float, Matrices_Creuses_Float); use Lire_Graphe_Inst;
            package PageRank_Result_Inst is new PageRank_Result(Taille); use PageRank_Result_Inst;
        begin
            if Pleine then
                -- Cas Matrices Pleines
                declare
                    package PageRank_Pleine_Inst is new PageRank_Pleine(Matrices_Pleines_Float, PageRank_Result_Inst);

                    G : Matrices_Pleines_Float.T_Matrice;
                    Resultat : T_Resultat;

                begin
                    Matrices_Pleines_Float.Initialiser(G);

                    -- Lecture du fichier d'entrée
                    Completer_Graphe_Pleine(File,G);
                    PageRank_Pleine_Inst.Calculer_S(G);
                    PageRank_Pleine_Inst.Calculer_G(G, alpha);

                    -- Calcul de Pi Transpose contenu dans la structure Resultat
                    PageRank_Result_Inst.Initialiser(Resultat);
                    PageRank_Pleine_Inst.Calculer_Pi_Transpose(Resultat);

                    -- Algorithme PageRank
                    PageRank_Pleine_Inst.Iterer(Resultat.Poids, G, K, Epsilon);

                    -- Tri des sommets par ordre décroissant de poids
                    PageRank_Result_Inst.Trier(Resultat);

                    -- Enregistrement des résultats dans un fichier
                    PageRank_Result_Inst.Enregistrer(Resultat, Prefixe, Alpha, K);
                end;
            else
                -- Cas Matrices Creuses
                declare

                    package PageRank_Creuse_Inst is new PageRank_Creuse(Matrices_Creuses_Float, PageRank_Result_Inst);

                    S : Matrices_Creuses_Float.T_Matrice;
                    Facteurs : Matrices_Creuses_Float.T_Facteurs;
                    Resultat : T_Resultat;

                begin
                    Matrices_Creuses_Float.Initialiser(S);

                    -- Lecture du fichier d'entrée (Lignes_non_nulles contient le nombre d'éléments non nuls sur la ligne d'indice i)
                    Completer_Graphe_Creuse(File,S, Facteurs);

                    --Calcul de Pi Transpose contenu dans la structure Resultat
                    PageRank_Result_Inst.Initialiser(Resultat);
                    PageRank_Creuse_Inst.Calculer_Pi_Transpose(Resultat);

                    -- Algorithme PageRank
                    PageRank_Creuse_Inst.Iterer(Resultat.Poids, S,Facteurs,  K, Epsilon, Alpha, Taille);
                    -- Tri des sommets par ordre décroissant de poids
                    PageRank_Result_Inst.Trier(Resultat);

                    -- Enregistrement des résultats dans un fichier
                    PageRank_Result_Inst.Enregistrer(Resultat, Prefixe, Alpha, K);
                end;
            end if;
        end;
        exception
            when ADA.IO_EXCEPTIONS.NAME_ERROR=>
                Put_Line("Le fichier " & Fichier_Nom & " n'existe pas");

    end Algorithme_PageRank;
end PageRank;