with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Ada.IO_Exceptions;
with Lire_Graphe;
with Matrices_Pleines;
with Matrices_Creuses; use Matrices_Creuses;
with PageRank_Pleine;
with PageRank_Creuse;
with PageRank_Result;

with Vecteurs_Creux; use Vecteurs_Creux;

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

            package Matrices_Pleines_Float is new Matrices_Pleines(Taille, Taille);
            use Matrices_Pleines_Float;


            package Lire_Graphe_Inst is new Lire_Graphe(Matrices_Pleines_Float); use Lire_Graphe_Inst;


            package PageRank_Result_Inst is new PageRank_Result(Taille);
            use PageRank_Result_Inst;
        begin

            if Pleine then
                declare
                    package PageRank_Pleine_Inst is new PageRank_Pleine(Matrices_Pleines_Float, PageRank_Result_Inst);

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
                    package PageRank_Creuse_Inst is new PageRank_Creuse(PageRank_Result_Inst);

                    S : Matrices_Creuses.T_Matrice;
                    Resultat : T_Resultat;
                begin
                    Matrices_Creuses.Initialiser(S);
                    --Completer_Graphe_Creuse(File,S, Taille);
                    --PageRank_Creuse_Inst.Calculer_S(S, Taille);

                     Matrices_Creuses.Modifier(S, 2, 3, 1.0);
                     Matrices_Creuses.Modifier(S, 1, 3, 2.0);
                      Matrices_Creuses.Modifier(S, 1, 2, 3.0);
                      Matrices_Creuses.Modifier(S, 3, 1, 4.0);
                      Matrices_Creuses.Modifier(S, 6, 2, 5.0);
                      Matrices_Creuses.Modifier(S, 3, 2, 6.0);
                    new_line;
                    Matrices_Creuses.Afficher(S);
                      Matrices_Creuses.Modifier(S, 6, 1, 8.0);
                    new_line;

                    Matrices_Creuses.Afficher(S);

                     Matrices_Creuses.Modifier(S, 2, 1, 7.0);
                    new_line;

                Matrices_Creuses.Afficher(S);
                new_line;new_line;new_line;
                Vecteurs_Creux.Afficher(Plus_Haut_Maillon(S, 2, 9));
                new_line;new_line;new_line;
                    --  PageRank_Result_Inst.Initialiser(Resultat);
                    --  PageRank_Creuse_Inst.Calculer_Pi_Transpose(Resultat, Taille);


                    PageRank_Creuse_Inst.Iterer(Resultat.Poids, S, K, Epsilon, Alpha, Taille);
                    PageRank_Result_Inst.Trier(Resultat);
                     PageRank_Result_Inst.Enregistrer(Resultat, Prefixe, Alpha, K);
                end;
            end if;
        end;
        exception
            when ADA.IO_EXCEPTIONS.NAME_ERROR=>
                Put_Line("Le fichier " & Fichier_Nom & " n'existe pas");

    end Algorithme_PageRank;
end PageRank;